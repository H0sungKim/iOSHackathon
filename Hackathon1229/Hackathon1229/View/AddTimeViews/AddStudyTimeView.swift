//
//  AddStudyTimeView.swift
//  Hackathon1229
//
//  Created by 주민영 on 12/29/24.
//

import UIKit
import Then

class AddStudyTimeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let topView = TopView(main: "오늘 총 공부시간을 정해볼까요?", sub: "휴식을 제외한 목표 시간을 설정해주세요")
    
    private lazy var today = UILabel().then {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        var current_date_string = formatter.string(from: Date())
        
        $0.text = current_date_string
        $0.textColor = UIColor(hexCode: "#9C9C9C")
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    lazy var timePicker = UIDatePicker().then {
        $0.datePickerMode = .countDownTimer
        $0.backgroundColor = .clear
        $0.layer.borderColor = UIColor(hexCode: "C3EBD0").cgColor
        $0.layer.borderWidth = 2.0
        $0.layer.cornerRadius = 15
        $0.locale = Locale(identifier: "ko_KR")
    }
    
    public lazy var completeBtn = UIButton().then {
        $0.backgroundColor = UIColor(hexCode: "#50C878")
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("목표 설정 완료", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.layer.cornerRadius = 15
    }
    
    private func setupView() {
        [
            topView,
            today,
            timePicker,
            completeBtn,
        ].forEach {
            addSubview($0)
        }
        
        topView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(91)
            $0.centerX.equalToSuperview()
        }
        
        today.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(74)
            $0.leading.equalToSuperview().offset(42)
        }
        
        timePicker.snp.makeConstraints {
            $0.top.equalTo(today.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(345)
            $0.height.equalTo(227)
        }
        
        completeBtn.snp.makeConstraints {
            $0.top.equalTo(timePicker.snp.bottom).offset(27)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(345)
            $0.height.equalTo(66)
        }
        
    }
}
