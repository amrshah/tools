import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Layout from './components/Layout';
import Home from './pages/Home';


// Import our tool components here
 import Base64Encoder from './tools/Base64Encoder/Base64Encoder';
// import JsonFormatter from './tools/JsonFormatter/JsonFormatter';
// import HashGenerator from './tools/HashGenerator/HashGenerator';
// import UrlEncoder from './tools/UrlEncoder/UrlEncoder';
// import TimestampConverter from './tools/TimestampConverter/TimestampConverter';
// import UuidGenerator from './tools/UuidGenerator/UuidGenerator';

function App() {
  return (
    <BrowserRouter basename="/">
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<Home />} />
          <Route path="/tools/Base64Encoder" element={<Base64Encoder />} />

          
          {/* Add your tool routes here */}
          {/* <Route path="base64" element={<Base64Tool />} /> */}
          {/* <Route path="json" element={<JsonFormatter />} /> */}
          {/* <Route path="hash" element={<HashGenerator />} /> */}
          {/* <Route path="url" element={<UrlEncoder />} /> */}
          {/* <Route path="timestamp" element={<TimestampConverter />} /> */}
          {/* <Route path="uuid" element={<UuidGenerator />} /> */}
          
          {/* 404 Page */}
          <Route path="*" element={
            <div className="text-center py-20">
              <h1 className="text-4xl font-bold text-gray-800 mb-4">404</h1>
              <p className="text-gray-600">Tool not found</p>
            </div>
          } />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;