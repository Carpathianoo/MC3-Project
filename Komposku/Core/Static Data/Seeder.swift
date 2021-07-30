//
//  Material.swift
//  Komposku
//
//  Created by Clara Anggraini on 28/07/21.
//

import Foundation

class Seeder{
 
    func seedMaterial() -> [Material]{
        var materials: [Material] = []
        
        let brownMaterialDetail =
            [MaterialDetail(name: "Bubuk Kopi", quantity: 0),
             MaterialDetail(name: "Sampah Kebun", quantity: 0),
             MaterialDetail(name: "Potongan Rumput", quantity: 0),
             MaterialDetail(name: "Sampah Dapur", quantity: 0),
             MaterialDetail(name: "Dedaunan Segar", quantity: 0),
             MaterialDetail(name: "Potongan Semak", quantity: 0),
             MaterialDetail(name: "Nasi", quantity: 0),
             MaterialDetail(name: "Kulit Telur", quantity: 0),
             MaterialDetail(name: "Sampah Buah", quantity: 0),
             MaterialDetail(name: "Sampah Sayuran Hijau", quantity: 0),
             MaterialDetail(name: "Umbi-umbian", quantity: 0)
            ]
        let greenMaterialDetail =
            [MaterialDetail(name: "Tisu Toilet", quantity: 0),
             MaterialDetail(name: "Daun Kering", quantity: 0),
             MaterialDetail(name: "Sekam / Gabah", quantity: 0),
             MaterialDetail(name: "Tisu Pengesat", quantity: 0),
            ]
        
            materials.append(Material(color: "Hijau", detail: greenMaterialDetail, total_material: 0))
            materials.append(Material(color: "Cokelat", detail: brownMaterialDetail, total_material: 0))
       
            return materials
    }
    
    func seedCondition() -> [Condition]{
        var conditions: [Condition] = []
        conditions.append(Condition(desc: "Tidak basah dan berbau tengik", isChecked: false))
        conditions.append(Condition(desc: "Menghasilkan panas", isChecked: false))
        conditions.append(Condition(desc: "Lembab dan wangi fermentasi seperti tapai, dan menghasilkan panas", isChecked: false))
        conditions.append(Condition(desc: "Kompos tidak menarik perhatian binatang", isChecked: false))
        return conditions
    }
    
    func seedSolution() -> [Solution]{
        var solutions: [Solution] = []
        solutions.append(Solution(name: "Basah dan berbau tengik", photo: "sol-1", subtitle: ["Tidak cukup udara", "Kandungan Nitrogen berlebih"], detail: ["Aduk campuran kompos", "Campur jerami, serbuk gergaji, atau serpihan kayu"]))
        solutions.append(Solution(name: "Tidak menghasilkan panas", photo: "sol-2", subtitle: ["Tumpukan terlalu sedikit", "Tumpukan terlalu kering"], detail: ["Tambahkan bahan baru", "Tambah air ketika diaduk"]))
        
        return solutions
    }
    
    func seedTutorial() -> [Tutorial]{
        var tutorials: [Tutorial] = []
        
        tutorials.append(Tutorial(name: "Material Kompos", photo: "tutorial-1", detail: "Sampah Hijau adalah bahan yang kaya akan nitrogen atau protein. Sampah Coklat adalah bahan yang kaya akan karbon atau karbohidrat."))
        
        tutorials.append(Tutorial(name: "Cara Mengkompos", photo: "tutorial-2", detail: "1. Pisahkan bahan hijau dan coklat, kemudian potong menjadi bagian kecil\n2. Masukan kedalam wadah kompos satu lapis sampah hijau secara menyeluruh kemudian satu lapis sampah coklat, lakukan selang-seling sampai sampah habis.\n3. Setelah 3 hari, periksa kompos sesuai kriteria yang telah di tentukan dalam aplikasi dan mengaduk.\n4. Lanjutkan membalik dan memantau tumpukan setiap 3 hari.\n5. Saring semua bahan organik yang berukuran besar dan biarkan berumur 2 minggu lagi sebelum digunakan.\n"))
        
        tutorials.append(Tutorial(name: "Tips & Tricks", photo: "tutorial-3", detail: "1. Terlalu banyak sampah \"cokelat\" maka butuh bertahun-tahun untuk terurai. Terlalu banyak sampah \"hijau\" dan  akan berubah menjadi tumpukan bau.\n2. Activator mempercepat kompos.\n3. Cuci ember kompos secara rutin.\n4. Kompos yang bagus adalah yang terasa dan berbau seperti tanah dan gelap. Anda seharusnya tidak dapat mengenali barang apa pun yang Anda masukkan ke sana.\n5. Santai! Bahkan jika Anda melakukan semuanya dengan salah, pada akhirnya Anda akan membuat kompos yang bagus.\n"))
        return tutorials
    }
    
    func seedWasteMaterialTutorial() -> [WasteMaterialTutorial]{
        var wasteMats: [WasteMaterialTutorial] = []
        
        wasteMats.append(WasteMaterialTutorial(type: "Sampah Hijau", name: ["Sayur dan buah", "Potongan rumput", "Belukar", "Ampas kopi", "Nasi", "Sampah dapur", "Sampah kebun", "Cangkang telur"],photo: ["sayur_buah", "potongan_rumput", "belukar", "ampas_kopi", "nasi", "sampah_dapur", "sampah_kebun", "cangkang_telur"]))
        
        wasteMats.append(WasteMaterialTutorial(type: "Sampah Cokelat", name: ["Potongan koran", "Daun kering", "Potongan kardus", "Sekam/Gabah"], photo: ["koran", "daun_kering", "kardus", "sekam"]))
        
        wasteMats.append(WasteMaterialTutorial(type: "Tidak disarankan untuk kompos", name: ["Sisa daging atau ikan", "Olahan susu", "Lemak atau minyak", "Kotoran hewan", "Tumbuhan sakit", "Tumbuhan berpestisida"], photo: ["daging", "susu", "lemak", "kotoran_hewan", "tumbuhan_sakit", "tumbuhan_berpestisida"]))
        
        
        return wasteMats
    }
    
    func seedHarvestCondition() -> [HarvestCondition]{
        var conditions: [HarvestCondition] = []
        conditions.append(HarvestCondition(desc: "Warna Kehitaman", isChecked: false))
        conditions.append(HarvestCondition(desc: "Tidak berbau tengik", isChecked: false))
        conditions.append(HarvestCondition(desc: "Kompos tidak menarik perhatian binatang", isChecked: false))
        conditions.append(HarvestCondition(desc: "Kompos tidak terlalu panas", isChecked: false))
        return conditions
    }
    
}
