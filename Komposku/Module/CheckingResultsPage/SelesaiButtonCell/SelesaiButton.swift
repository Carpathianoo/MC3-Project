//
//  SelesaiButton.swift
//  Komposku
//
//  Created by Adlan Nourindiaz on 03/08/21.
//

import UIKit


protocol SelesaiButtonDelegate {
    func goToDoneChecking()
}

class SelesaiButton: UITableViewCell{

    @IBOutlet weak var selesaiButton: UIButton!
    var selesaiButtonDelegate: SelesaiButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
    }

    func setupView(){
        
        selesaiButton.layer.cornerRadius = 10
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
    @IBAction func selesaiButtonClicked(_ sender: UIButton) {
        self.selesaiButtonDelegate?.goToDoneChecking()
    }
    
}
