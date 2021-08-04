//
//  CreateCompostViewController.swift
//  Komposku
//
//  Created by Ahmad Zaky on 28/07/21.
//

import UIKit

class CreateCompostViewController: UIViewController {

    
    @IBOutlet weak var createScrollView: UIScrollView!
    @IBOutlet weak var createTableView: UITableView!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var wasteHelperLabel: UILabel!
    
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var containerViewBottom: UIView!
    
    var dataHijau: Material = Material(color: "Hijau", detail: [], total_material: 0)
    let hijau: Material = Seeder.seedMaterial()[0]
    var dataCoklat: Material = Material(color: "Coklat", detail: [], total_material: 0)
    let coklat: Material = Seeder.seedMaterial()[1]
    
    var moisturePercentage: Double = 0
    var hijauMoisture: Double = 0
    var coklatMoisture: Double = 0
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Buat Kompos"
        setupView()
        // Do any additional setup after loading the view.
        createTableView.dataSource = self
        createTableView.delegate = self
    }
    
    func setupView(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tambah", style: .plain, target: self, action: #selector(createNewCompostTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(dismissCreateCompost))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 0.19, green: 0.59, blue: 0.403, alpha: 1.0)
        
        let buttonNib = UINib(nibName: "CreateButtonTableViewCell", bundle: nil)
        let totalItemNib = UINib(nibName: "TotalItemTableViewCell", bundle: nil)
        let bahanCellNib = UINib(nibName: "BahanTableViewCell", bundle: nil)
        let profileNib = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        
        createTableView.register(buttonNib, forCellReuseIdentifier: "createButtonIdentifier")
        createTableView.register(totalItemNib, forCellReuseIdentifier: "totalItemIdentifier")
        createTableView.register(bahanCellNib, forCellReuseIdentifier: "bahanCellIdentifier")
        createTableView.register(profileNib, forCellReuseIdentifier: "profileCell")
        createTableView.separatorStyle = .none
        percentageLabel.text = "\(moisturePercentage)%"
        
        containerViewBottom.layer.cornerRadius = 20
        
        createTableView.estimatedRowHeight = 90
        createTableView.rowHeight = UITableView.automaticDimension
        createTableView.estimatedSectionHeaderHeight = 38
        createTableView.sectionHeaderHeight = UITableView.automaticDimension
        
        view.backgroundColor = .white
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func createNewCompostTapped() {
        createNewCompost()
        print(CoreDataManager.shared.getAllCompost())
    }
    @objc func dismissCreateCompost() {
        dismiss(animated: true)
    }
    
    @objc func editHijauMaterialTapped() {
        editMaterial(section: 0, material: dataHijau)
    }
    @objc func editCoklatMaterialTapped() {
        editMaterial(section: 1, material: dataCoklat)
    }
    
    
}

