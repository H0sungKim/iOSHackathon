//
//  HomeViewController.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UISheetPresentationControllerDelegate, AddSubjectViewControllerDelegate {
    
    public var receivedData: String?
    
    var newSubject: SubjectModel?
    var subjects: [SubjectModel] = [] {
        didSet {
            updateTopView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView
        self.navigationController?.isNavigationBarHidden = true
        setupDataSource()
        updateTopView()
    }
    
    private func updateTopView() {
        if subjects.isEmpty {
            homeView.topView.mainTitle.text = "더 자세한 계획을 세워볼까요?"
            homeView.topView.subTitle.text = "블록을 눌러 공부와 휴식 시간을 설정해주세요"
        } else {
            if let data = receivedData {
                homeView.topView.mainTitle.text = "목표 시간까지 \(data)!🔥"
                homeView.topView.subTitle.text = "조금 더 집중해볼까요?"
            }
        }
    }
    
    private lazy var homeView: HomeView = {
        let view = HomeView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goModal))
        view.plus.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private func setupDataSource() {
        homeView.studyCollectionView.delegate = self
        homeView.studyCollectionView.dataSource = self
    }
    
    @objc private func goModal() {
        let addSubjectVC = AddSubjectViewController()
        addSubjectVC.delegate = self // Delegate 연결
        addSubjectVC.modalPresentationStyle = .pageSheet
        if let sheet = addSubjectVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.delegate = self
            sheet.prefersGrabberVisible = true
        }
        present(addSubjectVC, animated: true)
    }
    
    func didAddSubject(_ subject: SubjectModel) {
        self.newSubject = subject // 전달받은 데이터 저장
        print("새로운 과목 추가됨: \(subject.title), \(subject.time)")
        self.subjects.append(subject)
        // 새로운 데이터를 컬렉션 뷰에 반영
        homeView.studyCollectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SubjectTimerCollectionViewCell.identifier,
            for: indexPath
        ) as? SubjectTimerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let subject = subjects[indexPath.row]
        cell.title.text = subject.title
        cell.time.text = subject.time
        
        switch indexPath.item % 4 {
        case 0:
            cell.main.backgroundColor = UIColor(hexCode: "#CCE9CC")
            cell.bar.backgroundColor = UIColor(hexCode: "#97B697")
            cell.restTime.layer.borderColor = UIColor(hexCode: "#CCE9CC").cgColor
        case 1:
            cell.main.backgroundColor = UIColor(hexCode: "#FFCAD5")
            cell.bar.backgroundColor = UIColor(hexCode: "#C78D97")
            cell.restTime.layer.borderColor = UIColor(hexCode: "#FFCAD5").cgColor
        case 2:
            cell.main.backgroundColor = UIColor(hexCode: "#BEE5FB")
            cell.bar.backgroundColor = UIColor(hexCode: "#85ACC2")
            cell.restTime.layer.borderColor = UIColor(hexCode: "#BEE5FB").cgColor
        case 3:
            cell.main.backgroundColor = UIColor(hexCode: "#FDE7AE")
            cell.bar.backgroundColor = UIColor(hexCode: "#CFBB87")
            cell.restTime.layer.borderColor = UIColor(hexCode: "#FDE7AE").cgColor
        default:
            cell.main.backgroundColor = UIColor(hexCode: "#CCE9CC")
            cell.bar.backgroundColor = UIColor(hexCode: "#97B697")
            cell.restTime.layer.borderColor = UIColor(hexCode: "#CCE9CC").cgColor
        }
        
        if indexPath.item == subjects.count - 1 {
            cell.restTime.isHidden = true
        } else {
            cell.restTime.isHidden = false
        }
        
        return cell
    }
    
    
}
