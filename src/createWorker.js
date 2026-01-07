const { createWorker } = require("tesseract.js");



async function recognizeText(imagePath) {
    await worker.load();
    await worker.loadLanguage("eng");
    await worker.initialize("eng");

    const { data: { text } } = await worker.recognize(imagePath);
    await worker.terminate(); // ✅ Prevent memory leaks

    return text;
}

module.exports = recognizeText;
