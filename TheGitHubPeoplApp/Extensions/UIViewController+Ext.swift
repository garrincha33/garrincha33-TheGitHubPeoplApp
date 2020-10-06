//
//  UIViewController+Ext.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 17/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit
import SafariServices

// CODE REVIEW: Hm... global var... Why?
private var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

extension UIViewController {
    func presentRPAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = RPAlertController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }

    func showLoadingView() {
        if let indicator = self.view.subviews.last as? UIActivityIndicatorView, indicator === activityIndicator {
            if activityIndicator.isAnimating {
                return
            } else {
                activityIndicator.startAnimating()
            }
        } else {
            self.view.isUserInteractionEnabled = false
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.color = .black

            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            NSLayoutConstraint.activate([
                activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            
            ])
            
            self.view.layoutIfNeeded()
            
        }
    }

    func dismissLoadingView() { //MARK:- bug fix
        DispatchQueue.main.async {
            if let indicator = self.view.subviews.last as? UIActivityIndicatorView, indicator === activityIndicator {
                if activityIndicator.isAnimating {
                    activityIndicator.stopAnimating()
                }
                self.view.isUserInteractionEnabled = true
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    func showEmptyStateView(message: String, in view: UIView) {
        let emptyStateView = RPEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }

    func presentSafariController(with url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        present(safariViewController, animated: true, completion: nil)
    }
}
