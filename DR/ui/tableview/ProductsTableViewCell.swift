//
//  ProductsTableViewCell.swift
//  DR
//
//  Created by IŞIL VARDARLI on 12.08.2023.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet weak var productsCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ProductsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsList[productsCollectionView.tag].productImage.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: "productsCollectionViewCell" , for: indexPath) as! ProductsCollectionViewCell
        cell.productImage.image = UIImage(named: productsList[productsCollectionView.tag].productImage[indexPath.row])
        cell.productName.text = productsList[productsCollectionView.tag].productName[indexPath.row]
        cell.productDetail.text = productsList[productsCollectionView.tag].productDetail[indexPath.row]
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.white.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You have clicked on : \( productsList[productsCollectionView.tag].productName[indexPath.row] ) ")
    }
    
    
    }
