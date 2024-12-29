//
//  ChartViewController.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit

protocol Month {
    var name: String { get }
}

enum MonthEnum: Int, CaseIterable {
    case january = 0
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
}

extension MonthEnum: Month {
    var name: String {
        switch self {
        case .january:
            return "1월"
        case .february:
            return "2월"
        case .march:
            return "3월"
        case .april:
            return "4월"
        case .may:
            return "5월"
        case .june:
            return "6월"
        case .july:
            return "7월"
        case .august:
            return "8월"
        case .september:
            return "9월"
        case .october:
            return "10월"
        case .november:
            return "11월"
        case .december:
            return "12월"
        }
    }
}

class ChartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = chartView
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private lazy var chartView: ChartView = {
        let chartView = ChartView()
        chartView.setStvMonth(monthEnum: .august)
        chartView.cvTotalStudy.dataSource = self
        chartView.cvTotalStudy.delegate = self
        return chartView
    }()

    
    private func getDaysOfYear() -> Int {

        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        
        let startOfYear = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1))!
        let endOfYear = calendar.date(from: DateComponents(year: currentYear, month: 12, day: 31))!
        
        let daysOfYear = calendar.dateComponents([.day], from: startOfYear, to: endOfYear).day! + 1

        return daysOfYear
    }
    
}

extension ChartViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getDaysOfYear()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GreenCollectionViewCell.identifier, for: indexPath) as? GreenCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
