//
//  TimerViewController.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit

class TimerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = timerView
    }
    
    private lazy var timerView = TimerView()
  
}
