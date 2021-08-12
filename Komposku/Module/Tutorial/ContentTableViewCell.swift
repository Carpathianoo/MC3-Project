//
//  ContentTableViewCell.swift
//  Komposku
//
//  Created by Fernando Lawrence on 05/08/21.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    @IBOutlet weak var CollectionViewTutorial: UICollectionView!
    @IBOutlet weak var sectionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CollectionViewTutorial.dataSource = self
        CollectionViewTutorial.delegate = self
        
        let nib = UINib(nibName: "ContentMaterialCompostCollectionViewCell" , bundle: nil)
        CollectionViewTutorial.register(nib, forCellWithReuseIdentifier: "contentCollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension ContentTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ContentList[CollectionViewTutorial.tag].contentImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewTutorial.dequeueReusableCell(withReuseIdentifier: "contentCollectionCell", for: indexPath) as! ContentMaterialCompostCollectionViewCell
        cell.imageContentMaterial.image = UIImage(named: ContentList[CollectionViewTutorial.tag].contentImage[indexPath.row])
        cell.labelContentMaterial.text = ContentList[CollectionViewTutorial.tag].contentName[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("done \(ContentList[CollectionViewTutorial.tag].contentName[indexPath.row])")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 78, height: 102)
    }
}


