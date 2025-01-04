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
    
    private var date: Date = Date()

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
        chartView.lbTargettime.text = UserDefaultManager.shared.getGoal(date: CalendarManager.shared.toString(date: date)) ?? "05:30:00"
    }
    
    private lazy var chartView: ChartView = {
        let chartView = ChartView()
        chartView.setStvMonth(monthEnum: .january)
        chartView.cvTotalStudy.dataSource = greenCollcetionViewHandler
        chartView.cvTotalStudy.delegate = greenCollcetionViewHandler
        
        chartView.cvStudyChart.dataSource = chartCollectionViewHandler
        chartView.btnSubject.showsMenuAsPrimaryAction = true
        chartView.lbDay.text = CalendarManager.shared.toString(date: date)
        chartView.btnSubject.menu = UIMenu(title: "과목을 골라주세요.", identifier: nil, options: .displayInline, children: [
            UIAction(title: "전체보기", handler: {_ in}),
        ])
        chartView.btnDayBefore.addTarget(self, action: #selector(onClickDayBefore), for: .touchUpInside)
        chartView.btnDayAfter.addTarget(self, action: #selector(onClickDayAfter), for: .touchUpInside)
        
        return chartView
    }()
    
    @objc func onClickDayBefore() {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: date) else { return }
        date = yesterday
        chartView.lbDay.text = CalendarManager.shared.toString(date: date)
    }
    
    @objc func onClickDayAfter() {
        guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: date) else { return }
        date = tomorrow
        chartView.lbDay.text = CalendarManager.shared.toString(date: date)
    }
}
