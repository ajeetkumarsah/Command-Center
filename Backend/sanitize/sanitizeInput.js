function sanitizeInput(input) {
    const sanitizedInput = input.trim();
    if (/^[a-zA-Z0-9\s\W_]+$/.test(sanitizedInput)) {
        return sanitizedInput; // Return the sanitized input if it contains only alphabet and special characters
    } else {
        throw new Error('Invalid input'); // Throw an error for invalid input
    }
}

function getSanitizeInput(input){
    input = sanitizeInput(input)
}

module.exports = {
    getSanitizeInput
}
