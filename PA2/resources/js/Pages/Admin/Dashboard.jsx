import { Head } from "@inertiajs/react";
import AdminLayout from "@/Layouts/AdminLayout";
export default function Dashboard() {
    return (
        <AdminLayout>
            <Head title="Admin Dashboard" />
            <div className="p-6 bg-white shadow-md rounded-md">
                <h1 className="text-2xl font-bold mb-4">Welcome, Admin</h1>
                <p className="mb-4">This is your admin panel. Manage categories and products here.</p>
                
            </div>
        </AdminLayout>
    );
}
