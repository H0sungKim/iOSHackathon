//
//  TimerViewController.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit
import Then
import Combine

class TimerViewController: UIViewController, UICollectionViewDelegate {

    private var subject: String!
    private var duration: Int!
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private var timerResponse: TimerResponse!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = timerView
        startTimer1()
        stopTimer1()
        
        timerView.updateView(subject: subject, duration: duration)
    }
    
    init(index: Int, subject: String, time: Int) {
        super.init(nibName: nil, bundle: nil)
        timerView.circleTimerView.index = index
        self.subject = subject
        self.duration = time
        print(index)
        CommonRepository.shared.getTimer(subjectId: index)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { result in
                self.timerResponse = result.result
                self.setupDelegate()
                print(result)
            })
            .store(in: &cancellable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var timerView = TimerView()
  
    private func setupDelegate() {
        timerView.collectionView.dataSource = self
        timerView.collectionView.delegate = self
    }
 
    @objc private func startTimer1() {
        timerView.btn3.addTarget(timerView.circleTimerView, action: #selector(timerView.circleTimerView.toggleTimer), for: .touchUpInside)
    }
    
    @objc private func stopTimer1() {
        timerView.btn2.addTarget(timerView.circleTimerView, action: #selector(timerView.circleTimerView.realStopTimer), for: .touchUpInside)
    }

}

extension TimerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: timerViewCell.identifier,
            for: indexPath //행 식별위해 파라미터로 받음
        ) as? timerViewCell else {
                return UICollectionViewCell()
        }
        
        switch indexPath.row {
        case 0:
            if let goalTime = timerResponse.goalTime {
                cell.text1.text = "오늘 목표 시간"
                cell.text2.text = "\(goalTime/60):\(goalTime%60):00"
            }
        case 1:
            if let totalStudyTime = timerResponse.totalStudyTime {
                cell.text1.text = "총 공부 시간"
                cell.text2.text = "\(totalStudyTime/60):\(totalStudyTime%60):00"
            }
        case 2:
            if let subjectGoalTime = timerResponse.subjectGoalTime {
                cell.text1.text = "\(subject!) 목표 시간"
                cell.text2.text = "\(subjectGoalTime/60):\(subjectGoalTime%60):00"
            }
        default:
            break
        }
        
        return cell
    }
}
