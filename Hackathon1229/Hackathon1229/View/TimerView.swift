//
//  TimerView.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit
import SnapKit
import Then

class TimerView: UIView {

    private lazy var timerTitle = UILabel().then {
        $0.text = "타이머"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    private lazy var backBtn = UIButton().then {
        $0.setTitle(<#T##title: String?##String?#>, for: <#T##UIControl.State#>)
    }
}

