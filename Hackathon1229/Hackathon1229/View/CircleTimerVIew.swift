//
//  CircleTimerVIew.swift
//  Hackathon1229
//
//  Created by KoNangYeon on 12/29/24.
//

import UIKit
import Combine

class CircleTimerView: UIView {
    
    var index: Int!
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private var startTime: String?
    private var endTime: String?
    
    var presentAlert: (() -> Void)?
    
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
    
    public var subjectLabel: UILabel = {
        let label = UILabel()
        label.text = "sample"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor(hexCode: "797979")
        return label
    }()
    
    public var timerLabel: UILabel!
    
    private lazy var btn1 = UIButton().then {
        var config = UIButton.Configuration.plain()
        
        config.imagePadding = 7
        $0.backgroundColor = UIColor(hexCode: "E6E6E6")
        $0.layer.cornerRadius = 18.5
        $0.setTitle("10:00", for: .normal)
        $0.setImage(UIImage(resource: .vector), for: .normal)
        $0.setTitleColor(UIColor(hexCode: "797979"), for: .normal)
        
        $0.configuration = config
    }
    
    public var duration: TimeInterval = 60 {
        didSet {
            timerLabel.text = formatTime(from: duration)
        }
    } // 타이머 총 시간 (초)
    private var displayLink: CADisplayLink?
    private var remainingTime: TimeInterval = 0

    private func setupView() {
        // 배경 원형 레이어
        backgroundLayer = CAShapeLayer()
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.lineWidth = 14
        backgroundLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(backgroundLayer)

        // 타이머 원형 레이어
        shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(hexCode: "01D281").cgColor
        shapeLayer.lineWidth = 14
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        layer.addSublayer(shapeLayer)

        // 타이머 라벨
        timerLabel = UILabel()
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        timerLabel.textColor = UIColor(hexCode: "414E2E")
        timerLabel.text = formatTime(from: duration)
        addSubview(timerLabel)
        
        addSubview(subjectLabel)
        subjectLabel.snp.makeConstraints{
            $0.top.equalTo(timerLabel.snp.top).offset(85)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(btn1)
        btn1.snp.makeConstraints{
            $0.top.equalTo(subjectLabel.snp.bottom).offset(72)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(97)
            $0.height.equalTo(37)
        }

        // 핸들(작은 원 버튼)
        handleView = UIView(frame: CGRect(x: 0, y: 0, width: 21, height: 21))
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
    
    var isRunning = false
    
    @objc func toggleTimer(_ sender: UIButton) {
        // 상태 변경 전에 디버그 로그
        print("Before toggle: isSelected = \(sender.isSelected), isRunning = \(isRunning)")
        
        // 버튼 상태 변경
        sender.isSelected.toggle()
        isRunning = sender.isSelected // 실행 상태 동기화

        // 상태 변경 후 디버그 로그
        print("After toggle: isSelected = \(sender.isSelected), isRunning = \(isRunning)")

        // 상태에 따라 동작 및 이미지 설정
        if isRunning {
            startTimer()
        } else {
            stopTimer()
        }
    }




    private func startTimer() {
        CommonRepository.shared.startTimer(subjectId: index)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { result in
                print(result)
            })
            .store(in: &cancellable)
        startTime = CalendarManager.shared.getISO8601DateFormatter()
        print("Start timer called") // 디버깅 로그
        isRunning = true // 상태 변경

        // 현재 진행 상태 확인
        let currentStrokeEnd: CGFloat = shapeLayer.presentation()?.strokeEnd ?? shapeLayer.strokeEnd
        let remainingDuration = remainingTime > 0 ? remainingTime : duration * (1.0 - Double(currentStrokeEnd))

        // 초기 상태 설정
        shapeLayer.strokeEnd = currentStrokeEnd
        remainingTime = remainingDuration
        timerLabel.text = formatTime(from: remainingTime)

        // 기존 애니메이션과 타이머 초기화
        timer?.invalidate()
        displayLink?.invalidate()

        // 새로운 애니메이션 설정
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = currentStrokeEnd // 현재 상태에서 시작
        animation.toValue = 1.0
        animation.duration = remainingDuration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        shapeLayer.add(animation, forKey: "circleAnimation")
        print("Animation added. From: \(currentStrokeEnd), Duration: \(animation.duration)") // 디버깅 로그

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
                self.realStopTimer() // 타이머 완료 시 정지
                print("Timer ended") // 디버깅 로그
            }
        }
    }

    private func stopTimer() {
        print("Stop timer called") // 디버깅 로그
        isRunning = false // 상태 변경

        // 타이머 중단
        timer?.invalidate()
        timer = nil

        // 디스플레이 링크 중단
        displayLink?.invalidate()
        displayLink = nil

        // 애니메이션 중단
        shapeLayer.removeAnimation(forKey: "circleAnimation")

        // 현재 진행 상태에서 정지
        if let presentationLayer = shapeLayer.presentation() {
            let strokeEnd = presentationLayer.strokeEnd
            shapeLayer.strokeEnd = strokeEnd // 애니메이션 상태 고정
            handleView.center = pointOnCircle(at: CGFloat(strokeEnd)) // 핸들 위치 갱신
            print("Animation stopped at strokeEnd: \(strokeEnd)") // 디버깅 로그
        }

        // UI 갱신
        timerLabel.text = formatTime(from: remainingTime)
        endTime = CalendarManager.shared.getISO8601DateFormatter()
        CommonRepository.shared.pauseTimer(subjectId: index, param: TimerRequest(startTime: startTime!, endTime: endTime!))
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { result in
                print(self.index)
                print(self.startTime)
                print(self.endTime)
                if result.code == "DATEPLAN4003" {
                    self.presentAlert?()
                }
            })
            .store(in: &cancellable)
    }
    
    @objc func realStopTimer() {
        print("Reset and stop timer called") // 디버깅 로그

        // 타이머 중단
        timer?.invalidate()
        timer = nil

        // 디스플레이 링크 중단
        displayLink?.invalidate()
        displayLink = nil

        // 애니메이션 초기화
        shapeLayer.removeAnimation(forKey: "circleAnimation")
        shapeLayer.strokeEnd = 0 // 초기 상태로 복구

        // 핸들 위치 초기화
        handleView.center = pointOnCircle(at: 0)

        // 시간 초기화
        remainingTime = duration
        timerLabel.text = formatTime(from: 0)
        
        // 실행 상태 초기화
        isRunning = false
        print("Timer reset to initial state") // 디버깅 로그
        endTime = CalendarManager.shared.getISO8601DateFormatter()
        CommonRepository.shared.stopTimer(subjectId: index, param: TimerRequest(startTime: startTime!, endTime: endTime!))
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { result in
                print(self.index)
                print(self.startTime)
                print(self.endTime)
                if result.code == "DATEPLAN4003" {
                    self.presentAlert?()
                }
            })
            .store(in: &cancellable)
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
