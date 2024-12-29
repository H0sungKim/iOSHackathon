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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var timerTitle = UILabel().then {
        $0.text = "타이머"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    private lazy var backBtn = UIButton().then {
        var config = UIButton.Configuration.plain()
        
        config.imagePadding = 7
        $0.setTitle("이전", for: .normal)
        $0.setImage(UIImage(resource: .back), for: .normal)
        $0.setTitleColor(UIColor(hexCode: "9A9A9A"), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        $0.configuration = config
    }
    
    private lazy var progressTitle = UILabel().then {
        $0.text = "1/5"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.textColor = UIColor(hexCode: "9A9A9A")
    }
    
    private lazy var btn1 = UIButton().then {
        var config = UIButton.Configuration.plain()
        
        config.imagePadding = 7
        $0.layer.cornerRadius = 38
        $0.backgroundColor = UIColor(hexCode: "E6E6E7")
        $0.setImage(UIImage(resource: .plus), for: .normal)
        $0.setTitle("10:00", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        $0.setTitleColor(UIColor(hexCode: "797979"), for: .normal)
        
        $0.configuration = config
    }
    
    lazy var btn2 = UIButton().then {
        $0.layer.cornerRadius = 38
        $0.backgroundColor = UIColor(hexCode: "51C878")
        $0.setTitle("STOP", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        $0.setTitleColor(UIColor.white, for: .normal)
    }
    
    lazy var stopImage1 = UIView().then {
        $0.backgroundColor = .white
        $0.isUserInteractionEnabled = false
    }
    
    lazy var stopImage2 = UIView().then {
        $0.backgroundColor = .white
        $0.isUserInteractionEnabled = false
        
    }
    
    lazy var btn3 = UIButton().then {
        $0.layer.cornerRadius = 38
        $0.backgroundColor = UIColor(hexCode: "51C878")
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: 134, height: 83)
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 8
    }).then {
        $0.isScrollEnabled = true
        $0.register(timerViewCell.self, forCellWithReuseIdentifier: timerViewCell.identifier)
    }
    
    public lazy var circleTimerView = CircleTimerView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    
    private func addComponents() {
        [
            timerTitle, backBtn, progressTitle, btn1, btn2, btn3, stopImage1, stopImage2, collectionView, circleTimerView
        ].forEach{
            addSubview($0)
        }
        
        timerTitle.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(78)
        }
        
        backBtn.snp.makeConstraints{
            $0.top.equalToSuperview().inset(80)
            $0.left.equalToSuperview().inset(30)
        }
        
        progressTitle.snp.makeConstraints{
            $0.top.equalTo(timerTitle.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
        }
        
        circleTimerView.snp.makeConstraints{
            $0.top.equalTo(progressTitle.snp.bottom).offset(89)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(300)
        }
        
        btn1.snp.makeConstraints{
            $0.left.equalToSuperview().inset(24)
            $0.height.equalTo(76)
            $0.width.equalTo(114)
            $0.top.equalTo(progressTitle.snp.bottom).offset(400)
        }
        
        btn2.snp.makeConstraints{
            $0.right.equalTo(btn3.snp.left).offset(-8)
            $0.height.width.equalTo(76)
            $0.top.equalTo(progressTitle.snp.bottom).offset(400)
        }
        
        stopImage1.snp.makeConstraints{
            $0.width.equalTo(6)
            $0.height.equalTo(18)
            $0.top.equalTo(btn3.snp.top).offset(29)
            $0.left.equalTo(btn3.snp.left).offset(29)
        }
        
        stopImage2.snp.makeConstraints{
            $0.width.equalTo(6)
            $0.height.equalTo(18)
            $0.top.equalTo(btn3.snp.top).offset(29)
            $0.left.equalTo(stopImage1.snp.right).offset(5)
        }
        
        btn3.snp.makeConstraints{
            $0.right.equalToSuperview().inset(40)
            $0.height.width.equalTo(76)
            $0.top.equalTo(progressTitle.snp.bottom).offset(400)
        }
        
        collectionView.snp.makeConstraints{
            $0.left.equalToSuperview().inset(24)
            $0.top.equalTo(btn3.snp.bottom).offset(82)
            $0.height.equalTo(90)
            $0.right.equalToSuperview()
        }
    }
}

