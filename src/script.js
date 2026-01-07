// Handle Screenshot Button Click
document.getElementById('screenshot-button').addEventListener('click', () => {
    // Send a message to the main process to capture a full-screen screenshot
    window.ipcRenderer.send('capture-screenshot');
});

// Handle Region Button Click
document.getElementById('region-button').addEventListener('click', () => {
    // Send a message to the main process to show the overlay for region selection
    window.ipcRenderer.send('show-overlay');
});

// Handle Full-Screen Screenshot Captured Event
window.ipcRenderer.on('screenshot-captured', (_event, data) => {
    console.log('Screenshot URL:', data.screenshotURL);
    console.log('Extracted Text:', data.extractedText);
    console.log('OpenRouter Response:', data.openRouterResponse);

    // Display the extracted text and OpenRouter response in the UI
    document.getElementById('extracted-text').innerText = `Extracted Text: ${data.extractedText}\nOpenRouter Response: ${data.openRouterResponse}`;
});

// Handle Cropped Screenshot Captured Event
window.ipcRenderer.on('cropped-screenshot', (_event, data) => {
    console.log('Cropped Screenshot URL:', data.croppedURL);
    console.log('Extracted Text:', data.extractedText);
    console.log('OpenRouter Response:', data.openRouterResponse);

    // Display the extracted text and OpenRouter response in the UI
    document.getElementById('extracted-text').innerText = `Extracted Text: ${data.extractedText}\nOpenRouter Response: ${data.openRouterResponse}`;
});

// Handle Errors
window.ipcRenderer.on('screenshot-error', (_event, errorMessage) => {
    console.error('Error:', errorMessage);
    alert(`Error: ${errorMessage}`);
});