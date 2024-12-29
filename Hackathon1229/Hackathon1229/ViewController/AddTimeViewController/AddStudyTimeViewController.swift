//
//  AddStudyTimeViewController.swift
//  Hackathon1229
//
//  Created by 주민영 on 12/29/24.
//

import UIKit

class AddStudyTimeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addStudyTimeView
    }
    
    private lazy var addStudyTimeView: AddStudyTimeView = {
        let view = AddStudyTimeView()
        view.completeBtn.addTarget(self, action: #selector(goTime), for: .touchUpInside)
        return view
    }()
    
    @objc private func goTime() {
        let homeVC = HomeViewController()
        
        let selectedDuration = addStudyTimeView.timePicker.countDownDuration // 초 단위로 반환
        let hours = Int(selectedDuration) / 3600 // 시간 계산
        let minutes = (Int(selectedDuration) % 3600) / 60 // 분 계산
        
        homeVC.receivedData = "\(hours)시간 \(minutes)분"
        navigationController?.pushViewController(homeVC, animated: true)
    }

}
