//
//  ChartCollectionViewCell.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit

class ChartCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: ChartCollectionViewCell.self)
    
    var time: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(backView)
        backView.addSubview(lbTime)
        backView.addSubview(chartView)
        backView.addSubview(lbStudyTime)
        
        backView.snp.makeConstraints({ make in
            make.width.equalTo(20)
            make.height.equalTo(167)
            make.edges.equalToSuperview()
        })
        
        lbTime.snp.makeConstraints({ make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.width.equalTo(32)
        })
        
        chartView.snp.makeConstraints({ make in
            make.bottom.equalTo(lbTime.snp.top).offset(7)
            make.width.equalTo(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(126)
        })
        lbStudyTime.snp.makeConstraints({ make in
            make.bottom.equalTo(chartView.snp.top).offset(2)
            make.centerX.equalToSuperview()
            
            make.height.width.equalTo(32)
        })
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var lbTime: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(hexCode: "#797979")
        return label
    }()
    
    private lazy var chartView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var lbStudyTime: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(hexCode: "#797979")
        label.textAlignment = .center
        return label
    }()
    
    func initializeCell(index: Int, time: Int) {
        lbStudyTime.text = "\(time)"
        lbTime.text = "\(index)시"
        self.time = time
        chartView.snp.remakeConstraints({ make in
            make.bottom.equalTo(lbTime.snp.top).offset(-7)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(126 * time / 60)
        })
        fillColor(greenEnum: .dark)
    }
    
    private func fillColor(greenEnum: GreenEnum) {
        switch greenEnum {
        case .none:
            chartView.backgroundColor = UIColor(hexCode: "#E0E0E0")
        case .light:
            chartView.backgroundColor = UIColor(hexCode: "#B2DFB2")
        case .dark:
            chartView.backgroundColor = UIColor(hexCode: "#51C878")
        }
    }
}
