//
//  ListBahanViewController.swift
//  Komposku
//
//  Created by Ahmad Zaky on 28/07/21.
//

import UIKit

class ListBahanViewController: UIViewController {

    @IBOutlet weak var detailMaterial: UILabel!
    @IBOutlet weak var listBahanTableView: UITableView!
    
    var section: Int?
    var material: Material?
    
    var actionBack: ((Material) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if section == 0 {
            title = "List Bahan Hijau"
        } else {
            title = "List Bahan Coklat"
        }
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        let listBahanNib = UINib(nibName: "ListBahanTableViewCell", bundle: nil)
        listBahanTableView.register(listBahanNib, forCellReuseIdentifier: "listBahanCellIdentifier")
        listBahanTableView.delegate = self
        listBahanTableView.dataSource = self
        listBahanTableView.separatorStyle = .none
        if section == 0 {
            detailMaterial.text = "Bahan Hijau adalah bahan yang kaya akan nitrogen atau protein. Ukur bahan hijaumu dengan ukuran wadah yang sama."
        } else {
            detailMaterial.text = "Sampah Cokelat adalah bahan yang kaya akan karbon atau karbohidrat. Ukur bahan cokelatmu dengan ukuran wadah yang sama."
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        updateTotalAmount()
        
        guard let material = material else {
            return
        }

        actionBack?(material)
    }
    
    func updateTotalAmount() {
        var total = 0
        for mtrl in material!.detail {
            total += mtrl.quantity
        }
        
        material?.total_material = total
    }

}

extension ListBahanViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let material = material else {
            return 1
        }
        return material.detail.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listBahanTableView.dequeueReusableCell(withIdentifier: "listBahanCellIdentifier", for: indexPath) as! ListBahanTableViewCell
        cell.materialsDetail = material?.detail[indexPath.row]
        cell.currentAmount = Double(material?.detail[indexPath.row].quantity ?? 0)
        cell.updateMaterial = { material in
            self.material?.detail[indexPath.row] = material
        }
        return cell
    }
    
    
}