extension CreateCompostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            if dataHijau.detail.count != 0 {
                let filtered = getFilterHijau()
                return filtered.count + 1
            } else {
                return dataHijau.detail.count + 1
            }
        } else {
            if dataCoklat.detail.count != 0 {
                let filtered = getFilterCoklat()
                return filtered.count + 1
            } else {
                return dataCoklat.detail.count + 1
            }
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return getHeaderSectionTable(section: section, material: nil)
        }
        else if section == 1 {
            return getHeaderSectionTable(section: section, material: dataHijau)
        } else {
            return getHeaderSectionTable(section: section, material: dataCoklat)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileTableViewCell
            cell.selectionStyle = .none
            cell.buttonImageTouched = {
                self.presentPhotoActionSheet()
            }
            return cell
        }
        else if indexPath.section == 1 {
            if dataHijau.detail.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "createButtonIdentifier") as! CreateButtonTableViewCell
                cell.selectionStyle = .none
                cell.action = {
                    let vc = ListBahanViewController()
                    vc.section = 0
                    vc.material = self.hijau
                    vc.actionBack = { newMaterial in
                        if newMaterial.total_material == 0 {
                            self.dataHijau = Material(color: "Hijau", detail: [], total_material: 0)
                        } else {
                            self.dataHijau = newMaterial
                        }

                        self.totalMoisture()
                        self.updateStatus()
                        self.percentageLabel.text = "\(String(format: "%.2f", self.moisturePercentage))%"
                        self.createTableView.reloadData()
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                return cell
            } else if indexPath.row == getFilterHijau().count && dataHijau.detail.count != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "totalItemIdentifier") as! TotalItemTableViewCell
                cell.materialItem = self.dataHijau
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bahanCellIdentifier", for: indexPath) as! BahanTableViewCell
                let filtered = self.getFilterHijau()
                cell.materials = filtered[indexPath.row]
                self.totalMoisture()
                self.updateStatus()
                self.percentageLabel.text = "\(String(format: "%.2f", self.moisturePercentage))%"
                return cell
            }
        } else {
            if dataCoklat.detail.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "createButtonIdentifier") as! CreateButtonTableViewCell
                cell.action = {
                    let vc = ListBahanViewController()
                    vc.section = 1
                    vc.material = self.coklat
                    vc.actionBack = { newMaterial in
                        if newMaterial.total_material == 0 {
                            self.dataCoklat = Material(color: "Coklat", detail: [], total_material: 0)
                        } else {
                            self.dataCoklat = newMaterial
                        }
                        self.totalMoisture()
                        self.updateStatus()
                        self.percentageLabel.text = "\(String(format: "%.2f", self.moisturePercentage))%"
                        self.createTableView.reloadData()
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                return cell
            } else if indexPath.row == getFilterCoklat().count && dataCoklat.detail.count != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "totalItemIdentifier") as! TotalItemTableViewCell
                cell.materialItem = self.dataCoklat
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bahanCellIdentifier", for: indexPath) as! BahanTableViewCell
                let filtered = self.getFilterCoklat()
                cell.materials = filtered[indexPath.row]
                self.totalMoisture()
                self.updateStatus()
                self.percentageLabel.text = "\(String(format: "%.2f", self.moisturePercentage))%"
                return cell
            }
        }
    }
    
    private func getHeaderSectionTable(section: Int, material: Material?) -> UIView {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: createTableView.frame.width, height: 30))
        headerView.autoresizesSubviews = true
        headerView.backgroundColor = UIColor.white
        if section == 0 {
            let label = UILabel()
            label.frame = CGRect.init(x: 21, y: 5, width: 180, height: headerView.frame.height - 10)
            label.text = "Foto"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            headerView.addSubview(label)
            return headerView
        }
        else if section == 1 {
            let label = UILabel()
            label.frame = CGRect.init(x: 21, y: 5, width: 180, height: headerView.frame.height - 10)
            label.text = "Bahan Hijau"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            
            let label2 = UILabel()
            label2.frame = CGRect.init(x: headerView.frame.width - 60, y: 5, width: 50, height: headerView.frame.height - 10)
            label2.text = "Edit"
            label2.textColor = UIColor(red: 0.19, green: 0.59, blue: 0.403, alpha: 1.0)
            label.isUserInteractionEnabled = true
            label2.isUserInteractionEnabled = true
            label2.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            
            
            let gestureHijau = UITapGestureRecognizer(target: self, action: #selector(editHijauMaterialTapped))
            
            label2.addGestureRecognizer(gestureHijau)
            
            headerView.addSubview(label)
            headerView.addSubview(label2)
            
            if material?.detail.count == 0 {
                label2.isHidden = true
            } else {
                label2.isHidden = false
            }
            return headerView
        } else {
            let label = UILabel()
            label.frame = CGRect.init(x: 21, y: 5, width: headerView.frame.width - 10, height: headerView.frame.height - 10)
            label.text = "Bahan Coklat"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            
            let label2 = UILabel()
            label2.frame = CGRect.init(x: headerView.frame.width - 60, y: 5, width: 50, height: headerView.frame.height - 10)
            label2.text = "Edit"
            label2.textColor = UIColor(red: 0.19, green: 0.59, blue: 0.403, alpha: 1.0)
            label2.font = UIFont.systemFont(ofSize: 17)
            
            label2.isUserInteractionEnabled = true
            
            let gestureCoklat = UITapGestureRecognizer(target: self, action: #selector(editCoklatMaterialTapped))
            
            label2.addGestureRecognizer(gestureCoklat)
            
            headerView.addSubview(label)
            headerView.addSubview(label2)
            
            if material?.detail.count == 0 {
                label2.isHidden = true
            } else {
                label2.isHidden = false
            }
            
            return headerView
        }
        
    }
    
}

