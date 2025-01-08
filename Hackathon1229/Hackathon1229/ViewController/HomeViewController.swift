//
//  HomeViewController.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit
import Combine

class HomeViewController: UIViewController, UICollectionViewDelegate, UISheetPresentationControllerDelegate, AddSubjectViewControllerDelegate {
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
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
        CommonRepository.shared.getSubjects()
            .sink(receiveCompletion: { error in
                print("getsubjects")
                print(error)
            }, receiveValue: { result in
                print(result)
                self.subjects = []
                for subjectGoalResponse in result.result.subjectPreviewDTOList {
                    self.subjects.append(SubjectModel(id: subjectGoalResponse.id,title: subjectGoalResponse.subjectName, time: "\(subjectGoalResponse.goalTime/60)시간 \(subjectGoalResponse.goalTime%60)분", remainTime: subjectGoalResponse.remainTime ?? 0))
                    self.updateTopView()
                    self.homeView.studyCollectionView.reloadData()
                }
                
            })
            .store(in: &cancellable)
        
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
        view.continueBtn.addTarget(self, action: #selector(goTimer), for: .touchUpInside)
        return view
    }()
    
    private func setupDataSource() {
        homeView.studyCollectionView.delegate = self
        homeView.studyCollectionView.dataSource = self
    }
    
    @objc private func goTimer() {
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 1
        }
    }
    
    @objc private func goModal() {
        print("gomodal")
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
        homeView.studyCollectionView.reloadData()
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let id = subjects[index].id
        print(id)
        CommonRepository.shared.deleteSubject(subjectId: id)
            .sink(receiveCompletion: { error in
                print("deletesubejct")
                print(error)
            }, receiveValue: { result in
                print(result)
            })
            .store(in: &cancellable)
        guard subjects.indices.contains(index) else { return }
        subjects.remove(at: index)
        homeView.studyCollectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        
        if subjects.isEmpty {
            homeView.studyCollectionView.reloadData()
        } else {
            homeView.studyCollectionView.performBatchUpdates {
            let indexPaths = subjects.enumerated().map { IndexPath(item: $0.offset, section: 0) }
                homeView.studyCollectionView.reloadItems(at: indexPaths)
            }
        }
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
        let hour: Int = Int(subject.remainTime*60) / 3600
        let minute: Int = Int(subject.remainTime*60) % 3600 / 60
        let second: Int = Int(subject.remainTime*60) % 60
        cell.remainTime.text = "\(hour):\(minute):\(second)"
        
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        
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
