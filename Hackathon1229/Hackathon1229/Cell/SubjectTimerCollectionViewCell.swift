//
//  SubjectTimerCollectionViewCell.swift
//  Hackathon1229
//
//  Created by 주민영 on 12/29/24.
//

import UIKit

class SubjectTimerCollectionViewCell: UICollectionViewCell {
    static let identifier = "SubjectTimerCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.main.backgroundColor = UIColor(hexCode: "#CCE9CC")
        self.bar.backgroundColor = UIColor(hexCode: "#97B697")
        self.restTime.layer.borderColor = UIColor(hexCode: "#CCE9CC").cgColor
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var main = UIView().then {
        $0.layer.cornerRadius = 15
    }
    
    lazy var bar = UIView()

    lazy var title = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 18, weight: .medium)
    }
    
    lazy var time = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 17, weight: .regular)
    }
    
    lazy var restTime = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "#FDFDFD")
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 9
    }
    
    lazy var restLabel = UILabel().then {
        $0.text = "휴식 10분"
        $0.textColor = UIColor(hexCode: "#797979")
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    private func setupView() {
        addSubview(main)
        main.addSubview(bar)
        main.addSubview(title)
        main.addSubview(time)
        main.addSubview(restTime)
        restTime.addSubview(restLabel)
        
        main.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(346)
            $0.height.equalTo(71)
        }
        
        bar.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(5)
            $0.height.equalTo(42)
        }
        
        title.snp.makeConstraints {
            $0.leading.equalTo(bar.snp.trailing).offset(42)
            $0.centerY.equalToSuperview()
        }
        
        time.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-33)
        }
        
        restTime.snp.makeConstraints {
            $0.top.equalTo(time.snp.bottom).offset(10)
            $0.width.equalTo(73)
            $0.height.equalTo(25)
            $0.centerX.equalTo(time.snp.centerX)
        }
        
        restLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
