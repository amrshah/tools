import { Link } from 'react-router-dom';

function Header() {
  return (
    <header className="bg-white shadow mb-8">
    <div className="max-w-6xl mx-auto p-6 flex justify-between items-center">
      <h1 className="text-2xl font-bold"><i className="fa-solid fa-globe text-black-600"></i> Web Goodies</h1>
      <a href="https://github.com/amrshah/POC-Tools" target="_blank"
         className="text-blue-600 hover:underline">GitHub Repo</a>
    </div>
  </header>
  );
}

export default Header;