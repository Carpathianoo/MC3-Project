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
   
    @IBOutlet weak var nextStep: LabelPadding2!
    @IBOutlet weak var estimasiPanen: UILabel!
    
    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var underCell: UIView!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    var delegate: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    func setupView(){
        
        nextStep?.layer.masksToBounds = true
        nextStep?.layer.cornerRadius = self.nextStep.bounds.width / 7
        nextStep.sizeToFit()
        estimasiPanen?.layer.masksToBounds = true
        estimasiPanen?.layer.cornerRadius = self.estimasiPanen.bounds.width / 10
        cell.layer.cornerRadius = 8
        underCell.layer.cornerRadius = 8
        

        underCell.layer.shadowOffset = CGSize(width: 2, height: 2)
        underCell.layer.shadowColor = UIColor.black.cgColor
        underCell.layer.shadowOpacity = 0.15
        
        compostImage.contentMode = .scaleAspectFill
        compostImage.layer.cornerRadius = 12
        compostImage.accessibilityIgnoresInvertColors = true

        deleteBtn.roundedCorners([.topRight, .bottomRight], radius: 8, borderColor: nil, borderWidth: nil)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var deleteCompostItem: (() -> ())?
   
    
    
    @IBAction func pressDelete(_ sender: Any) {
         
        let dialogMessage = UIAlertController(title: "Delete warning", message: "Apakah kamu yakin ingin menghapus kompos mu?", preferredStyle: .alert)
        
        let ya = UIAlertAction(title: "Ya, hapus", style: .default, handler: { (action) -> Void in
            print("Tombol ya ditekan")
            
            self.deleteCompostItem?()
        })
        
        let batal = UIAlertAction(title: "Batal", style: .cancel) {
            (action) -> Void in
            print("Tombol batal ditekan")
        }
        
        dialogMessage.addAction(ya)
        dialogMessage.addAction(batal)
        
        delegate!.present(dialogMessage, animated: true, completion: nil)
    }
 }



@IBDesignable public class LabelPadding2: UILabel{
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


extension UIView{
    func roundedCorners(_ corners: UIRectCorner, radius: CGFloat, borderColor: UIColor?, borderWidth: CGFloat?){
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        mask.frame = self.bounds
        mask.path = path.cgPath
        self.layer.mask = mask
        
        if borderWidth != nil{
            addBorder(mask, borderWidth: borderWidth!, borderColor: borderColor!)
        }
    }
    private func addBorder(_ mask: CAShapeLayer, borderWidth: CGFloat, borderColor: UIColor){
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    
}
