import { Link } from 'react-router-dom';

function Home() {
  // Define your tools here
  const tools = [
    {
      id: 'base64',
      title: 'Base64 Encoder/Decoder',
      description: 'Encode and decode text using Base64 encoding',
      icon: 'fa-solid fa-lock',
      path: '/tools/Base64Encoder',
      color: 'blue'
    },
    {
      id: 'json',
      title: 'JSON Formatter',
      description: 'Format and validate JSON data',
      icon: 'fa-solid fa-code',
      path: '/json',
      color: 'green'
    },
    {
      id: 'hash',
      title: 'Hash Generator',
      description: 'Generate MD5, SHA-1, SHA-256 hashes',
      icon: 'fa-solid fa-hashtag',
      path: '/hash',
      color: 'purple'
    },
    {
      id: 'url',
      title: 'URL Encoder/Decoder',
      description: 'Encode and decode URLs',
      icon: 'fa-solid fa-link',
      path: '/url',
      color: 'orange'
    },
    {
      id: 'timestamp',
      title: 'Timestamp Converter',
      description: 'Convert between timestamps and dates',
      icon: 'fa-solid fa-clock',
      path: '/timestamp',
      color: 'red'
    },
    {
      id: 'uuid',
      title: 'UUID Generator',
      description: 'Generate unique identifiers',
      icon: 'fa-solid fa-fingerprint',
      path: '/uuid',
      color: 'indigo'
    }
  ];

  const colorClasses = {
    blue: 'bg-blue-50 border-blue-200 hover:border-blue-400',
    green: 'bg-green-50 border-green-200 hover:border-green-400',
    purple: 'bg-purple-50 border-purple-200 hover:border-purple-400',
    orange: 'bg-orange-50 border-orange-200 hover:border-orange-400',
    red: 'bg-red-50 border-red-200 hover:border-red-400',
    indigo: 'bg-indigo-50 border-indigo-200 hover:border-indigo-400'
  };

  const iconColorClasses = {
    blue: 'text-blue-600',
    green: 'text-green-600',
    purple: 'text-purple-600',
    orange: 'text-orange-600',
    red: 'text-red-600',
    indigo: 'text-indigo-600'
  };

  return (
    <div>
      <p className="mb-6 text-lg text-gray-600">
        A collection of small proof-of-concept tools and experiments by Amr Shah.
      </p>
      
      <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-6">
        {tools.map((tool) => (
          <Link
            key={tool.id}
            to={tool.path}
            className={`block p-6 rounded-lg border-2 transition-all duration-200 hover:shadow-lg transform hover:-translate-y-1 ${colorClasses[tool.color]}`}
          >
            <div className="flex items-start gap-4">
              <div className={`text-3xl ${iconColorClasses[tool.color]}`}>
                <i className={tool.icon}></i>
              </div>
              <div className="flex-1">
                <h3 className="text-xl font-semibold text-gray-800 mb-2">
                  {tool.title}
                </h3>
                <p className="text-gray-600 text-sm">
                  {tool.description}
                </p>
              </div>
            </div>
          </Link>
        ))}
      </div>
    </div>
  );
}

export default Home;