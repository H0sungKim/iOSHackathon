//
//  SubjectPlusView.swift
//  Hackathon1229
//
//  Created by 주민영 on 12/29/24.
//

import UIKit

class SubjectPlusView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let view = setupView() else { return }
        self.addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var plus = UIImageView(image: UIImage(named: "plus")).then {
        $0.frame.size = CGSize(width: 15, height: 15)
    }
    
    private lazy var subjectPlus = UILabel().then {
        $0.text = "과목 추가"
        $0.textColor = UIColor(hexCode: "#797979")
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    private lazy var plusStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 9
        $0.isUserInteractionEnabled = true
    }
    
    func setupView() -> UIView? {
        addSubview(plusStackView)
        plusStackView.addArrangedSubview(plus)
        plusStackView.addArrangedSubview(subjectPlus)
        
        plusStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        return plusStackView
    }

}
