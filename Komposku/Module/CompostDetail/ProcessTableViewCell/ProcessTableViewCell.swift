//
//  CompostDetailTableViewCell.swift
//  Komposku
//
//  Created by Clara Anggraini on 29/07/21.
//

import UIKit

class ProcessTableViewCell: UITableViewCell {

    @IBOutlet weak var checkListIV: UIImageView!
    @IBOutlet weak var processDateLbl: UILabel!
    @IBOutlet weak var processDetailLbl: UILabel!
    @IBOutlet weak var processCellView: UIView!
        
    let lineView: LineProcessView = LineProcessView()
    static let identifier = "ProcessTableViewCell"
    var today = Date()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        processDateLbl.textColor = UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1.0)
        processDetailLbl.textColor = UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1.0)
        checkListIV.tintColor = UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1.0)
        
        checkListIV.contentMode = .scaleAspectFill
    }

    func setupProcessCell(isDone: Bool, process_date date: Date){
        today = Date()
        let dateDiff = Calendar.current.dateComponents([.day], from: today, to: date).day
        
        if !isDone && dateDiff! < -2 && processDetailLbl.text != "Panen"{
       
            checkListIV.image = UIImage(systemName: "xmark.circle.fill")?.withAlignmentRectInsets(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))
        }else if isDone{
            checkListIV.image = UIImage(systemName: "checkmark.circle.fill")?.withAlignmentRectInsets(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))
        }else if processDetailLbl.text == "Panen"{
            checkListIV.image = UIImage(named: "Shovel-icon")!
            processDateLbl.textColor = UIColor(red: 124/255, green: 204/255, blue: 167/255, alpha: 1.0)
            processDetailLbl.textColor = UIColor(red: 124/255, green: 204/255, blue: 167/255, alpha: 1.0)
            if dateDiff! < 0{
                processDateLbl.textColor = UIColor(red: 49/255, green: 151/255, blue: 103/255, alpha: 1.0)
                processDetailLbl.textColor = UIColor(red: 49/255, green: 151/255, blue: 103/255, alpha: 1.0)
            }
        }else{
            checkListIV.image = UIImage(systemName: "circle.fill")?.withAlignmentRectInsets(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))
        }
        
        if  dateDiff! > -3 && dateDiff! < 0 || Calendar.current.isDateInToday(date){
            checkListIV.tintColor = UIColor(red: 49/255, green: 151/255, blue: 103/255, alpha: 1.0)
            processDateLbl.textColor = UIColor(red: 49/255, green: 151/255, blue: 103/255, alpha: 1.0)
            processDetailLbl.textColor = UIColor(red: 49/255, green: 151/255, blue: 103/255, alpha: 1.0)
        }
    }
    
    override func prepareForReuse() {
        processDateLbl.textColor = UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1.0)
        processDetailLbl.textColor = UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1.0)
        checkListIV.tintColor = UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1.0)
    }
    
    func setupLine(){
        
        self.addSubview(LineProcessView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height+2)))
        
        checkListIV.isHidden = true
        processDateLbl.isHidden = true
        processDetailLbl.isHidden = true
    }
}
