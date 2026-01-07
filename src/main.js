const { app, BrowserWindow, ipcMain, screen, desktopCapturer, nativeImage } = require('electron');
const path = require('path');
const tesseract = require('tesseract.js');
const { OpenAI } = require('openai'); // Import OpenAI

let mainWindow;
let overlayWindow;

// Create Main Window
const createMainWindow = () => {
    mainWindow = new BrowserWindow({
        width: 800,
        height: 600,
        webPreferences: {
            preload: path.join(__dirname, 'preload.js'),
        },
    });

    mainWindow.loadFile(path.join(__dirname, 'index.html'));
};

// Create Overlay Window for Region Selection
const createOverlayWindow = () => {
    const { width, height } = screen.getPrimaryDisplay().size;

    overlayWindow = new BrowserWindow({
        width,
        height,
        transparent: true,
        frame: false,
        alwaysOnTop: true,
        skipTaskbar: true,
        fullscreen: true,
        resizable: false,
        closable: false,
        movable: false,
        webPreferences: {
            preload: path.join(__dirname, 'overlay-preload.js'),
            contextIsolation: true,
            nodeIntegration: false,
        },
    });

    overlayWindow.loadFile(path.join(__dirname, 'overlay.html'));
    overlayWindow.setIgnoreMouseEvents(false);
};

// Initialize the OpenRouter client
const client = new OpenAI({
    baseURL: "https://openrouter.ai/api/v1", // OpenRouter API endpoint
    apiKey: "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", // Replace with your OpenRouter API key
});

// Capture Full-Screen Screenshot
async function captureFullScreen() {
    try {
        const { width, height } = screen.getPrimaryDisplay().size;
        const sources = await desktopCapturer.getSources({
            types: ['screen'],
            thumbnailSize: { width, height },
        });

        if (sources.length === 0) throw new Error("No screen sources available.");
        const primarySource = sources.find(source => source.name.includes('Screen')) || sources[0];

        if (!primarySource) throw new Error("Primary screen source not found.");

        return primarySource.thumbnail; // Full Screenshot
    } catch (error) {
        console.error("Error capturing screen:", error);
        return null;
    }
}

// Extract Text from Image using Tesseract.js
function extractTextFromImage(image) {
    return new Promise((resolve, reject) => {
        tesseract.recognize(
            image,
            'eng', // Language (English)
            {
                logger: (m) => console.log(m),
            }
        ).then(({ data: { text } }) => {
            resolve(text); // Return the extracted text
        }).catch((error) => {
            reject(error);
        });
    });
}

// Crop Screenshot in Main Process
function cropImage(image, rect) {
    try {
        // Convert the screenshot to a native image
        const img = nativeImage.createFromDataURL(image.toDataURL());

        // Crop the image based on the provided rectangle
        const cropped = img.crop({
            x: rect.x,
            y: rect.y,
            width: rect.width,
            height: rect.height,
        });

        return cropped.toDataURL(); // Return the cropped image as a data URL
    } catch (error) {
        console.error("Error cropping image:", error);
        throw error;
    }
}

// Send Extracted Text to OpenRouter API
async function sendTextToOpenRouter(text) {
    try {
        console.log("Sending text to OpenRouter:", text); // Log the input text

        const chat = await client.chat.completions.create({
            model: "openai/gpt-3.5-turbo", // Use a supported model
            messages: [
                {
                    role: "system",
                    content: "You are a helpful assistant."
                },
                {
                    role: "user",
                    content: text, // Send the extracted text
                },
            ],
        });

        // Log the entire response for debugging
        console.log("OpenRouter API Response:", JSON.stringify(chat, null, 2));

        // Validate the response
        if (!chat || !chat.choices || chat.choices.length === 0) {
            throw new Error("Invalid or empty response from OpenRouter API.");
        }

        // Return the assistant's reply
        return chat.choices[0].message.content;
    } catch (error) {
        console.error("Error sending text to OpenRouter:", error);

        // Provide more detailed error messages
        if (error.response) {
            console.error("API Response Error:", error.response.status, error.response.data);
            throw new Error(`API Error: ${error.response.status} - ${JSON.stringify(error.response.data)}`);
        } else if (error.request) {
            console.error("No response received from API:", error.request);
            throw new Error("No response received from OpenRouter API. Check your network connection.");
        } else {
            console.error("Unexpected error:", error.message);
            throw new Error(`Unexpected error: ${error.message}`);
        }
    }
}

// IPC: Capture Screenshot
ipcMain.on('capture-screenshot', async (event) => {
    try {
        const screenshot = await captureFullScreen();
        if (!screenshot) throw new Error("Screenshot capture failed.");

        // Extract Text from Screenshot
        const extractedText = await extractTextFromImage(screenshot.toDataURL());

        // Send the extracted text to OpenRouter API
        const openRouterResponse = await sendTextToOpenRouter(extractedText);

        // Send the screenshot and OpenRouter response to the renderer
        event.sender.send('screenshot-captured', {
            screenshotURL: screenshot.toDataURL(),
            extractedText,
            openRouterResponse,
        });
    } catch (error) {
        console.error("Screenshot capture, OCR, or OpenRouter API error:", error);
        event.sender.send('screenshot-error', error.message);
    }
});

// IPC: Handle Region Selection
ipcMain.on('region-selected', async (_event, rect) => {
    try {
        const screenshot = await captureFullScreen();
        if (!screenshot) throw new Error("Screenshot capture failed.");

        // Crop the screenshot based on the selected region
        const croppedScreenshot = cropImage(screenshot, rect);

        // Extract Text from the cropped region
        const extractedText = await extractTextFromImage(croppedScreenshot);

        // Send the extracted text to OpenRouter API
        const openRouterResponse = await sendTextToOpenRouter(extractedText);

        // Send the cropped screenshot and OpenRouter response to the renderer
        if (mainWindow) {
            mainWindow.webContents.send('cropped-screenshot', {
                croppedURL: croppedScreenshot,
                extractedText,
                openRouterResponse,
            });
        }

        // Close overlay window after sending data
        if (overlayWindow && !overlayWindow.isDestroyed()) {
            overlayWindow.close();
            overlayWindow = null;
        }
    } catch (error) {
        console.error("Cropping, OCR, or OpenRouter API error:", error);
        if (mainWindow) {
            mainWindow.webContents.send('screenshot-error', error.message);
        }
    }
});

// IPC: Show Overlay for Region Selection
ipcMain.on('show-overlay', () => {
    createOverlayWindow();
});

// App Ready
app.whenReady().then(() => {
    createMainWindow();
    app.on('activate', () => {
        if (BrowserWindow.getAllWindows().length === 0) {
            createMainWindow();
        }
    });
});

// Close App on All Windows Closed
app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit();
});