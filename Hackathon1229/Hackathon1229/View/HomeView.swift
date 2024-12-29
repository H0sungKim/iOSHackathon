//
//  HomeView.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit

class HomeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let topView = TopView(main: "목표 시간까지 40분!🔥", sub: "조금 더 집중해볼까요?")
    
    let studyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.estimatedItemSize = .init(width: 346, height: 71)
        $0.minimumInteritemSpacing = 13
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = false
        $0.register(SubjectTimerCollectionViewCell.self, forCellWithReuseIdentifier: SubjectTimerCollectionViewCell.identifier)
    }
    
    let plus = SubjectPlusView()
    
    public lazy var continueBtn = UIButton().then {
        $0.backgroundColor = UIColor(hexCode: "#51C878")
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("이어서 시작하기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.layer.cornerRadius = 10
    }

    private func setupView() {
        [
            topView,
            studyCollectionView,
            plus,
            continueBtn,
        ].forEach {
            addSubview($0)
        }
        
        topView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(60)
            $0.centerX.equalToSuperview()
        }
        
        studyCollectionView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(75)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(346)
            $0.height.equalTo(320)
        }
        
        plus.snp.makeConstraints {
            $0.top.equalTo(studyCollectionView.snp.bottom).offset(17)
            $0.leading.equalToSuperview().offset(46)
        }
        
        continueBtn.snp.makeConstraints {
            $0.top.equalTo(plus.snp.bottom).offset(95)
            $0.trailing.equalToSuperview().offset(-25)
            $0.width.equalTo(143)
            $0.height.equalTo(48)
        }
    }
}
