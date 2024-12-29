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
        cvTotalStudy.reloadData()
        self.addComponents()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        
        stvMonth.snp.remakeConstraints({ make in
            make.width.equalTo(cvTotalStudy.contentSize.width)
            make.edges.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents() {
        self.addSubview(navigationBarView)
        self.addSubview(dayView)
        self.addSubview(timeView)
        self.addSubview(totalStudyView)
        self.addSubview(studyChartView)
        
        navigationBarView.addSubview(btnBack)
        navigationBarView.addSubview(lbTitle)
        navigationBarView.addSubview(btnShare)
        
        dayView.addSubview(btnDayBefore)
        dayView.addSubview(lbDay)
        dayView.addSubview(btnDayAfter)
        
        timeView.addSubview(targettimeView)
        timeView.addSubview(timeSeparatorView0)
        timeView.addSubview(studytimeView)
        timeView.addSubview(timeSeparatorView1)
        timeView.addSubview(attainmentrateView)
        
        targettimeView.addSubview(lbTargettimeTitle)
        targettimeView.addSubview(lbTargettime)
        studytimeView.addSubview(lbStudytimeTitle)
        studytimeView.addSubview(lbStudytime)
        attainmentrateView.addSubview(lbAttainmentrateTitle)
        attainmentrateView.addSubview(lbAttainmentrate)
        
        totalStudyView.addSubview(totalStudyTopView)
        totalStudyView.addSubview(totalStudySeparatorView)
        totalStudyView.addSubview(svMonth)
        totalStudyView.addSubview(stvDay)
        totalStudyView.addSubview(cvTotalStudy)
        
        svMonth.addSubview(stvMonth)
        
        totalStudyTopView.addSubview(lbTotalStudyTitle)
        totalStudyTopView.addSubview(btnSubject)
        
        studyChartView.addSubview(lbStudyChartTitle)
        studyChartView.addSubview(studyChartSeparatorView)
        studyChartView.addSubview(cvStudyChart)
        
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
        
        dayView.snp.makeConstraints({ make in
            make.height.equalTo(48)
            make.top.equalTo(navigationBarView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(24)
        })
        
        btnDayBefore.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(32)
            make.centerY.equalToSuperview()
        })
        
        lbDay.snp.makeConstraints({ make in
            make.center.equalToSuperview()
        })
        
        btnDayAfter.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().inset(32)
            make.centerY.equalToSuperview()
        })
        
        timeView.snp.makeConstraints({ make in
            make.height.equalTo(74)
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(dayView.snp.bottom).offset(10)
        })
        
        targettimeView.snp.makeConstraints({ make in
            make.leading.top.bottom.equalToSuperview()
            make.trailing.equalTo(timeSeparatorView0.snp.leading)
            make.width.equalTo(124)
        })
        
        timeSeparatorView0.snp.makeConstraints({ make in
            make.width.equalTo(1)
            make.height.equalTo(29)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(studytimeView.snp.leading)
        })
        
        studytimeView.snp.makeConstraints({ make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(128)
        })
        
        timeSeparatorView1.snp.makeConstraints({ make in
            make.width.equalTo(1)
            make.height.equalTo(29)
            make.centerY.equalToSuperview()
            make.leading.equalTo(studytimeView.snp.trailing)
        })
        
        attainmentrateView.snp.makeConstraints({ make in
            make.leading.equalTo(timeSeparatorView1.snp.trailing)
            make.top.bottom.trailing.equalToSuperview()
        })
        
        lbTargettimeTitle.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(17)
        })
        lbTargettime.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        })
        
        lbStudytimeTitle.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(17)
        })
        lbStudytime.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        })
        
        lbAttainmentrateTitle.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(17)
        })
        lbAttainmentrate.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        })
        
        totalStudyView.snp.makeConstraints({ make in
            make.height.equalTo(266)
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(timeView.snp.bottom).offset(10)
        })
        
        totalStudyTopView.snp.makeConstraints({ make in
            make.height.equalTo(50)
            make.top.leading.trailing.equalToSuperview()
        })
        
        lbTotalStudyTitle.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(27)
        })
        btnSubject.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(25)
        })
        
        totalStudySeparatorView.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.width.equalTo(332)
            make.height.equalTo(0.5)
            make.top.equalTo(totalStudyTopView.snp.bottom)
        })
        
        svMonth.snp.makeConstraints({ make in
            make.leading.equalTo(cvTotalStudy.snp.leading)
            make.trailing.equalTo(cvTotalStudy.snp.trailing)
            make.top.equalTo(totalStudySeparatorView.snp.bottom).offset(12)
            make.height.equalTo(20)
        })
        
        stvMonth.snp.makeConstraints({ make in
            make.width.equalTo(cvTotalStudy.contentSize.width)
            make.edges.equalToSuperview()
        })
        
        stvDay.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().inset(18)
            make.leading.equalToSuperview().inset(15)
            make.top.equalTo(svMonth.snp.bottom).offset(8)
        })
        
        cvTotalStudy.snp.makeConstraints({ make in
            make.leading.equalTo(stvDay.snp.trailing).offset(10)
            make.top.equalTo(svMonth.snp.bottom).offset(7)
            make.bottom.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(24)
        })
        
        studyChartView.snp.makeConstraints({ make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(234)
            make.top.equalTo(totalStudyView.snp.bottom).offset(13)
        })
        
        lbStudyChartTitle.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(14)
            make.leading.equalToSuperview().inset(27)
        })
        
        studyChartSeparatorView.snp.makeConstraints({ make in
            make.top.equalTo(lbStudyChartTitle.snp.bottom).offset(9)
            make.centerX.equalToSuperview()
            make.width.equalTo(332.5)
            make.height.equalTo(1)
        })
        
        cvStudyChart.snp.makeConstraints({ make in
            make.leading.trailing.equalToSuperview().inset(18)
            make.top.equalTo(studyChartSeparatorView).offset(8)
            make.bottom.equalToSuperview().inset(11)
        })
    }
    
    private lazy var navigationBarView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var btnBack: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(resource: .before)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 7
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 16)
        container.foregroundColor = UIColor(hexCode: "#9A9A9A")
        configuration.attributedTitle = AttributedString("이전", attributes: container)
        
        button.configuration = configuration
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
        view.backgroundColor = UIColor.backgroundGray
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var btnDayBefore: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .before), for: .normal)
        return button
    }()
    
    private lazy var lbDay: UILabel = {
        let label = UILabel()
        label.text = "12월 25일 수요일"
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(hexCode: "#505050")
        return label
    }()
    
    private lazy var btnDayAfter: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .after), for: .normal)
        return button
    }()
    
    private lazy var timeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundGray
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var targettimeView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var lbTargettimeTitle: UILabel = {
        let label = UILabel()
        label.text = "목표시간"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(hexCode: "#505050")
        return label
    }()
    
    private lazy var lbTargettime: UILabel = {
        let label = UILabel()
        label.text = "05:30:00"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(hexCode: "#3B9B5B")
        return label
    }()
    
    private lazy var studytimeView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var lbStudytimeTitle: UILabel = {
        let label = UILabel()
        label.text = "총 공부시간"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(hexCode: "#505050")
        return label
    }()
    
    private lazy var lbStudytime: UILabel = {
        let label = UILabel()
        label.text = "00:26:12"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(hexCode: "#3B9B5B")
        return label
    }()
    
    private lazy var attainmentrateView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var lbAttainmentrateTitle: UILabel = {
        let label = UILabel()
        label.text = "달성률"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(hexCode: "#505050")
        return label
    }()
    
    private lazy var lbAttainmentrate: UILabel = {
        let label = UILabel()
        label.text = "30%"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(hexCode: "#3B9B5B")
        return label
    }()
    
    private lazy var timeSeparatorView0: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "#B9B9B9")
        return view
    }()
    
    private lazy var timeSeparatorView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "#B9B9B9")
        return view
    }()
    
    private lazy var totalStudyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundGray
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var totalStudyTopView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var lbTotalStudyTitle: UILabel = {
        let label = UILabel()
        label.text = "총 공부시간"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(hexCode: "#505050")
        return label
    }()
    
    public lazy var btnSubject: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(resource: .down)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 8
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 16)
        container.foregroundColor = UIColor(hexCode: "#797979")
        configuration.attributedTitle = AttributedString("모든 과목", attributes: container)
        
        button.configuration = configuration
        return button
    }()
    
    private lazy var totalStudySeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "#C9C2C2")
        return view
    }()
    
    public lazy var svMonth: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bouncesVertically = false
        scrollView.isUserInteractionEnabled = false
        return scrollView
    }()
    
    private lazy var stvMonth: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.spacing = 62
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    func setStvMonth(monthEnum: MonthEnum) {
        let months = MonthEnum.allCases
        for index in 0..<months.count {
            let label = UILabel()
            label.font = .systemFont(ofSize: 12)
            label.text = months[(monthEnum.rawValue+index)%months.count].name
            label.textColor = UIColor(hexCode: "#797979")
            stvMonth.addArrangedSubview(label)
        }
    }
    
    private lazy var stvDay: UIStackView = {
        let stackView = UIStackView()
        let days = [
            "월", "화", "수", "목", "금", "토", "일",
        ]
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        for day in days {
            let label = UILabel()
            label.font = .systemFont(ofSize: 12)
            label.text = day
            label.textColor = UIColor(hexCode: "#797979")
            stackView.addArrangedSubview(label)
        }
        return stackView
    }()
    
    public lazy var cvTotalStudy: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .init(width: 20, height: 20)
        layout.itemSize = .init(width: 20, height: 20)
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(GreenCollectionViewCell.self, forCellWithReuseIdentifier: GreenCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private lazy var studyChartView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundGray
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var lbStudyChartTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(hexCode: "#505050")
        label.text = "시간별 공부시간"
        return label
    }()
    
    private lazy var studyChartSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "#C9C2C2")
        return view
    }()
    
    public lazy var cvStudyChart: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .init(width: 32, height: 167)
        layout.itemSize = .init(width: 32, height: 167)
        layout.minimumInteritemSpacing = 6
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(ChartCollectionViewCell.self, forCellWithReuseIdentifier: ChartCollectionViewCell.identifier)
        
        return collectionView
    }()
}
