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
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListBahanViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listBahanCellIdentifier", for: indexPath)
        return cell
    }
    
    
}
