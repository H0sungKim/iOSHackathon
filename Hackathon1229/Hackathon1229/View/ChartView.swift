//
//  ChartView.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit
import SnapKit

class ChartView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents() {
        self.addSubview(navigationBarView)
        
        navigationBarView.addSubview(btnBack)
        navigationBarView.addSubview(lbTitle)
        navigationBarView.addSubview(btnShare)
        
        navigationBarView.snp.makeConstraints({ make in
            make.height.equalTo(64)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
        })
        
        btnBack.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(32)
            make.centerY.equalToSuperview()
        })
        
        lbTitle.snp.makeConstraints({ make in
            make.center.equalToSuperview()
        })
        
        btnShare.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().inset(32)
            make.centerY.equalToSuperview()
        })
    }
    
    private lazy var navigationBarView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var btnBack: UIButton = {
        let button = UIButton()
        button.setTitle("이전", for: .normal)
        button.setImage(UIImage(resource: .back), for: .normal)
        return button
    }()
    
    private lazy var lbTitle: UILabel = {
        let label = UILabel()
        label.text = "통계"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var btnShare: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .share), for: .normal)
        return button
    }()
    
    private lazy var dayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        return view
    }()
    
    private
}
