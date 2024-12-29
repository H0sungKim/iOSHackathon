//
//  AddSubjectViewController.swift
//  Hackathon1229
//
//  Created by 주민영 on 12/29/24.
//

import UIKit

protocol AddSubjectViewControllerDelegate: AnyObject {
    func didAddSubject(_ subject: SubjectModel)
}

class AddSubjectViewController: UIViewController {
    
    weak var delegate: AddSubjectViewControllerDelegate?
    
    var newSubject: SubjectModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addSubjectView
    }
    
    private lazy var addSubjectView: AddSubjectView = {
        let view = AddSubjectView()
        view.addBtn.addTarget(self, action: #selector(btnDidTap), for: .touchUpInside)
        return view
    }()
    
    @objc private func btnDidTap() {
        let selectedDuration = addSubjectView.timePicker.countDownDuration // 초 단위로 반환
        let hours = Int(selectedDuration) / 3600 // 시간 계산
        let minutes = (Int(selectedDuration) % 3600) / 60 // 분 계산
        newSubject = SubjectModel(title: addSubjectView.titleTextField.text ?? "선택 안함", time: "\(hours)시간 \(minutes)분")
        
        delegate?.didAddSubject(newSubject!)
        dismiss(animated: true, completion: nil)
    }

}
