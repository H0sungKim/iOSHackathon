//
//  AddSubjectView.swift
//  Hackathon1229
//
//  Created by 주민영 on 12/29/24.
//

import UIKit

class AddSubjectView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var title = UILabel().then {
        $0.text = "추가할 과목 이름"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    public lazy var titleTextField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textColor = UIColor.black
        $0.textAlignment = .left
        $0.backgroundColor = UIColor(hexCode: "#E6E6E7")

        $0.layer.cornerRadius = 5
        
        $0.placeholder = "추가할 과목 이름을 적어주세요"
        $0.autocapitalizationType = .none
        
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        $0.leftViewMode = .always
    }
    
    private lazy var timeSetting = UILabel().then {
        $0.text = "목표 공부시간 설정"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    lazy var timePicker = UIDatePicker().then {
        $0.datePickerMode = .countDownTimer
        $0.backgroundColor = .clear
        $0.locale = Locale(identifier: "ko_KR")
    }
    
    public lazy var addBtn = UIButton().then {
        $0.backgroundColor = UIColor(hexCode: "#51C878")
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("추가하기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.layer.cornerRadius = 10
    }
    
    private func setupView() {
        [
            title,
            titleTextField,
            timeSetting,
            timePicker,
            addBtn,
        ].forEach {
            addSubview($0)
        }
        
        title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(38)
            $0.centerX.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(44)
        }
        
        timeSetting.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        timePicker.snp.makeConstraints {
            $0.top.equalTo(timeSetting.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        addBtn.snp.makeConstraints {
            $0.top.equalTo(timePicker.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().offset(-19)
            $0.width.equalTo(93)
            $0.height.equalTo(40)
        }
    }

}
