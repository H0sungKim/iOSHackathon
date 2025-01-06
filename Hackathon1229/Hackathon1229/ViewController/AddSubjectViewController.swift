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
                CommonRepository.shared.getRecommendedKeywords(userInput: text)
                    .debounce(for: 1, scheduler: RunLoop.main)
                    .sink(receiveCompletion: { error in
                        print(error)
                    }, receiveValue: { result in
                        print(result.result)
                    })
                    .store(in: &self.cancellable)
            })
            .store(in: &cancellable)
    }
    
    private lazy var addSubjectView: AddSubjectView = {
        let view = AddSubjectView()
        view.addBtn.addTarget(self, action: #selector(btnDidTap), for: .touchUpInside)
        view.titleTextField.delegate = self
        return view
    }()
    
    @objc private func btnDidTap() {
        let selectedDuration = addSubjectView.timePicker.countDownDuration // 초 단위로 반환
        let hours = Int(selectedDuration) / 3600 // 시간 계산
        let minutes = (Int(selectedDuration) % 3600) / 60 // 분 계산
        newSubject = SubjectModel(title: addSubjectView.titleTextField.text ?? "선택 안함", time: "\(hours)시간 \(minutes)분")
        CommonRepository.shared.setSubjectGoal(subjectGoalRequest: SubjectGoalRequest(subjectName: addSubjectView.titleTextField.text ?? "", goalHour: hours, goalMinute: minutes))
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { result in
                print(result)
            })
            .store(in: &cancellable)
        delegate?.didAddSubject(newSubject!)
        dismiss(animated: true, completion: nil)
    }

}


extension AddSubjectViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        if let textRange = Range(range, in: currentText) {
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            textFieldEvent.send(updatedText)
        }
        return true
    }
}
