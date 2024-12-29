//
//  HomeViewController.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addStudyTimeView
    }
    
    private lazy var addStudyTimeView: AddStudyTimeView = {
        let view = AddStudyTimeView()
        return view
    }()
}
