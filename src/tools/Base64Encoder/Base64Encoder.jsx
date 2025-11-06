import { useState } from 'react';
import './Base64Encoder.css';
import { encode, decode, isValidBase64 } from './Base64Encoder.utils';

function Base64Tool() {
  const [input, setInput] = useState('');
  const [output, setOutput] = useState('');
  const [mode, setMode] = useState('encode'); // 'encode' or 'decode'
  const [error, setError] = useState('');

  const handleConvert = () => {
    setError('');
    try {
      if (mode === 'encode') {
        const encoded = encode(input);
        setOutput(encoded);
      } else {
        if (!isValidBase64(input)) {
          setError('Invalid Base64 input');
          return;
        }
        const decoded = decode(input);
        setOutput(decoded);
      }
    } catch (err) {
      setError(`Error: ${err.message}`);
    }
  };

  const handleClear = () => {
    setInput('');
    setOutput('');
    setError('');
  };

  const handleCopy = async () => {
    try {
      await navigator.clipboard.writeText(output);
      // You could add a toast notification here
      alert('Copied to clipboard!');
    } catch (err) {
      console.error('Failed to copy:', err);
    }
  };

  const handleSwap = () => {
    setInput(output);
    setOutput(input);
    setMode(mode === 'encode' ? 'decode' : 'encode');
  };

  return (
    <div className="max-w-4xl mx-auto">
      <div className="mb-6 text-right p-2">
        <a href="/" className="back-link"><i className="fas fa-arrow-left"></i> Back to Tools</a>
      </div>
      {/* Page Header */}
      <div className="mb-6">
        <div className="flex items-center gap-3 mb-2">
          <i className="fa-solid fa-lock text-3xl text-blue-600"></i>
          <h1 className="text-3xl font-bold text-gray-800">Base64 Encoder/Decoder</h1>
        </div>
        <p className="text-gray-600">
          Encode or decode text using Base64 encoding
        </p>
      </div>

      {/* Mode Selector */}
      <div className="bg-white rounded-lg shadow p-4 mb-6">
        <div className="flex gap-2">
          <button
            className={`flex-1 py-2 px-4 rounded-lg font-medium transition-all ${
              mode === 'encode'
                ? 'bg-blue-600 text-white shadow-md'
                : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
            }`}
            onClick={() => setMode('encode')}
          >
            <i className="fa-solid fa-arrow-down mr-2"></i>
            Encode
          </button>
          <button
            className={`flex-1 py-2 px-4 rounded-lg font-medium transition-all ${
              mode === 'decode'
                ? 'bg-blue-600 text-white shadow-md'
                : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
            }`}
            onClick={() => setMode('decode')}
          >
            <i className="fa-solid fa-arrow-up mr-2"></i>
            Decode
          </button>
        </div>
      </div>

      {/* Input Section */}
      <div className="bg-white rounded-lg shadow p-6 mb-4">
        <label className="block text-sm font-semibold text-gray-700 mb-2">
          Input
        </label>
        <textarea
          value={input}
          onChange={(e) => setInput(e.target.value)}
          placeholder={
            mode === 'encode'
              ? 'Enter text to encode...'
              : 'Enter Base64 to decode...'
          }
          className="w-full h-40 p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent font-mono text-sm"
          rows={6}
        />
        <div className="text-xs text-gray-500 mt-2">
          {input.length} characters
        </div>
      </div>

      {/* Action Buttons */}
      <div className="flex gap-2 mb-4 flex-wrap">
        <button
          onClick={handleConvert}
          className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-lg font-medium transition-all shadow hover:shadow-md flex items-center gap-2"
        >
          <i className="fa-solid fa-play"></i>
          {mode === 'encode' ? 'Encode' : 'Decode'}
        </button>
        <button
          onClick={handleSwap}
          className="bg-gray-600 hover:bg-gray-700 text-white px-6 py-2 rounded-lg font-medium transition-all shadow hover:shadow-md flex items-center gap-2"
        >
          <i className="fa-solid fa-arrow-right-arrow-left"></i>
          Swap
        </button>
        <button
          onClick={handleClear}
          className="bg-red-600 hover:bg-red-700 text-white px-6 py-2 rounded-lg font-medium transition-all shadow hover:shadow-md flex items-center gap-2"
        >
          <i className="fa-solid fa-trash"></i>
          Clear
        </button>
      </div>

      {/* Output Section */}
      <div className="bg-white rounded-lg shadow p-6 mb-4">
        <div className="flex justify-between items-center mb-2">
          <label className="block text-sm font-semibold text-gray-700">
            Output
          </label>
          <button
            onClick={handleCopy}
            disabled={!output}
            className="text-sm text-blue-600 hover:text-blue-700 disabled:text-gray-400 disabled:cursor-not-allowed flex items-center gap-1"
          >
            <i className="fa-solid fa-copy"></i>
            Copy
          </button>
        </div>
        <textarea
          value={output}
          readOnly
          placeholder="Result will appear here..."
          className="w-full h-40 p-3 border border-gray-300 rounded-lg bg-gray-50 font-mono text-sm"
          rows={6}
        />
        <div className="text-xs text-gray-500 mt-2">
          {output.length} characters
        </div>
      </div>

      {/* Error Message */}
      {error && (
        <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-4 flex items-center gap-2">
          <i className="fa-solid fa-circle-exclamation"></i>
          {error}
        </div>
      )}

      {/* Info Section */}
      <div className="bg-blue-50 border border-blue-200 rounded-lg p-6">
        <h3 className="font-semibold text-gray-800 mb-3 flex items-center gap-2">
          <i className="fa-solid fa-circle-info text-blue-600"></i>
          About Base64 Encoding
        </h3>
        <p className="text-gray-700 text-sm mb-3">
          Base64 is a binary-to-text encoding scheme that represents binary data
          in an ASCII string format. It's commonly used to encode data that needs
          to be stored and transferred over media designed to deal with text.
        </p>
        <ul className="text-sm text-gray-700 space-y-1">
          <li className="flex items-start gap-2">
            <i className="fa-solid fa-check text-blue-600 mt-1"></i>
            <span>Used in email via MIME</span>
          </li>
          <li className="flex items-start gap-2">
            <i className="fa-solid fa-check text-blue-600 mt-1"></i>
            <span>Data URLs in web pages</span>
          </li>
          <li className="flex items-start gap-2">
            <i className="fa-solid fa-check text-blue-600 mt-1"></i>
            <span>Storing complex data in XML or JSON</span>
          </li>
        </ul>
      </div>
    </div>
  );
}

export default Base64Tool;





