//
//  GreenCollectionViewHandler.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import Foundation
import UIKit

class GreenCollectionViewHandler: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var synchronizeScroll: ((CGPoint) -> Void)?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CalendarManager.shared.getDaysOfYear()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GreenCollectionViewCell.identifier, for: indexPath) as? GreenCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row == 3 {
            cell.fill(color: .dark)
        }
        
        if indexPath.row == 10 {
            cell.fill(color: .light)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        synchronizeScroll?(scrollView.contentOffset)
    }
}


