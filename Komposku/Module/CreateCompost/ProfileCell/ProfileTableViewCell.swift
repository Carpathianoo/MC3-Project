//
//  ProfileTableViewCell.swift
//  Komposku
//
//  Created by Ahmad Zaky on 03/08/21.
//

import UIKit

class ProfileTableViewCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileTextField: UITextField!
    
    var isEditingTextField: ((Bool) -> ())?
    var nilTextField = false
    
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
        
        profileTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    @objc func didTapCompostPhoto() {
        buttonImageTouched?()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if profileTextField.text == "" {
            nilTextField = false
            isEditingTextField?(nilTextField)
        } else {
            nilTextField = true
            isEditingTextField?(nilTextField)
        }
    }
    
}

