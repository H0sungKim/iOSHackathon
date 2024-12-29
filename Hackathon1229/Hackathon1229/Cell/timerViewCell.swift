//
//  timerViewCell.swift
//  Hackathon1229
//
//  Created by KoNangYeon on 12/29/24.
//

import UIKit

class timerViewCell: UICollectionViewCell {
    
    static let identifier = "timerViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    lazy var back = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "F3F3F3")
        $0.layer.cornerRadius = 8
    }
    
    lazy var text1 = UILabel().then {
        $0.text = "오늘 목표 시간"
        $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        $0.textColor = UIColor(hexCode: "797979")
    }
    
    lazy var text2 = UILabel().then {
        $0.text = "05 : 30 : 00"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = UIColor(hexCode: "797979")
    }
    
    private func setupView(){
        addSubview(back)
        addSubview(text1)
        addSubview(text2)
        
        back.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        text1.snp.makeConstraints{
            $0.top.equalToSuperview().inset(19)
            $0.centerX.equalToSuperview()
        }
        
        text2.snp.makeConstraints{
            $0.top.equalTo(text1.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }

    }
}
