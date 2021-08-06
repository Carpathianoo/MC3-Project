//
//  ProfileTableViewCell.swift
//  Komposku
//
//  Created by Ahmad Zaky on 03/08/21.
//

import UIKit

class ProfileTableViewCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileTextField: UITextField!
    
    var buttonImageTouched: (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var image: UIImage? {
        didSet {
            profileImage.image = image
        }
    }
    
    func setupView() {
        profileImage.layer.cornerRadius = 8
        profileImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCompostPhoto))
        profileImage.addGestureRecognizer(gesture)
        profileTextField.addUnderline()
    }
    @objc func didTapCompostPhoto() {
        buttonImageTouched?()
    }
    
}

