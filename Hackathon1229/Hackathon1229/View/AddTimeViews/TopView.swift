//
//  TopView.swift
//  Hackathon1229
//
//  Created by 주민영 on 12/29/24.
//

import UIKit

class TopView: UIView {
    init(main: String, sub: String) {
        super.init(frame: .zero)
        mainTitle.text = main
        subTitle.text = sub
        guard let view = setupView() else { return }
        self.addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 6
    }

    private lazy var mainTitle = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 21, weight: .semibold)
    }
    
    private lazy var subTitle = UILabel().then {
        $0.textColor = UIColor(hexCode: "#797979")
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    func setupView() -> UIView? {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(mainTitle)
        mainStackView.addArrangedSubview(subTitle)
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        return mainStackView
    }

}
