//
//  SliderTableViewCell.swift
//  DR
//
//  Created by IŞIL VARDARLI on 18.08.2023.
//

import UIKit

class SliderTableViewCell: UITableViewCell {
    

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    
    @IBOutlet weak var pageView: UIPageControl!
    var viewModel: DrRepository!
    //pageview
    var timer : Timer?
    var currentPageIndex = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
        
        
        viewModel = DrRepository()
        
        pageView.numberOfPages = viewModel.images.count
        startAutoScroll()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timer?.invalidate()
        timer = nil
    }

}


extension SliderTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hucre = sliderCollectionView.dequeueReusableCell(withReuseIdentifier:"sliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
        hucre.imageView.image = viewModel.images[indexPath.item]
        return hucre
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sliderCollectionView.frame.size
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle the cell selection (if needed)

         // Update the current page index and the page control
         currentPageIndex = indexPath.item
         pageView.currentPage = currentPageIndex
         sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
         stopAutoScroll()
         startAutoScroll()
        print("Cell selected at index: \(indexPath.item)")
    }
    func stopAutoScroll() {
           timer?.invalidate()
           timer = nil
       }
    // Auto scroll
   
    func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
    }
    
    @objc func scrollToNextPage() {
        currentPageIndex = (currentPageIndex + 1) %  viewModel.images.count
        let indexPath = IndexPath(item: currentPageIndex, section: 0)
        sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageView.currentPage = currentPageIndex
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == sliderCollectionView {
            // Calculate the current page index based on the visible content offset
            let visibleRect = CGRect(origin: scrollView.contentOffset, size: scrollView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            
            if let indexPath = sliderCollectionView.indexPathForItem(at: visiblePoint) {
                currentPageIndex = indexPath.item
                pageView.currentPage = currentPageIndex
            }
        }
    }

}