extension CreateCompostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func presentPhotoActionSheet(){
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
        let cell = createTableView.cellForRow(at: NSIndexPath(row: 0, section: 0) as IndexPath) as! ProfileTableViewCell
        cell.image = selectedImage
        cell.profileImage.contentMode = .scaleAspectFill
        self.image = selectedImage
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension CreateCompostViewController {
    func getFilterHijau() -> [MaterialDetail] {
        let filtered = dataHijau.detail.filter{ (data) -> Bool in
            data.quantity > 0
        }
        return filtered
    }
    
    func getFilterCoklat() -> [MaterialDetail] {
        let filtered = dataCoklat.detail.filter{ (data) -> Bool in
            data.quantity > 0
        }
        return filtered
    }
    
    func createNewCompost() {
        let sharedInstance = CoreDataManager.shared
        
        let cell = createTableView.cellForRow(at: NSIndexPath(row: 0, section: 0) as IndexPath) as! ProfileTableViewCell
        guard let name = cell.profileTextField.text, let image = image else {
            return
        }
        
        print("name", name)
        
        sharedInstance.createCompost(name: name, photo: image.jpegData(compressionQuality: 1)!.base64EncodedString(), moisture: moisturePercentage)
    }

    func editMaterial(section: Int, material: Material) {
        let vc = ListBahanViewController()
        vc.section = section
        vc.material = material
        vc.actionBack = { newMaterial in
            if section == 0 {
                if newMaterial.total_material == 0 {
                    self.dataHijau = Material(color: "Hijau", detail: [], total_material: 0)
                } else {
                    self.dataHijau = newMaterial
                }
            } else {
                if newMaterial.total_material == 0 {
                    self.dataCoklat = Material(color: "Coklat", detail: [], total_material: 0)
                } else {
                    self.dataCoklat = newMaterial
                }
            }
            self.createTableView.reloadData()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func totalMoisture(){
        self.moisturePercentage = MoistureCalculation.getMoisturePercentage(materials: [self.dataHijau, self.dataCoklat])
    }
    func updateStatus(){
        let redColor = UIColor(red: 0.905, green: 0.101, blue: 0.04, alpha: 1.0)
        switch(dataHijau.detail.count == 0, dataCoklat.detail.count == 0, moisturePercentage < 50, moisturePercentage > 60){
        case (false, true, true, false):
            wasteHelperLabel.text = "Masukkan bahan cokelatmu"
            percentageLabel.textColor = redColor
        case (true, false, true, false):
            wasteHelperLabel.text = "Masukkan bahan hijaumu"
            percentageLabel.textColor = redColor
        case (false, false, false, false):
            wasteHelperLabel.text = "Kelembapan sampahmu oke"
            percentageLabel.textColor = UIColor(red: 0.19, green: 0.59, blue: 0.403, alpha: 1.0)
        case (false, false, false, true):
            wasteHelperLabel.text = "Sampahmu terlalu basah,\ntambahkan bahan hijau"
            percentageLabel.textColor = redColor
        case (false,false, true,false):
            wasteHelperLabel.text = "Sampahmu terlalu kering, kurangi bahan cokelat"
            percentageLabel.textColor = redColor
        case (true, false, false, true):
            wasteHelperLabel.text = "Masukkan bahan hijaumu"
            percentageLabel.textColor = redColor
        case (false, true, false, true):
            wasteHelperLabel.text = "Masukkan bahan cokelatmu"
            percentageLabel.textColor = redColor
        default:
            wasteHelperLabel.text = "Ayo masukkan sampahmu"
            percentageLabel.textColor = redColor
        }
    }
    
    @IBAction func didTapHelp(_ sender: UIButton) {
        let alert = UIAlertController(title: "Persentase Kelembapan", message: "Kelembapan material untuk kompos yang optimal berkisar di antara 50-60%", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Oke", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
