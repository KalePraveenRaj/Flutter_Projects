let isSelecting = false;
let startX, startY, endX, endY;
const selectionBox = document.getElementById('selection-box');

document.addEventListener('mousedown', (e) => {
    isSelecting = true;
    startX = e.clientX;
    startY = e.clientY;
    selectionBox.style.left = `${startX}px`;
    selectionBox.style.top = `${startY}px`;
    selectionBox.style.width = '0px';
    selectionBox.style.height = '0px';
});

document.addEventListener('mousemove', (e) => {
    if (isSelecting) {
        endX = e.clientX;
        endY = e.clientY;
        selectionBox.style.width = `${Math.abs(endX - startX)}px`;
        selectionBox.style.height = `${Math.abs(endY - startY)}px`;
        selectionBox.style.left = `${Math.min(startX, endX)}px`;
        selectionBox.style.top = `${Math.min(startY, endY)}px`;
    }
});

document.addEventListener('mouseup', () => {
    if (isSelecting) {
        isSelecting = false;
        const rect = {
            x: parseInt(selectionBox.style.left),
            y: parseInt(selectionBox.style.top),
            width: parseInt(selectionBox.style.width),
            height: parseInt(selectionBox.style.height),
        };

        window.ipcRenderer.send('region-selected', rect);
        window.close();
    }
});
