//
//  GreenCollectionViewCell.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit
import SnapKit

enum GreenEnum: Int {
    case none
    case light
    case dark
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
        case .light:
            greenView.backgroundColor = UIColor(hexCode: "#B2DFB2")
        case .dark:
            greenView.backgroundColor = UIColor(hexCode: "#51C878")
        }
    }
    
}
