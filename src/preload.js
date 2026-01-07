const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('screenshot', {
    captureScreenShot: () => {
        ipcRenderer.send('capture-screenshot');
    },
    screenShotCaptured: (callback) => {
        ipcRenderer.on('screenshot-captured', (event, screenshotURL) => callback(event, screenshotURL));
    },
    croppedScreenShot: (callback) => {
        ipcRenderer.on('cropped-screenshot', (event, croppedURL) => callback(event, croppedURL));
    },
});

contextBridge.exposeInMainWorld('ipcRenderer', {
    send: (channel, data) => ipcRenderer.send(channel, data),
    on: (channel, callback) => ipcRenderer.on(channel, callback),
});
