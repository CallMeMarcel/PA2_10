import { Link } from "@inertiajs/react";
import { useState } from "react";

export default function AdminLayout({ children }) {
    const [searchQuery, setSearchQuery] = useState("");
    
    return (
        <div className="flex h-screen bg-white">
            {/* Sidebar */}
            <aside className="w-64 bg-white border-r border-gray-100 flex flex-col">
                {/* Logo */}
                <div className="p-4 flex items-center">
                    <div className="bg-gradient-to-r from-emerald-400 to-teal-500 w-8 h-8 rounded flex items-center justify-center mr-2">
                        <span className="text-white font-bold">DEL</span>
                    </div>
                    <span className="text-gray-700 font-medium">Del Cafe</span>
                </div>
                
                <div className="px-4 py-2">
                    <div className="text-xs text-gray-500 mb-2">HOMEPAGE</div>
                    <nav>
                        <ul className="space-y-1">
                            <li>
                                <Link 
                                    href="/admin/dashboard" 
                                    className="flex items-center px-3 py-2 text-sm rounded-md hover:bg-gray-50 text-gray-700"
                                >
                                    <span className="mr-2">🏠</span> 
                                    Dashboard
                                </Link>
                            </li>
                            <li>
                                <Link 
                                    href="/admin/kategori" 
                                    className="flex items-center px-3 py-2 text-sm rounded-md hover:bg-gray-50 text-gray-700"
                                >
                                    <span className="mr-2">📦</span> 
                                    Kategori
                                </Link>
                            </li>
                            <li>
                                <Link 
                                    href="/admin/produk" 
                                    className="flex items-center px-3 py-2 text-sm rounded-md hover:bg-gray-50 text-gray-700"
                                >
                                    <span className="mr-2">📊</span> 
                                    Produk
                                </Link>
                            </li>
                            <li>
                                <Link 
                                    href="/admin/analytics" 
                                    className="flex items-center px-3 py-2 text-sm rounded-md hover:bg-gray-50 text-gray-700"
                                >
                                    <span className="mr-2">📈</span> 
                                    Analytics
                                    <span className="ml-2 px-1.5 py-0.5 text-xs bg-orange-100 text-orange-600 rounded">New</span>
                                </Link>
                            </li>
                            <li>
                                <Link 
                                    href="/admin/hrm" 
                                    className="flex items-center px-3 py-2 text-sm rounded-md hover:bg-gray-50 text-gray-700"
                                >
                                    <span className="mr-2">👥</span> 
                                    HRM
                                    <span className="ml-2 px-1.5 py-0.5 text-xs bg-orange-100 text-orange-600 rounded">New</span>
                                </Link>
                            </li>
                        </ul>
                    </nav>
                </div>
                
                <div className="px-4 py-2">
                    <div className="text-xs text-gray-500 mb-2">APPS</div>
                    <nav>
                        <ul className="space-y-1">
                            <li>
                                <Link 
                                    href="/admin/e-commerce" 
                                    className="flex items-center px-3 py-2 text-sm rounded-md hover:bg-gray-50 text-gray-700"
                                >
                                    <span className="mr-2">🛒</span> 
                                    E-commerce
                                    <span className="ml-auto text-orange-500">•</span>
                                </Link>
                            </li>
                            <li>
                                <Link 
                                    href="/admin/crm" 
                                    className="flex items-center px-3 py-2 text-sm rounded-md hover:bg-gray-50 text-gray-700"
                                >
                                    <span className="mr-2">📱</span> 
                                    CRM
                                    <span className="ml-2 px-1.5 py-0.5 text-xs bg-orange-100 text-orange-600 rounded">New</span>
                                </Link>
                            </li>
                        </ul>
                    </nav>
                </div>
                
                <div className="px-4 py-2 mt-auto">
                    <div className="text-xs text-gray-500 mb-2">PAGES</div>
                    <nav>
                        <ul className="space-y-1">
                            <li>
                                <Link 
                                    href="/admin/starter" 
                                    className="flex items-center px-3 py-2 text-sm rounded-md hover:bg-gray-50 text-gray-700"
                                >
                                    <span className="mr-2">🚀</span> 
                                    Starter
                                </Link>
                            </li>
                            <li>
                                <Link 
                                    href="/admin/notifications" 
                                    className="flex items-center px-3 py-2 text-sm rounded-md hover:bg-gray-50 text-gray-700"
                                >
                                    <span className="mr-2">🔔</span> 
                                    Notifications
                                </Link>
                            </li>
                        </ul>
                    </nav>
                </div>
                
                <div className="mt-auto p-4 border-t border-gray-100">
                    <Link 
                        href="/logout" 
                        method="post" 
                        as="button"
                        className="text-sm text-gray-600 hover:text-gray-900 flex items-center w-full"
                    >
                        <span className="mr-2">🔄</span> Collapse
                    </Link>
                </div>
            </aside>

            {/* Main Content */}
            <div className="flex-1 flex flex-col overflow-hidden">
                {/* Header */}
                <header className="bg-white border-b border-gray-100 py-3 px-6 flex items-center">
                    <div className="flex-1 relative">
                        <div className="relative">
                            <span className="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-400">
                                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                                </svg>
                            </span>
                            <input
                                type="text"
                                className="w-64 bg-gray-100 border-0 rounded-full py-2 pl-10 pr-4 text-sm text-gray-700 placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-teal-500"
                                placeholder="Search"
                                value={searchQuery}
                                onChange={(e) => setSearchQuery(e.target.value)}
                            />
                        </div>
                    </div>
                    <div className="flex items-center space-x-4">
                        <button className="text-gray-500 hover:text-gray-600">
                            <span className="text-lg">🇬🇧</span>
                        </button>
                        <button className="text-gray-500 hover:text-gray-600">
                            <span className="text-lg">💡</span>
                        </button>
                        <button className="text-gray-500 hover:text-gray-600">
                            <span className="text-lg">🔔</span>
                        </button>
                        <button className="w-8 h-8 rounded-full bg-blue-500 text-white flex items-center justify-center">
                            <span className="text-sm font-medium">U</span>
                        </button>
                    </div>
                </header>

                {/* Content Area */}
                <main className="flex-1 overflow-auto bg-gray-50 p-6">
                    {children}
                </main>
            </div>
        </div>
    );
}