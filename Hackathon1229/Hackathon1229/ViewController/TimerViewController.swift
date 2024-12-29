//
//  TimerViewController.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit
import Then

class TimerViewController: UIViewController, UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = timerView
        setupDelegate()
        startTimer1()
        stopTimer1()
    }
    
    private lazy var timerView = TimerView()
    private lazy var circleTimerView = CircleTimerView()
  
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
        return timerModel.dummy().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: timerViewCell.identifier,
            for: indexPath //행 식별위해 파라미터로 받음
        ) as? timerViewCell else {
                return UICollectionViewCell()
        }
        
        let list = timerModel.dummy()
                
        cell.text1.text = list[indexPath.row].text1
        cell.text2.text = list[indexPath.row].text2
        
        return cell
    }
}
