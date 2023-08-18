//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 07/07/23.
//

import UIKit
class WelcomeViewController: UIViewController {
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor = .systemBackground
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(
            x: 20,
            y: view.height-50-view.safeAreaInsets.bottom,
            width: view.width-40,
            height: 50
        )
        view.addSubview(signInButton)
        
    }
    @objc func didTapSignIn() {
            let vc = AuthViewController()
            vc.completionHandler = { [weak self] success in
                DispatchQueue.main.async {
                    self?.handleSignIn(success: success)
                }
            }
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        }
    
    private func handleSignIn(success: Bool) {
            // Log user in or yell at them for error
            guard success else {
                let alert = UIAlertController(title: "Oops",
                                              message: "Something went wrong when signing in.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                present(alert, animated: true)
                return
            }

            let mainAppTabBarVC = TabBarViewController()
            mainAppTabBarVC.modalPresentationStyle = .fullScreen
            present(mainAppTabBarVC, animated: true)
        }
}
