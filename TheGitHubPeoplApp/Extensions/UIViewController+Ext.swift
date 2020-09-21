//
//  UIViewController+Ext.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 17/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

private var containerView: UIView!

extension UIViewController {
    func presentRPAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = RPAlertController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    //step 1 create a function for showing laoding screen with spinner
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        //step 2 create spinner
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        //step 3 add contraints
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
        activityIndicator.startAnimating()
    }
    //step 4 create a dismiss function
    func dismissLoadingView() {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.25, animations: {
                    containerView.alpha = 0.0
                }, completion: { _ in
                    containerView.removeFromSuperview()
                    containerView = nil
                })
            }
    }
}
