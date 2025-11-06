# React Setup Guide for POC-Tools

## Overview
This guide will help you set up a React-based structure with code obfuscation and GitHub Pages deployment for your POC-Tools repository.

## Project Structure

```
POC-Tools/
├── public/
│   ├── index.html
│   └── favicon.ico
├── src/
│   ├── tools/
│   │   ├── Tool1/
│   │   │   ├── Tool1.jsx
│   │   │   ├── Tool1.css
│   │   │   └── Tool1.utils.js
│   │   ├── Tool2/
│   │   │   ├── Tool2.jsx
│   │   │   ├── Tool2.css
│   │   │   └── Tool2.utils.js
│   │   └── index.js
│   ├── components/
│   │   ├── Layout.jsx
│   │   └── Navigation.jsx
│   ├── App.jsx
│   ├── App.css
│   └── index.js
├── .github/
│   └── workflows/
│       └── deploy.yml
├── package.json
├── vite.config.js
├── .gitignore
└── README.md
```

## Step-by-Step Setup

### 1. Initialize the Project

```bash
# Remove existing content (backup first if needed)
# Initialize new React project with Vite
npm create vite@latest . -- --template react

# Install dependencies
npm install

# Install additional dependencies
npm install react-router-dom
npm install -D javascript-obfuscator webpack-obfuscator
npm install -D gh-pages
```

### 2. Install Obfuscation Tools

```bash
npm install -D vite-plugin-javascript-obfuscator
```

### 3. Configure Package.json

Add these scripts to your `package.json`:

```json 
{
  "name": "poc-tools",
  "homepage": "https://amrshah.github.io/POC-Tools",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "predeploy": "npm run build",
    "deploy": "gh-pages -d dist"
  }
}
```

### 4. Create GitHub Actions Workflow

The workflow will automatically build and deploy to GitHub Pages on push to main.

### 5. Configure GitHub Repository

1. Go to repository Settings
2. Navigate to Pages
3. Set Source to "GitHub Actions"
4. Or if using gh-pages branch: Select "gh-pages" branch and root folder

### 6. Building Your Tools

Each tool should be a separate component with its own CSS/JS files:

**Example Tool Structure:**
```jsx
// src/tools/Base64Encoder/Base64Encoder.jsx
import React, { useState } from 'react';
import './Base64Encoder.css';
import { encode, decode } from './Base64Encoder.utils';

export default function Base64Encoder() {
  const [input, setInput] = useState('');
  const [output, setOutput] = useState('');
  
  return (
    <div className="base64-encoder">
      <h2>Base64 Encoder/Decoder</h2>
      {/* Tool UI here */}
    </div>
  );
}
```

**Separate Utility File:**
```javascript
// src/tools/Base64Encoder/Base64Encoder.utils.js
export function encode(text) {
  return btoa(text);
}

export function decode(text) {
  return atob(text);
}
```

**Separate CSS File:**
```css
/* src/tools/Base64Encoder/Base64Encoder.css */
.base64-encoder {
  padding: 20px;
  /* Tool-specific styles */
}
```

### 7. Main App Setup

```jsx
// src/App.jsx
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Layout from './components/Layout';
import Home from './pages/Home';
import Base64Encoder from './tools/Base64Encoder/Base64Encoder';
// Import other tools

function App() {
  return (
    <BrowserRouter basename="/POC-Tools">
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<Home />} />
          <Route path="base64" element={<Base64Encoder />} />
          {/* Add routes for other tools */}
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
```

### 8. Deployment

**Option 1: Manual Deployment**
```bash
npm run deploy
```

**Option 2: Automatic Deployment (via GitHub Actions)**
- Push to main branch
- GitHub Actions will automatically build and deploy

### 9. Code Obfuscation Notes

The Vite configuration includes obfuscation for production builds. The obfuscated code will:
- Rename variables and functions
- Remove comments and whitespace
- Make code harder to reverse engineer
- Each tool's CSS/JS will be in separate chunks for better code splitting

### 10. Environment Variables

Create `.env` file for any configuration:
```
VITE_APP_TITLE=POC Tools
VITE_BASE_PATH=/POC-Tools
```

### 11. Best Practices

1. **Keep tools modular** - Each tool in its own folder with CSS/JS
2. **Use code splitting** - Vite automatically splits code per route
3. **Optimize for production** - The build process minifies and obfuscates
4. **Test locally** - Use `npm run preview` before deploying
5. **Version control** - Commit source code, not build files

### 12. Updating Tools

When you add a new tool:
1. Create a new folder in `src/tools/`
2. Add component, CSS, and utility files
3. Add route in `App.jsx`
4. Add navigation link in your Layout component
5. Build and deploy

### 13. Accessing Your Tools

After deployment, your tools will be available at:
```
https://amrshah.github.io/POC-Tools/
https://amrshah.github.io/POC-Tools/base64
https://amrshah.github.io/POC-Tools/[tool-name]
```

## Benefits of This Setup

✅ **Modular Structure** - Each tool is independent
✅ **Code Obfuscation** - Production builds are obfuscated
✅ **Separate Files** - CSS/JS files are split per tool
✅ **Fast Development** - Hot reload with Vite
✅ **Automatic Deployment** - Push to GitHub and it deploys
✅ **Modern Tooling** - React, Vite, ES6+
✅ **GitHub Pages Ready** - Configured for GitHub Pages hosting

## Troubleshooting

**Issue: 404 on GitHub Pages**
- Ensure `basename` in BrowserRouter matches your repo name
- Check GitHub Pages settings

**Issue: Routes not working**
- Add a `404.html` file that redirects to `index.html`
- Use HashRouter instead of BrowserRouter if needed

**Issue: Build fails**
- Check for syntax errors
- Ensure all imports are correct
- Clear node_modules and reinstall
