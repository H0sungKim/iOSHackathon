//
//  AddSubjectViewController.swift
//  Hackathon1229
//
//  Created by 주민영 on 12/29/24.
//

import UIKit
import Combine

protocol AddSubjectViewControllerDelegate: AnyObject {
    func didAddSubject(_ subject: SubjectModel)
}

class AddSubjectViewController: UIViewController {
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    weak var delegate: AddSubjectViewControllerDelegate?
    
    private(set) var textFieldEvent = PassthroughSubject<String, Never>()
    
    var newSubject: SubjectModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addSubjectView
        
        textFieldEvent
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink(receiveValue: { text in
                print(text)
                self.addSubjectView.stvRecommendedKeyword.arrangedSubviews.forEach { $0.removeFromSuperview() }
                
                CommonRepository.shared.getRecommendedKeywords(userInput: text)
                    .sink(receiveCompletion: { error in
                        print(error)
                    }, receiveValue: { result in
                        result.result.forEach({
                            let label = UILabel()
                            label.backgroundColor = .white
                            label.text = $0
                            self.addSubjectView.stvRecommendedKeyword.addArrangedSubview(label)
                        })
                        print(result.result)
                    })
                    .store(in: &self.cancellable)
            })
            .store(in: &cancellable)
    }
    
    private lazy var addSubjectView: AddSubjectView = {
        let view = AddSubjectView()
        view.addBtn.addTarget(self, action: #selector(btnDidTap), for: .touchUpInside)
        view.titleTextField.addTarget(self, action: #selector(textFieldDidChanged(sender:)), for: .editingChanged)
        return view
    }()
    
    @objc private func textFieldDidChanged(sender: UITextField) {
        textFieldEvent.send(sender.text ?? "")
    }
    
    @objc private func btnDidTap() {
        let selectedDuration = addSubjectView.timePicker.countDownDuration // 초 단위로 반환
        let hours = Int(selectedDuration) / 3600 // 시간 계산
        let minutes = (Int(selectedDuration) % 3600) / 60 // 분 계산
        
        CommonRepository.shared.setSubjectGoal(subjectGoalRequest: SubjectGoalRequest(subjectName: addSubjectView.titleTextField.text ?? "", goalHour: hours, goalMinute: minutes))
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { result in
                self.newSubject = SubjectModel(id: result.result.id,title: result.result.subjectName, time: "\(hours)시간 \(minutes)분", remainTime: result.result.remainTime ?? 0)
                self.delegate?.didAddSubject(self.newSubject!)
            })
            .store(in: &cancellable)
        dismiss(animated: true, completion: nil)
    }

}
