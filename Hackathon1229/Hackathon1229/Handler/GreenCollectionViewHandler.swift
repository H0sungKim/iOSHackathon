//
//  GreenCollectionViewHandler.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import Foundation
import UIKit

class GreenCollectionViewHandler: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var statResponse: StatResponse?
    
    var synchronizeScroll: ((CGPoint) -> Void)?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CalendarManager.shared.getDaysOfYear()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GreenCollectionViewCell.identifier, for: indexPath) as? GreenCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let statResponse = statResponse {
            for dateInfo in statResponse.allDateInfoList {
                guard let totalStudyTime = dateInfo.totalStudyTime else { continue }
                if CalendarManager.shared.indexOfYear(from: dateInfo.date) == indexPath.row+1 {
                    if totalStudyTime == 0 {
                        cell.fill(color: .none)
                    } else if totalStudyTime < 90 {
                        cell.fill(color: .light)
                    } else {
                        cell.fill(color: .dark)
                    }
                }
            }
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


