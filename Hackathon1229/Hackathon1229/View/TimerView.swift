//
//  TimerView.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit
import SnapKit
import Then

class TimerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var timerTitle = UILabel().then {
        $0.text = "타이머"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    private lazy var backBtn = UIButton().then {
        $0.setTitle("이전", for: .normal)
        $0.setImage(UIImage(resource: .vector17), for: .normal)
    }
    
    private lazy var progressTitle = UILabel().then {
        $0.text = "1/5"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.textColor = UIColor(hexCode: "9A9A9A")
    }
    
    private lazy var btn1 = UIButton().then {
        $0.layer.cornerRadius = 38
        $0.backgroundColor = UIColor(hexCode: "")
    }
    
    private lazy var btn2 = UIButton().then {
        
    }
    
    private lazy var btn3 = UIButton().then {
        
    }
    
    private var shapeLayer: CAShapeLayer!
    private var backgroundLayer: CAShapeLayer!
    private var handleView: UIView!
    private var subjectLabel: UILabel!
    private var timerLabel: UILabel!
    private var duration: TimeInterval = 60 // 타이머의 총 시간 (초)
    
    private func setupView() {
        // 배경 원형 레이어
        backgroundLayer = CAShapeLayer()
        backgroundLayer.path = circularPath().cgPath
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.lineWidth = 10
        backgroundLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(backgroundLayer)
           
        // 타이머 원형 레이어
        shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath().cgPath
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        layer.addSublayer(shapeLayer)
           
        
        // 타이머 라벨
        timerLabel = UILabel()
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        timerLabel.text = "\(Int(duration))"
        timerLabel.frame = bounds
        addSubview(timerLabel)
           
        // 핸들(작은 원 버튼)
        handleView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        handleView.backgroundColor = UIColor.white
        handleView.layer.cornerRadius = 10
        handleView.center = pointOnCircle(at: 0)
        addSubview(handleView)
       }

    private func circularPath() -> UIBezierPath {
            return UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                radius: bounds.width / 2 - 10,
                                startAngle: -CGFloat.pi / 2,
                                endAngle: 3 * CGFloat.pi / 2,
                                clockwise: true)
    }
    
    private func pointOnCircle(at progress: CGFloat) -> CGPoint {
           let angle = -CGFloat.pi / 2 + progress * 2 * CGFloat.pi
           let radius = bounds.width / 2 - 10
           let center = CGPoint(x: bounds.midX, y: bounds.midY)
           return CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
    }
    
    func startTimer() {
        // 원형 테두리 애니메이션
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        shapeLayer.add(animation, forKey: "circleAnimation")
        
        // 핸들 움직임 애니메이션
        let displayLink = CADisplayLink(target: self, selector: #selector(updateHandlePosition))
        displayLink.add(to: .main, forMode: .default)
        
        // 타이머 카운트다운
        var remainingTime = duration
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            remainingTime -= 1
            self.timerLabel.text = "\(Int(remainingTime))"
            
            if remainingTime <= 0 {
                timer.invalidate()
            }
        }
    }
    
    @objc private func updateHandlePosition() {
        let presentationLayer = shapeLayer.presentation()
        let strokeEnd = presentationLayer?.strokeEnd ?? 0
        handleView.center = pointOnCircle(at: CGFloat(strokeEnd))
    }
    
    private func addComponents() {
        [
            timerTitle, backBtn, progressTitle
        ].forEach{
            addSubview($0)
        }
    }
}

