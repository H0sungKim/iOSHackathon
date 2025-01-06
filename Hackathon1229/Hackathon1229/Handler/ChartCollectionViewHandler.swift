//
//  ChartCollectionViewHandler.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import Foundation
import UIKit

class ChartCollectionViewHandler: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var statResponse: StatResponse?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCollectionViewCell.identifier, for: indexPath) as? ChartCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let statResponse = statResponse {
            for hourlyStudyTimesByDate in statResponse.hourlyStudyTimesByDate {
                if hourlyStudyTimesByDate.hour == indexPath.row {
                    cell.initializeCell(index: indexPath.row, time: hourlyStudyTimesByDate.studyTime)
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}


