//
//  HomeViewController.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UISheetPresentationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView
        setupDataSource()
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
        addSubjectVC.modalPresentationStyle = .pageSheet
        if let sheet = addSubjectVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.delegate = self
            sheet.prefersGrabberVisible = true
        }
        present(addSubjectVC, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SubjectModel.dummy().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SubjectTimerCollectionViewCell.identifier,
            for: indexPath
        ) as? SubjectTimerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let list = SubjectModel.dummy()
        cell.title.text = list[indexPath.row].title
        cell.time.text = list[indexPath.row].time
        
        return cell
    }
    
    
}
