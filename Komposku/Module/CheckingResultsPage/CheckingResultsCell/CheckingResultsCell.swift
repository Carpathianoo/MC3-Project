//
//  CheckingResultsCell.swift
//  Komposku
//
//  Created by Adlan Nourindiaz on 03/08/21.
//

import UIKit

class CheckingResultsCell: UITableViewCell {

    
    @IBOutlet weak var solutionSubtitle: UILabel!
    @IBOutlet weak var solutionDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    func setupView(){
        
        solutionDetail.layer.cornerRadius = 30
        
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
