//
//  ListBahanViewController.swift
//  Komposku
//
//  Created by Ahmad Zaky on 28/07/21.
//

import UIKit

class ListBahanViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var listBahanTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        let detailNib = UINib(nibName: "DetailMaterialTableViewCell", bundle: nil)
        listBahanTableView.register(listBahanNib, forCellReuseIdentifier: "listBahanCellIdentifier")
        listBahanTableView.register(detailNib, forCellReuseIdentifier: "detailMaterialCell")
        listBahanTableView.delegate = self
        listBahanTableView.dataSource = self
        listBahanTableView.separatorStyle = .none
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
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
        return material.detail.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 176
        } else {
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = listBahanTableView.dequeueReusableCell(withIdentifier: "detailMaterialCell", for: indexPath) as! DetailMaterialTableViewCell
            cell.bahan = section
            return cell
        } else {
            let cell = listBahanTableView.dequeueReusableCell(withIdentifier: "listBahanCellIdentifier", for: indexPath) as! ListBahanTableViewCell
            cell.materialsDetail = material?.detail[indexPath.row - 1]
            cell.currentAmount = Double(material?.detail[indexPath.row - 1].quantity ?? 0)
            cell.updateMaterial = { material in
                self.material?.detail[indexPath.row - 1] = material
            }
            return cell
        }
    }
    
    
}
