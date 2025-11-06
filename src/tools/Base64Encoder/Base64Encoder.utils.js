// src/tools/Base64Tool/Base64Tool.utils.js
/**
 * Encode text to Base64
 * @param {string} text - Text to encode
 * @returns {string} Base64 encoded string
 */
export function encode(text) {
  if (!text) return '';
  return btoa(unescape(encodeURIComponent(text)));
}

/**
 * Decode Base64 to text
 * @param {string} base64 - Base64 string to decode
 * @returns {string} Decoded text
 */
export function decode(base64) {
  if (!base64) return '';
  return decodeURIComponent(escape(atob(base64)));
}

/**
 * Check if string is valid Base64
 * @param {string} str - String to validate
 * @returns {boolean} True if valid Base64
 */
export function isValidBase64(str) {
  if (!str) return false;
  const base64Regex = /^[A-Za-z0-9+/]*={0,2}$/;
  return base64Regex.test(str) && str.length % 4 === 0;
}