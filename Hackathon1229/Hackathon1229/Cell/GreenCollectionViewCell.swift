//
//  GreenCollectionViewCell.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit
import SnapKit

enum GreenEnum: Int {
    case none = 0
    case green1
    case green2
    case green3
    case green4
}

class GreenCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: GreenCollectionViewCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        greenView.layer.cornerRadius = 4
        
        
        self.addSubview(greenView)
        
        greenView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    private lazy var greenView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "#E0E0E0")
        return view
    }()
    
    func fill(color: GreenEnum) {
        switch color {
        case .none:
            greenView.backgroundColor = UIColor(hexCode: "#E0E0E0")
        case .green1:
            greenView.backgroundColor = UIColor(red: 178/255, green: 223/255, blue: 178/255, alpha: 1)
        case .green2:
            greenView.backgroundColor = UIColor(red: 81/255, green: 200/255, blue: 120/255, alpha: 1)
        case .green3:
            greenView.backgroundColor = UIColor(red: 30/255, green: 171/255, blue: 76/255, alpha: 1)
        case .green4:
            greenView.backgroundColor = UIColor(red: 20/255, green: 114/255, blue: 51/255, alpha: 1)
        }
    }
    
}
