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
    
    private let greenCollcetionViewHandler: GreenCollectionViewHandler = GreenCollectionViewHandler()
    private let chartCollectionViewHandler: ChartCollectionViewHandler = ChartCollectionViewHandler()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = chartView
        navigationController?.setNavigationBarHidden(true, animated: false)
        greenCollcetionViewHandler.synchronizeScroll = { [weak self] contentOffset in
            self?.chartView.svMonth.contentOffset = contentOffset
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        chartView.cvStudyChart.reloadData()
    }
    
    private lazy var chartView: ChartView = {
        let chartView = ChartView()
        chartView.setStvMonth(monthEnum: .august)
        chartView.cvTotalStudy.dataSource = greenCollcetionViewHandler
        chartView.cvTotalStudy.delegate = greenCollcetionViewHandler
        
        chartView.cvStudyChart.dataSource = chartCollectionViewHandler
        
        return chartView
    }()
}
