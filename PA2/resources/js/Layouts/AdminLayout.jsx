import { Link } from "@inertiajs/react";

export default function AdminLayout({ children }) {
    return (
        <div className="flex h-screen bg-[#fdfaf6]">
            {/* Sidebar */}
            <aside className="w-64 bg-[#3e2f23] text-white p-6 flex flex-col shadow-lg">
                <h2 className="text-2xl font-bold mb-6 tracking-wide">☕ Cafe Del</h2>

                <nav className="flex-1">
                    <ul className="space-y-3">
                        <li>
                            <Link 
                                href="/admin/dashboard" 
                                className="block p-2 rounded-lg hover:bg-[#5a4233] transition font-medium"
                            >
                                📊 Dashboard
                            </Link>
                        </li>
                        <li>
                            <Link 
                                href="/admin/produk" 
                                className="block p-2 rounded-lg hover:bg-[#5a4233] transition font-medium"
                            >
                                🛒 Produk
                            </Link>
                        </li>
                        <li>
                            <Link 
                                href="/admin/kategori" 
                                className="block p-2 rounded-lg hover:bg-[#5a4233] transition font-medium"
                            >
                                🗂️ Kategori
                            </Link>
                        </li>
                        <li>
                            <Link 
                                href="/admin/orders" 
                                className="block p-2 rounded-lg hover:bg-[#5a4233] transition font-medium"
                            >
                                Pesanan
                            </Link>
                        </li>
                        <li>
                        <Link
                            href={route('admin.order.create')}
                            className="block p-2 rounded-lg hover:bg-[#5a4233] transition font-medium"
                            >
                            Manual Order
                        </Link>


                        </li>
                    </ul>
                </nav>

                {/* Logout Button */}
                <div className="mt-auto">
                    <Link 
                        href="/logout" 
                        method="post" 
                        as="button" 
                        className="w-full p-2 bg-red-500 hover:bg-red-600 rounded-lg text-center transition font-semibold"
                    >
                        🔓 Logout
                    </Link>
                </div>
            </aside>

            {/* Main Content */}
            <main className="flex-1 p-8 overflow-auto bg-[#fdfaf6]">
                <div className="bg-white p-6 rounded-xl shadow-md border border-gray-200">
                    {children}
                </div>
            </main>
        </div>
    );
}
