//
//  TimerPageViewController.swift
//  Hackathon1229
//
//  Created by 김호성 on 2025.01.04.
//

import Foundation
import UIKit
import SnapKit
import Combine

class TimerPageViewController: UIViewController {
    
    private var timerViewControllers: [UIViewController]!
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private lazy var pageViewController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CommonRepository.shared.getSubjects()
            .sink(receiveCompletion: { error in
                print("getsubjects")
                print(error)
            }, receiveValue: { [weak self] result in
                print(result.result)
                self?.timerViewControllers = []
                for index in 0..<result.result.timerPreviewDTOList.count {
                    let subjectGoalResponse = result.result.timerPreviewDTOList[index]
                    self?.timerViewControllers.append(TimerViewController(total: self?.timerViewControllers?.count ?? 0,index: index,subject: subjectGoalResponse.subjectName, time: Int(subjectGoalResponse.remainTime ?? Float(subjectGoalResponse.goalTime))*60))
                }
                if let firstViewController = self?.timerViewControllers.first {
                    self?.pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
                }
                for index in 0..<(self?.timerViewControllers.count ?? 0) {
                    guard let timerViewController = self?.timerViewControllers[index] as? TimerViewController else {
                        return
                    }
                    timerViewController.timerView.progressTitle.text = "\(index+1)/\(self!.timerViewControllers.count)"
                }
            })
            .store(in: &cancellable)
    }
    
    
    private func addComponents() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.snp.makeConstraints({ make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        })
    }
}

extension TimerPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = timerViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return timerViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = timerViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == timerViewControllers.count {
            return nil
        }
        return timerViewControllers[nextIndex]
    }
}
