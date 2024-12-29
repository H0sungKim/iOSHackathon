//
//  ChartViewController.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit

class ChartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = chartView
    }
    
    private lazy var chartView: ChartView = {
        let chartView = ChartView()
        return chartView
    }()

}
