import { Link, usePage } from "@inertiajs/react";
import {
    FiLogOut, FiGrid, FiShoppingCart,
    FiFolder, FiClipboard, FiPlusSquare
} from "react-icons/fi";
import { useEffect } from "react";

function SidebarItem({ icon, label, href, isActive }) {
    return (
        <li>
            <Link
                href={href}
                className={`flex items-center gap-3 px-4 py-3 rounded-lg font-medium transition-all
                    ${isActive
                        ? "bg-[#5a4233] text-white shadow-md"
                        : "hover:bg-[#5a4233] hover:text-white text-gray-200"
                    }`}
            >
                {icon} {label}
            </Link>
        </li>
    );
}

export default function AdminLayout({ children }) {
    const { url, component } = usePage();

    // ✅ useEffect harus di dalam fungsi komponen
    useEffect(() => {
        if (typeof window !== "undefined") {
            import("bootstrap/dist/css/bootstrap.css");
            import("summernote/dist/summernote-bs4.css");
            import("summernote/dist/summernote-bs4.js");
            import("jquery").then(($) => {
                window.$ = window.jQuery = $;
            });
        }
    }, []);

    const navItems = [
        { label: "Dashboard", href: "/admin/dashboard", icon: <FiGrid />, match: "Admin/Dashboard" },
        { label: "Produk", href: "/admin/produk", icon: <FiShoppingCart />, match: "Admin/Produk" },
        { label: "Kategori", href: "/admin/kategori", icon: <FiFolder />, match: "Admin/Kategori" },
        { label: "Pesanan", href: "/admin/orders", icon: <FiClipboard />, match: "Admin/Orders" },
        { label: "Manual Order", href: route("admin.order.create"), icon: <FiPlusSquare />, match: "Admin/Order/Create" },
    ];

    return (
        <div className="flex h-screen bg-gradient-to-br from-[#fdfaf6] to-[#f5eee5] overflow-hidden">
            {/* Sidebar */}
            <aside className="w-64 bg-[#3e2f23] text-white flex flex-col p-6 shadow-2xl z-10">
                <h2 className="text-3xl font-bold mb-12 tracking-widest text-center font-serif">
                    Cafe Del
                </h2>

                <nav className="flex-1">
                    <ul className="space-y-3">
                        {navItems.map((item, i) => (
                            <SidebarItem
                                key={i}
                                icon={item.icon}
                                label={item.label}
                                href={item.href}
                                isActive={component?.startsWith(item.match)}
                            />
                        ))}
                    </ul>
                </nav>

                {/* Logout */}
                <div className="mt-10">
                    <Link
                        href="/logout"
                        method="post"
                        as="button"
                        className="w-full flex items-center justify-center gap-2 px-4 py-3 bg-red-500 hover:bg-red-600 rounded-lg text-center transition font-semibold"
                    >
                        <FiLogOut /> Logout
                    </Link>
                </div>
            </aside>

            {/* Main Content */}
            <main className="flex-1 p-8 overflow-auto">
                <div className="bg-white p-8 rounded-3xl shadow-xl border border-gray-200 min-h-full transition-all">
                    {children}
                </div>
            </main>
        </div>
    );
}