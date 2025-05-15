// resources/js/Pages/Admin/Produk/Dashboard.jsx
import { Link, useForm } from "@inertiajs/react";
import AdminLayout from "@/Layouts/AdminLayout";

export default function Dashboard({ categories, products }) {
    return (
        <AdminLayout>
            <AdminProduk products={products} categories={categories} />
        </AdminLayout>
    );
}

function AdminProduk({ products = [] }) {
    const { delete: destroy, put } = useForm();

    const handleDelete = (productId) => {
        if (confirm("Apakah Anda yakin ingin menghapus produk ini?")) {
            destroy(route("admin.produk.destroy", productId), {
                preserveScroll: true,
                onSuccess: () => alert("Produk berhasil dihapus"),
                onError: (errors) => console.log(errors),
            });
        }
    };

    const handleToggleStatus = (product) => {
        const newStatus = product.status === "available" ? "unavailable" : "available";
        put(route("admin.produk.toggle-status", product.id), {
            preserveScroll: true,
            data: { status: newStatus },
            onSuccess: () => alert("Status produk berhasil diperbarui"),
            onError: (errors) => console.error(errors),
        });
    };

    return (
        <div className="p-6 bg-white shadow-md rounded-xl">
            <h2 className="text-2xl font-bold mb-4">Kelola Produk</h2>

            <Link
                href={route("admin.produk.create")}
                className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700"
            >
                + Tambah Produk
            </Link>

            <table className="w-full mt-6 text-left border-collapse">
                <thead>
                    <tr className="bg-gray-100 text-sm uppercase text-gray-600 border-b">
                        <th className="p-3">Gambar</th>
                        <th className="p-3">Nama</th>
                        <th className="p-3">Deskripsi</th>
                        <th className="p-3">Harga</th>
                        <th className="p-3">Status</th>
                        <th className="p-3">Kategori</th>
                        <th className="p-3">Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    {products.map((product) => (
                        <tr key={product.id} className="border-t hover:bg-gray-50 transition">
                            <td className="p-3">
                                <img
                                    src={product.image ? /storage/${product.image} : "/images/default.png"}
                                    alt={product.title}
                                    className="w-14 h-14 object-cover rounded"
                                />
                            </td>
                            <td className="p-3">{product.title}</td>
                            <td className="p-3 text-sm text-gray-600">{product.description}</td>
                            <td className="p-3 font-semibold">Rp {product.price.toLocaleString()}</td>
                            <td className="p-3">
                                <span
                                    className={`inline-block px-3 py-1 rounded-full text-sm font-semibold ${
                                        product.status === "available"
                                            ? "bg-green-100 text-green-800"
                                            : "bg-red-100 text-red-800"
                                    }`}
                                >
                                    {product.status === "available" ? "Tersedia" : "Tidak Tersedia"}
                                </span>
                            </td>
                            <td className="p-3">{product.category?.name || "Tidak ada kategori"}</td>
                            <td className="p-3 flex gap-2">
                                <Link
                                    href={route("admin.produk.edit", product.id)}
                                    className="bg-yellow-500 text-white px-3 py-1 rounded hover:bg-yellow-600 text-sm"
                                >
                                    Edit
                                </Link>
                                <button
                                    onClick={() => handleDelete(product.id)}
                                    className="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 text-sm"
                                >
                                    Hapus
                                </button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}