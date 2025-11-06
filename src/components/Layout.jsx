import { Outlet } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';

function Layout() {
  return (
    <div className="min-h-screen flex flex-col bg-gray-100">
      <Header />
      <main className="flex-grow max-w-6xl mx-auto px-6 w-full">
        <Outlet />
      </main>
      <Footer />
    </div>
  );
}

export default Layout;