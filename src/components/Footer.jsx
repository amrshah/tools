function Footer() {
  const currentYear = new Date().getFullYear();
  
  return (
    <footer className="mt-10 py-6 text-center text-sm text-gray-500">
      <p>© {currentYear} Amr Shah — Web Goodies</p>
    </footer>
  );
}

export default Footer;