//
//  TimerPageViewController.swift
//  Hackathon1229
//
//  Created by 김호성 on 2025.01.04.
//

import Foundation
import UIKit
import SnapKit

class TimerPageViewController: UIViewController {
    
    private var timerViewControllers: [UIViewController]!
    
    private lazy var pageViewController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerViewControllers = [
            TimerViewController(subject: "국어", time: 60),
            TimerViewController(subject: "수학", time: 600),
        ]
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addComponents()
        
        if let firstViewController = timerViewControllers.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
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
