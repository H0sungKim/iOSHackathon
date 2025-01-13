//
//  AddStudyTimeViewController.swift
//  Hackathon1229
//
//  Created by 주민영 on 12/29/24.
//

import UIKit
import Combine

class AddStudyTimeViewController: UIViewController {
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addStudyTimeView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CommonRepository.shared.getGoal()
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { result in
                if result.result.isPresent {
                    self.addStudyTimeView.completeBtn.setTitle("목표 수정", for: .normal)
                    self.addStudyTimeView.timePicker.countDownDuration = TimeInterval(result.result.goalTime * 60)
                    
                    self.addStudyTimeView.topView.mainTitle.text = "목표를 수정하시겠어요?"
                }
            })
            .store(in: &cancellable)
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
        
        UserDefaultManager.shared.setGoal(goal: "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):00", date: CalendarManager.shared.toString(date: Date()))
        CommonRepository.shared.setGoal(goalRequest: GoalRequest(goalHour: hours, goalMinute: minutes))
            .sink(receiveCompletion: { error in
                print("setgoal")
                print(error)
            }, receiveValue: { result in
                print(result)
            })
            .store(in: &cancellable)
        
        navigationController?.pushViewController(homeVC, animated: true)
    }

}
