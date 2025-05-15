import AdminLayout from "@/Layouts/AdminLayout";
import { Link } from "@inertiajs/react";

export default function OrderIndex({ orders }) {
    return (
        <AdminLayout>
            <div className="p-6 bg-white rounded shadow">
                <div className="flex justify-between items-center mb-4">
                    <h2 className="text-2xl font-bold">Daftar Manual Order</h2>
                    <Link
                        href={route("admin.order.create")}
                        className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700"
                    >
                        + Buat Order Manual
                    </Link>
                </div>

                <table className="w-full border">
                    <thead>
                        <tr className="bg-gray-100">
                            <th className="text-left p-2 border">No. Order</th>
                            <th className="text-left p-2 border">Total</th>
                            <th className="text-left p-2 border">Status</th>
                            <th className="text-left p-2 border">Metode Pembayaran</th>
                            <th className="text-left p-2 border">Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        {orders.length ? (
                            orders.map((order) => (
                                <tr key={order.id}>
                                    <td className="p-2 border">{order.order_number}</td>
                                    <td className="p-2 border">Rp{order.total_amount.toLocaleString()}</td>
                                    <td className="p-2 border capitalize">{order.status}</td>
                                    <td className="p-2 border">{order.payment_method || '-'}</td>
                                    <td className="p-2 border">
                                        <Link
                                            href={route("admin.orders.index") + "/" + order.id}
                                            className="text-blue-600 hover:underline"
                                        >
                                            Detail
                                        </Link>
                                    </td>
                                </tr>
                            ))
                        ) : (
                            <tr>
                                <td colSpan="5" className="text-center py-4 text-gray-500">
                                    Belum ada order manual
                                </td>
                            </tr>
                        )}
                    </tbody>
                </table>
            </div>
        </AdminLayout>
    );
}
