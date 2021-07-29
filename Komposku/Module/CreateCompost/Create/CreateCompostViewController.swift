//
//  CreateCompostViewController.swift
//  Komposku
//
//  Created by Ahmad Zaky on 28/07/21.
//

import UIKit

class CreateCompostViewController: UIViewController {

    
    @IBOutlet weak var createTableView: UITableView!
    @IBOutlet weak var compostTitleTextField: UITextField!
    @IBOutlet weak var compostImage: UIImageView!
    
    @IBOutlet weak var containerViewBottom: UIView!
    var dataHijau: [MaterialDetail] = []
    var dataCoklat: [MaterialDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Buat Kompos"
        setupView()
        // Do any additional setup after loading the view.
        createTableView.dataSource = self
        createTableView.delegate = self
      
    }
    
    func setupView(){
        let buttonNib = UINib(nibName: "CreateButtonTableViewCell", bundle: nil)
        let totalItemNib = UINib(nibName: "TotalItemTableViewCell", bundle: nil)
        let bahanCellNib = UINib(nibName: "BahanTableViewCell", bundle: nil)
        
        createTableView.register(buttonNib, forCellReuseIdentifier: "createButtonIdentifier")
        createTableView.register(totalItemNib, forCellReuseIdentifier: "totalItemIdentifier")
        createTableView.register(bahanCellNib, forCellReuseIdentifier: "bahanCellIdentifier")
        createTableView.separatorStyle = .none
        compostImage.layer.cornerRadius = 8
        compostImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCompostPhoto))
        compostImage.addGestureRecognizer(gesture)
    }


    @objc func didTapCompostPhoto() {
        presentPhotoActionSheet()
    }

}

extension CreateCompostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return dataHijau.count + 1
        } else {
            return dataCoklat.count + 1
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Bahan Hijau"
        } else {
            return "Bahan Coklat"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if dataHijau.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "createButtonIdentifier") as! CreateButtonTableViewCell
                cell.action = {
                    let vc = ListBahanViewController()
                    vc.section = 0
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                return cell
            } else if indexPath.row == dataHijau.count + 1 && dataHijau.count != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "totalItemIdentifier") as! TotalItemTableViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bahanCellIdentifier", for: indexPath) as! BahanTableViewCell
                return cell
            }
        } else {
            if dataCoklat.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "createButtonIdentifier") as! CreateButtonTableViewCell
                cell.action = {
                    let vc = ListBahanViewController()
                    vc.section = 1
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                return cell
            } else if indexPath.row == dataCoklat.count + 1 && dataCoklat.count != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "totalItemIdentifier") as! TotalItemTableViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bahanCellIdentifier", for: indexPath) as! BahanTableViewCell
                return cell
            }
        }
    }
    
    
}

extension CreateCompostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Compost Photo", message: "How would you like to select a photo?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            self?.presentLibrary()
        }))
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentLibrary(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.editedImage] as? UIImage else {
            return
        }
        self.compostImage.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
