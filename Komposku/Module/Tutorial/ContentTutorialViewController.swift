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
    @IBOutlet weak var imageViewContent: UIView!
    @IBOutlet weak var labelContainerTutorial: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        //titleViewTutorial.clipsToBounds = true
        //titleViewTutorial.layer.cornerRadius = 40
        backgroundViewLabel.layer.cornerRadius = 20
        contentTutorialTableView.layer.cornerRadius = 20
        imageViewContent.clipsToBounds = true
        imageViewContent.layer.cornerRadius = 40
        labelContainerTutorial.layer.cornerRadius = 20
        imageViewContent.accessibilityIgnoresInvertColors = true
        ImageContentTutorial.accessibilityIgnoresInvertColors = true
        
        setData()
        
        let nib = UINib(nibName: "ContentTableViewCell" , bundle: nil)
        contentTutorialTableView.register(nib, forCellReuseIdentifier: "contentTableVIew")
        
        contentTutorialTableView.dataSource = self
        contentTutorialTableView.delegate = self
        contentTutorialTableView.isScrollEnabled = true
        seperateData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + self.contentTutorialTableView.frame.height / 2)
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
            descContentLabel.isHidden = false
            descContentLabel.attributedText = StringModifier.modifyDetailTutorial(sentence: ["1. ","Pisahkan ", "bahan hijau dan coklat kemudian ", "potong menjadi bagian kecil.\n", "2. ", "Masukan ", "ke dalam wadah kompos satu lapis bahan hijau kemudian satu lapis bahan coklat, lakukan ", "selang-seling ", "sampai bahan habis.\n3. ", "Setelah 3 hari, ", "periksa ", "kompos sesuai kriteria yang telah di tentukan dalam aplikasi dan ", "lakukan pengadukan.\n4. ", "Lanjutkan mengaduk dan memantau kompos ", "setiap 3 hari.\n5. ", "Saring ", "semua bahan organik yang berukuran besar dan biarkan berumur ", "2 minggu ", "lagi sebelum kompos dapat digunakan."], color1: .black , color2: #colorLiteral(red: 0.1921568627, green: 0.5921568627, blue: 0.4039215686, alpha: 1))
            descContentLabel.font = descContentLabel.font.withSize(17)
        }else if index == 2 {
            descContentLabel.isHidden = false
            descContentLabel.attributedText = StringModifier.modifyDetailTutorial(sentence: ["1. Terlalu banyak bahan ", "\"cokelat\" ", "maka butuh ", "bertahun-tahun kompos untuk terbentuk. ", "Terlalu banyak bahan ", "\"hijau\" ", "membuat kompos menjadi ", "bau.\n", "2. ", "Activator ", "(EM4 atau air beras) dapat mempercepat proses pembentukan kompos.\n3. ", "Cuci ", "wadah penampungan bahan untuk kompos secara ", "rutin.\n", "4. Kompos yang bagus adalah kompos yang ", "terasa dan berbau seperti tanah ", "dan berwarna ", "gelap. ", "Anda seharusnya ", "tidak dapat mengenali ", "barang apa pun yang Anda masukkan ke sana. \n5. ", "Jangan khawatir! ", "Bahkan jika Anda melakukan semuanya dengan salah, pada akhirnya Anda akan membuat kompos yang bagus."], color1: .black , color2: #colorLiteral(red: 0.1921568627, green: 0.5921568627, blue: 0.4039215686, alpha: 1))
            descContentLabel.font = descContentLabel.font.withSize(17)
            //descContentLabel.font = UIFont.boldSystemFont(ofSize: 17)
        }else{
            descContentLabel.isHidden = true
        }
        
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 100
        } else if section == 1{
            return 60
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 238
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return getHeaderSectionTable(section: section, material: nil)
        }
        else if section == 1 {
            return getHeaderSectionTable(section: section, material: nil)
        } else {
            return getHeaderSectionTable(section: section, material: nil)
        }
    }
    
    
    private func getHeaderSectionTable(section: Int, material: Tutorial?) -> UIView {
        var height = 0
        if section == 0 {
            height = 100
        } else if section == 1 {
            height = 60
        } else {
            height = 50
        }
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 10, width: 350, height: height))
        headerView.autoresizesSubviews = true
        headerView.backgroundColor = #colorLiteral(red: 0.9528475404, green: 0.953006804, blue: 0.9528264403, alpha: 1)
        if section == 0 {
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 10, width: 250, height: headerView.frame.height / 2 - 10 )
            label.text = "Disarankan untuk kompos"
            label.numberOfLines = 1
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            headerView.addSubview(label)
            let images = UIImageView()
            headerView.addSubview(images)
            images.frame = CGRect.init(x: label.frame.width + 4, y: 22, width: 14, height: 14)
            images.image = UIImage(systemName: "checkmark")
            images.tintColor = .black
            
            let label2 = UILabel()
            label2.frame = CGRect.init(x: 5, y: headerView.frame.height / 2, width: 350, height: headerView.frame.height / 2)
            let attributed = StringModifier.modifyDetailTutorial2(sentence: ["Bahan ", "Hijau ", "adalah bahan yang ", "kaya akan nitrogen atau protein."], color1: .black, color2: #colorLiteral(red: 0.1921568627, green: 0.5921568627, blue: 0.4039215686, alpha: 1), bothBold: false, fontSize: 17)
            label2.attributedText = attributed
            label2.numberOfLines = 2
            headerView.addSubview(label2)
            return headerView
        }
        else if section == 1 {
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width - 10, height: headerView.frame.height - 10)
            let attributed = StringModifier.modifyDetailTutorial2(sentence: ["Bahan ", "Cokelat ", "adalah bahan yang ", "kaya akan karbon atau karbohidrat."], color1: .black, color2: #colorLiteral(red: 0.1921568627, green: 0.5921568627, blue: 0.4039215686, alpha: 1), bothBold: false, fontSize: 17)
            label.attributedText = attributed
            label.numberOfLines = 2
            headerView.addSubview(label)
            return headerView
        } else {
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 0, width: 300, height: 50)
            label.text = "Tidak disarankan untuk kompos"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            headerView.addSubview(label)
            let images = UIImageView()
            headerView.addSubview(images)
            images.frame = CGRect.init(x: label.frame.width + 10, y: 20, width: 14, height: 14)
            images.image = UIImage(systemName: "xmark")
            images.tintColor = .black
            return headerView
        }
        
    }
}
