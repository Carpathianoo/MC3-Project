//
//  ContentTableViewCell.swift
//  Komposku
//
//  Created by Fernando Lawrence on 05/08/21.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewTutorial: UICollectionView!
    @IBOutlet weak var sectionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewTutorial.dataSource = self
        collectionViewTutorial.delegate = self
        
        let nib = UINib(nibName: "ContentMaterialCompostCollectionViewCell" , bundle: nil)
        collectionViewTutorial.register(nib, forCellWithReuseIdentifier: "contentCollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension ContentTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ContentList[collectionViewTutorial.tag].contentImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewTutorial.dequeueReusableCell(withReuseIdentifier: "contentCollectionCell", for: indexPath) as! ContentMaterialCompostCollectionViewCell
        cell.imageContentMaterial.image = UIImage(named: ContentList[collectionViewTutorial.tag].contentImage[indexPath.row])
        cell.labelContentMaterial.text = ContentList[collectionViewTutorial.tag].contentName[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("done \(ContentList[collectionViewTutorial.tag].contentName[indexPath.row])")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 78, height: 102)
    }
}


