import { Head, Link } from "@inertiajs/react";
import AdminLayout from "@/Layouts/AdminLayout";
import { FaBoxOpen, FaClipboardList, FaTags } from "react-icons/fa";

export default function Dashboard({ stats = { kategori: 0, produk: 0, orders: 0 } }) {
    return (
        <AdminLayout>
            <Head title="Admin Dashboard" />
            <div className="bg-white p-6 shadow-md rounded-lg">
                <h1 className="text-2xl font-bold mb-2">Selamat Datang, Admin 👋</h1>
                <p className="text-gray-600 leading-relaxed">
                    Gunakan panel ini untuk mengelola produk, kategori, dan pesanan dari pelanggan dengan mudah dan cepat.
                </p>
            </div>
            
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
                <StatCard
                    title="Total Kategori"
                    value={stats.kategori}
                    href="/admin/kategori"
                    icon={<FaTags size={28} />}
                    gradient="from-indigo-500 to-indigo-700"
                />
                <StatCard
                    title="Total Produk"
                    value={stats.produk}
                    href="/admin/produk"
                    icon={<FaBoxOpen size={28} />}
                    gradient="from-green-500 to-green-700"
                />
                <StatCard
                    title="Total Pesanan"
                    value={stats.orders}
                    href="/admin/orders"
                    icon={<FaClipboardList size={28} />}
                    gradient="from-yellow-500 to-yellow-600"
                />
            </div>
        </AdminLayout>
    );
}

function StatCard({ title, value, href, icon, gradient }) {
    return (
        <Link
            href={href}
            className={`bg-gradient-to-br ${gradient} text-white p-6 rounded-2xl shadow-lg transform hover:scale-105 transition duration-300`}
        >
            <div className="flex items-center justify-between">
                <div>
                    <h3 className="text-lg font-medium">{title}</h3>
                    <p className="text-3xl font-bold mt-2">{value}</p>
                    <p className="mt-1 text-sm underline">Lihat detail</p>
                </div>
                <div className="opacity-80">{icon}</div>
            </div>
        </Link>
    );
}