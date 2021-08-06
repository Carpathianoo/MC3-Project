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
    
    var tutorial: Tutorial?
    let listTableTutorial = tutorialData
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        titleViewTutorial.clipsToBounds = true
        titleViewTutorial.layer.cornerRadius = 40
       setData()
        
        let nib = UINib(nibName: "ContentTableViewCell" , bundle: nil)
                contentTutorialTableView.register(nib, forCellReuseIdentifier: "contentTableVIew")
        
        contentTutorialTableView.dataSource = self
        contentTutorialTableView.delegate = self
        
        seperateData()
        
        let paragraphStyle = NSMutableParagraphStyle()
        //line height size
        
        paragraphStyle.lineSpacing = 5
        let attrString = NSMutableAttributedString(string: tutorial!.detail)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        descContentLabel.attributedText = attrString
        descContentLabel.textAlignment = NSTextAlignment.left
    }
    
    func seperateData() {
        if tutorial?.name == "Material Kompos" {
            contentTutorialTableView.isHidden = false
        }else{
            contentTutorialTableView.isHidden = true
        }
    }
    
    func setData() {
        guard let tutorial = tutorial else {
            return
        }
        
        TitleContentTutorialLabel.text = tutorial.name
        ImageContentTutorial.image = UIImage(named: tutorial.photo)
        descContentLabel.text = tutorial.detail
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
