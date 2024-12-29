//
//  AddTimeView.swift
//  Hackathon1229
//
//  Created by 주민영 on 12/29/24.
//

import UIKit
import Then

class AddTimeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let topView = TopView(main: "더 자세한 계획을 세워볼까요?", sub: "블록을 눌러 공부와 휴식 시간을 설정해주세요")
    
    private lazy var studyStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 13
    }
    
    let plus = SubjectPlusView()
    
    public lazy var previousBtn = UIButton().then {
        $0.backgroundColor = UIColor(hexCode: "#E6E6E7")
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("이전", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        $0.layer.cornerRadius = 10
    }
    
    public lazy var startBtn = UIButton().then {
        $0.backgroundColor = UIColor(hexCode: "#51C878")
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("시작하기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.layer.cornerRadius = 10
    }
    
    private lazy var btnStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 5
    }
    
    private func setupView() {
        [
            topView,
            studyStackView,
            plus,
            btnStackView,
        ].forEach {
            addSubview($0)
        }
        
        btnStackView.addArrangedSubview(previousBtn)
        btnStackView.addArrangedSubview(startBtn)
        
        topView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(81)
            $0.centerX.equalToSuperview()
        }
        
        studyStackView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(80)
            $0.centerX.equalToSuperview()
        }
        
        plus.snp.makeConstraints {
            $0.top.equalTo(studyStackView.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(46)
        }
        
        previousBtn.snp.makeConstraints {
            $0.width.equalTo(87)
            $0.height.equalTo(48)
        }
        
        startBtn.snp.makeConstraints {
            $0.width.equalTo(132)
            $0.height.equalTo(48)
        }
        
        btnStackView.snp.makeConstraints {
            $0.top.equalTo(plus.snp.bottom).offset(95)
            $0.trailing.equalToSuperview().offset(-26)
        }
    }
}
