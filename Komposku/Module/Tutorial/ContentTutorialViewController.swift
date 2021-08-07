//
//  ContentTutorialViewController.swift
//  Komposku
//
//  Created by Fernando Lawrence on 28/07/21.
//

import UIKit

let ContentList = [
    ContentTutorial(sectionType: "Disarankan untuk kompos \n Bahan Hijau adalah bahan yang kaya akan nitrogen atau protein.",
                    contentImage: ["1-Sayur dan Buah","2-Potongan Rumput","3-Belukar","4-Ampas Kopi","5-Nasi","6-Sampah Dapur","7-Sampah Kebun","8-Cangkang Telur"],
                    contentName: ["Sayur dan buah","Potongan rumput","Belukar","Ampas kopi","Nasi","Sampah dapur","Sampah kebun","Cangkang telur"]),
    
    ContentTutorial(sectionType: "Bahan Cokelat adalah bahan yang kaya akan karbon atau karbohidrat.",
                    contentImage: ["9-Potongan Koran","10-Daun kering","11-Potongan kardus","12-Sekam atau gabah","13-Serbuk gergaji","14-Tisu pengesat","15-Tisu Toilet","16-Daun"],
                    contentName: ["Potongan Koran","Daun kering","Potongan kardus","Sekam / gabah","Serbuk gergaji","Tisu pengesat","Tisu Toilet","Daun"]),
    
    ContentTutorial(sectionType: "Tidak disarankan untuk kompos",
                    contentImage: ["17-Sisa Daging atau Ikan","18 - Olahan Susu","19-Lemak atau Minyak","20-Kotoran Hewan","21-Tumbuhan Sakit","22-Tumbuhan Berpestisida"],
                    contentName: ["Sisa Daging atau Ikan","Olahan Susu","Lemak atau Minyak","Kotoran Hewan","Tumbuhan Sakit","Tumbuhan Berpestisida"])
]

class ContentTutorialViewController: UIViewController {

    
    @IBOutlet weak var TitleContentTutorialLabel: UILabel!
    @IBOutlet weak var ImageContentTutorial: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var descContentLabel: UILabel!
    @IBOutlet weak var contentTutorialTableView: UITableView!
    @IBOutlet weak var titleViewTutorial: UIView!
    @IBOutlet weak var backgroundViewLabel: UIView!
    
    var tutorial: Tutorial?
    let listTableTutorial = tutorialData
    
    var index:Int?
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        titleViewTutorial.clipsToBounds = true
        titleViewTutorial.layer.cornerRadius = 40
        backgroundViewLabel.layer.cornerRadius = 20
        contentTutorialTableView.layer.cornerRadius = 20
        
        setData()
        
        let nib = UINib(nibName: "ContentTableViewCell" , bundle: nil)
                contentTutorialTableView.register(nib, forCellReuseIdentifier: "contentTableVIew")
        
        contentTutorialTableView.dataSource = self
        contentTutorialTableView.delegate = self
        
        seperateData()
    }
    
    func seperateData() {
        if tutorial?.name == "Material Kompos" {
            contentTutorialTableView.isHidden = false
        }else{
            contentTutorialTableView.isHidden = true
        }
    }
    
    //set different color text in label
    func setData() {
        guard let tutorial = tutorial else {
            return
        }
        
        TitleContentTutorialLabel.text = tutorial.name
        ImageContentTutorial.image = UIImage(named: tutorial.photo)
        
        
        if index == 1 {
            descContentLabel.attributedText = modifyDetailMaterial(sentence: ["1. ","Pisahkan ", "bahan hijau dan coklat kemudian ", "potong menjadi bagian kecil.\n\n", "2. ", "Masukan ", "ke dalam wadah kompos satu lapis bahan hijau kemudian satu lapis bahan coklat, lakukan ", "selang-seling ", "sampai bahan habis.\n\n3. ", "Setelah 3 hari, ", "periksa ", "kompos sesuai kriteria yang telah di tentukan dalam aplikasi dan ", "lakukan pengadukan.\n\n4. ", "Lanjutkan mengaduk dan memantau kompos ", "setiap 3 hari.\n\n5. ", "Saring ", "semua bahan organik yang berukuran besar dan biarkan berumur ", "2 minggu ", "lagi sebelum kompos dapat digunakan."], color1: .black , color2: #colorLiteral(red: 0.1921568627, green: 0.5921568627, blue: 0.4039215686, alpha: 1))
        }else{
            descContentLabel.attributedText = modifyDetailMaterial(sentence: ["1. Terlalu banyak bahan ", "\"cokelat\" ", "maka butuh ", "bertahun-tahun kompos untuk terbentuk. ", "Terlalu banyak bahan ", "\"hijau\" ", "membuat kompos menjadi ", "bau.\n\n", "2. ", "Activator ", "(EM4 atau air beras) dapat mempercepat proses pembentukan kompos.\n\n3. ", "Cuci ", "wadah penampungan bahan untuk kompos secara ", "rutin.\n\n", "4. Kompos yang bagus adalah kompos yang ", "terasa dan berbau seperti tanah ", "dan berwarna ", "gelap. ", "Anda seharusnya ", "tidak dapat mengenali ", "barang apa pun yang Anda masukkan ke sana. \n\n5. ", "Jangan khawatir! ", "Bahkan jika Anda melakukan semuanya dengan salah, pada akhirnya Anda akan membuat kompos yang bagus."], color1: .black , color2: #colorLiteral(red: 0.1921568627, green: 0.5921568627, blue: 0.4039215686, alpha: 1))
        }
        
        
    }
    
    func modifyDetailMaterial(sentence: [String], color1: UIColor, color2: UIColor) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        
        let string = NSMutableAttributedString(string: "")
        let firstAttributes = [NSAttributedString.Key.foregroundColor: color1, NSAttributedString.Key.font: UIFont.systemFont(ofSize:15), NSAttributedString.Key.paragraphStyle: paragraphStyle ]
            let secondAttributes = [NSAttributedString.Key.foregroundColor: color2, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
            for i in 0..<sentence.count {
                if i % 2 == 0 {
                    let strings = NSAttributedString(string: sentence[i], attributes: firstAttributes)
                    string.append(strings)
                } else {
                    let strings = NSAttributedString(string: sentence[i], attributes: secondAttributes)
                    string.append(strings)
                }
            }
        return string
    }

}



extension ContentTutorialViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentTutorialTableView.dequeueReusableCell(withIdentifier: "contentTableVIew", for: indexPath) as! ContentTableViewCell
        cell.CollectionViewTutorial.tag = indexPath.section
        cell.CollectionViewTutorial.reloadData()
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ContentList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ContentList[section].sectionType
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 61.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 238
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = #colorLiteral(red: 0.9528475404, green: 0.953006804, blue: 0.9528264403, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = #colorLiteral(red: 0.9528475404, green: 0.953006804, blue: 0.9528264403, alpha: 1)
    }
    
}
