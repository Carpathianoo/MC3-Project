//
//  CompostTableViewCell.swift
//  Komposku
//
//  Created by Adlan Nourindiaz on 30/07/21.
//

import UIKit




 class CompostTableViewCell: UITableViewCell {

    @IBOutlet weak var compostImage: UIImageView!
    @IBOutlet weak var compostTitle: UILabel!
    @IBOutlet weak var nextStep: UILabel!
    @IBOutlet weak var estimasiPanen: UILabel!
    
    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var underCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    func setupView(){
        
        nextStep?.layer.masksToBounds = true
        nextStep?.layer.cornerRadius = self.nextStep.bounds.width / 10
        nextStep.sizeToFit()
        estimasiPanen?.layer.masksToBounds = true
        estimasiPanen?.layer.cornerRadius = self.estimasiPanen.bounds.width / 12
        cell.layer.cornerRadius = 8
        underCell.layer.cornerRadius = 8
        

        underCell.layer.shadowOffset = CGSize(width: 2, height: 1)
        underCell.layer.shadowColor = UIColor.black.cgColor
        underCell.layer.shadowOpacity = 0.2
        underCell.layer.shadowRadius = 4
        
        cell.layer.shadowOffset = CGSize(width: 20, height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 4
        cell.layer.masksToBounds = true
        
      
        
        compostImage.contentMode = .scaleAspectFit

        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

@IBDesignable public class LabelPadding: UILabel{
    @IBInspectable var topPadding: CGFloat = 0
    @IBInspectable var bottomPadding: CGFloat = 0
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0

    public override func drawText(in rect: CGRect) {
        let padding = UIEdgeInsets.init(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
        super.drawText(in: rect.inset(by: padding))
    }
    
        public override var intrinsicContentSize: CGSize{
            let size = super.intrinsicContentSize
            return CGSize(width: size.width + leftPadding + rightPadding, height: size.height + topPadding + bottomPadding)
        
    }
}
