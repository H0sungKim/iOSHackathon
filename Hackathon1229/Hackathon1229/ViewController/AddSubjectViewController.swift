//
//  AddSubjectViewController.swift
//  Hackathon1229
//
//  Created by 주민영 on 12/29/24.
//

import UIKit

class AddSubjectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addSubjectView
    }
    
    private lazy var addSubjectView: AddSubjectView = {
        let view = AddSubjectView()
        return view
    }()

}
