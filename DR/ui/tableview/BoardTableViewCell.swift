//
//  BoardTableViewCell.swift
//  DR
//
//  Created by IŞIL VARDARLI on 18.08.2023.
//

import UIKit

class BoardTableViewCell: UITableViewCell {


    @IBOutlet weak var boardCollectionView: UICollectionView!
    
    var viewModel: DrRepository!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        boardCollectionView.dataSource = self
        boardCollectionView.delegate = self
        
        
        viewModel = DrRepository()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}
extension BoardTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.boardImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hucre = boardCollectionView.dequeueReusableCell(withReuseIdentifier:"boardCollectionViewCell", for: indexPath) as! BoardCollectionViewCell
        hucre.boardImage?.image = viewModel.boardImages[indexPath.item]
        return hucre
    }
    
}
