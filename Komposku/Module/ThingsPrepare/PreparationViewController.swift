//
//  PreparationViewController.swift
//  Komposku
//
//  Created by Ahmad Zaky on 20/08/21.
//

import UIKit

class PreparationViewController: UIViewController {
    
    let data = Seeder.seedThingsToPrepare()
    
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var created: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        UISetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = .white
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        pageControl.subviews.forEach{
            $0.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
    
    private func UISetup(){
        self.navigationItem.setHidesBackButton(true, animated: true)
        let btnBack = UIBarButtonItem(image: UIImage(named: "Vector")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(didTapBackButton))
        self.navigationItem.leftBarButtonItem = btnBack
        btnSkip.layer.cornerRadius = 8
        let font = UIFont.boldSystemFont(ofSize: 34)
        titleLabel.font = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: font)
        titleLabel.adjustsFontForContentSizeCategory = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ThingsPrepareCell", bundle: nil), forCellWithReuseIdentifier: "preparationCell")
    }
    
}

extension PreparationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = data.count
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "preparationCell", for: indexPath) as! ThingsPrepareCell
        cell.dataSetup(data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 510)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
        if pageControl.currentPage == 4 {
            let attributeString = NSAttributedString(string: "Buat Kompos", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            btnSkip.setAttributedTitle(attributeString, for: .normal)
        } else {
            let attributeString = NSAttributedString(string: "Lewati", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            btnSkip.setAttributedTitle(attributeString, for: .normal)
        }
    }
    
    @objc func didTapBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSkip(_ sender: UIButton){
        let vc = CreateCompostViewController()
        let navVc = UINavigationController(rootViewController: vc)
        vc.isDismissed = {
            self.navigationController?.popToRootViewController(animated: true)
            self.created?()
        }
        self.navigationController?.present(navVc, animated: true, completion: nil)
    }
    
}
