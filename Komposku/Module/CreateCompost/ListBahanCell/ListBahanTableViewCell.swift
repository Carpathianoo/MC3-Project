//
//  ListBahanTableViewCell.swift
//  Komposku
//
//  Created by Ahmad Zaky on 28/07/21.
//

import UIKit

class ListBahanTableViewCell: UITableViewCell {

    @IBOutlet weak var bahanTitle: UILabel!
    @IBOutlet weak var jumlahBahan: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var bahanStepper: UIStepper!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()

    }
    
    var currentAmount: Double?
    
    var updateMaterial: ((MaterialDetail) -> ())?
    
    var materialsDetail: MaterialDetail? {
        didSet{
            guard let material = materialsDetail else {
                return
            }
            bahanTitle.text = material.name
            
            bahanStepper.minimumValue = 0
            jumlahBahan.text = "\(material.quantity) bagian"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        viewContainer.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        viewContainer.layer.cornerRadius = 10
        bahanStepper.layer.cornerRadius = 10
        bahanStepper.stepValue = 1
        let customFont = FontGuide()
        
        bahanTitle.font = UIFontMetrics(forTextStyle: .title3).scaledFont(for: customFont.title3)
        jumlahBahan.font = UIFontMetrics(forTextStyle: .title3).scaledFont(for: customFont.title3regular)
        bahanTitle.adjustsFontForContentSizeCategory = true
        jumlahBahan.adjustsFontForContentSizeCategory = true
    }
    
    override func layoutSubviews() {
        if let currentAmount = currentAmount {
            bahanStepper.value = currentAmount
        }
    }
    
    @IBAction func addAmount(_ sender: UIStepper) {

        guard var materials = materialsDetail else {
            return
        }
        if let _ = currentAmount {
            materials.quantity = Int(sender.value)
        } else {
            materials.quantity += Int(sender.value)
        }
        jumlahBahan.text = "\(materials.quantity) bagian"
        updateMaterial?(materials)
    }
}
