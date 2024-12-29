//
//  CircleTimerVIew.swift
//  Hackathon1229
//
//  Created by KoNangYeon on 12/29/24.
//

import UIKit

class CircleTimerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var timer: Timer?
    private var shapeLayer: CAShapeLayer!
    private var backgroundLayer: CAShapeLayer!
    private var handleView: UIView!
    private var timerLabel: UILabel!
    private lazy var btn1 = UIButton()
    private var duration: TimeInterval = 60 // 타이머 총 시간 (초)
    private var displayLink: CADisplayLink?
    private var remainingTime: TimeInterval = 0

    private func setupView() {
        // 배경 원형 레이어
        backgroundLayer = CAShapeLayer()
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.lineWidth = 10
        backgroundLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(backgroundLayer)

        // 타이머 원형 레이어
        shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        layer.addSublayer(shapeLayer)

        // 타이머 라벨
        timerLabel = UILabel()
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        timerLabel.textColor = UIColor(hexCode: "414E2E")
        timerLabel.text = formatTime(from: remainingTime)
        addSubview(timerLabel)

        // 핸들(작은 원 버튼)
        handleView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        handleView.backgroundColor = UIColor.white
        handleView.layer.cornerRadius = 10
        addSubview(handleView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews called. Bounds: \(bounds)") // 디버깅 로그

        // 레이어 경로 갱신
        let path = circularPath()
        backgroundLayer.path = path.cgPath
        shapeLayer.path = path.cgPath

        // 핸들 초기 위치 설정
        handleView.center = pointOnCircle(at: 0)
        timerLabel.frame = bounds // 라벨 크기 동기화
    }

    private func circularPath() -> UIBezierPath {
        let radius = bounds.width / 2 - shapeLayer.lineWidth / 2
        return UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                            radius: radius,
                            startAngle: -CGFloat.pi / 2,
                            endAngle: 3 * CGFloat.pi / 2,
                            clockwise: true)
    }

    private func pointOnCircle(at progress: CGFloat) -> CGPoint {
        let angle = -CGFloat.pi / 2 + progress * 2 * CGFloat.pi
        let radius = bounds.width / 2 - shapeLayer.lineWidth / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        return CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
    }

    @objc func startTimer() {
        print("Start timer called") // 디버깅 로그
        remainingTime = duration
        shapeLayer.strokeEnd = 0 // 초기화
        timerLabel.text = formatTime(from: remainingTime)

        timer?.invalidate()
        displayLink?.invalidate()

        // 애니메이션 설정
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1.0
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        shapeLayer.add(animation, forKey: "circleAnimation")
        print("Animation added. Duration: \(animation.duration)") // 디버깅 로그

        // 핸들 동기화 애니메이션
        displayLink = CADisplayLink(target: self, selector: #selector(updateHandlePosition))
        displayLink?.add(to: .main, forMode: .default)

        // 타이머 카운트다운
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            self.remainingTime -= 1
            self.timerLabel.text = self.formatTime(from: self.remainingTime)

            if self.remainingTime <= 0 {
                timer.invalidate()
                self.displayLink?.invalidate()
                self.shapeLayer.strokeEnd = 1.0
                print("Timer ended") // 디버깅 로그
            }
        }
    }

    @objc private func updateHandlePosition() {
        guard let presentationLayer = shapeLayer.presentation() else {
            print("Presentation layer is nil") // 디버깅 로그
            return
        }
        let strokeEnd = presentationLayer.strokeEnd
        handleView.center = pointOnCircle(at: CGFloat(strokeEnd))
        print("Handle updated. StrokeEnd: \(strokeEnd)") // 디버깅 로그
    }

    private func formatTime(from timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = (Int(timeInterval) % 3600) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d : %02d : %02d", hours, minutes, seconds)
    }
}
