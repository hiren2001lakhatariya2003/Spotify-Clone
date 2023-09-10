//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 07/07/23.
//

import UIKit
class WelcomeViewController: UIViewController {
    
    private let SignupButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Sign up for free", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        return button
    }()
    
    private let MobileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Continue with phone number", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    private let MobileImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "iphone.gen2"))
            imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
            return imageView
        }()
    
    private let GoogleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Continue with Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    private let GoogleImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "google"))
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
    
    private let FacebookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Continue with Facebook", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    private let FacebookImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "facebook"))
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
    
    private let AppleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Continue with Apple", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    private let AppleImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "apple"))
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(named: "signIn")
            return imageView
        }()

        private let overlayView: UIView = {
            let view = UIView()
            view.backgroundColor = .black
            view.alpha = 0.7
            return view
        }()
    
    private let logoImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "main_logo"))
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()

        private let label: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textAlignment = .center
            label.textColor = .white
            label.font = .systemFont(ofSize: 28, weight: .semibold)
            label.text = "Millions of songs.\nFree on Spotify."
            return label
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.addSubview(imageView)
        view.addSubview(overlayView)
        view.backgroundColor = .systemBackground
        view.addSubview(signInButton)
        view.addSubview(AppleButton)
        view.addSubview(AppleImageView)
        
        view.addSubview(FacebookButton)
        view.addSubview(FacebookImageView)
        
        view.addSubview(GoogleButton)
        view.addSubview(GoogleImageView)
        
        view.addSubview(MobileButton)
        view.addSubview(MobileImageView)
        
        view.addSubview(SignupButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        view.addSubview(label)
        view.addSubview(logoImageView)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = view.bounds
        overlayView.frame = view.bounds
        signInButton.frame = CGRect(
            x: 20,
            y: view.height-60-view.safeAreaInsets.bottom,
            width: view.width-40,
            height: 50
        )
        
        AppleButton.frame = CGRect(
            x: 20,
            y: signInButton.top - 60,
            width: view.width-40,
            height: 50
        )
        
        AppleImageView.frame = CGRect(
            x: AppleButton.left + 10,
            y: AppleButton.center.y - 15,
            width: 40,
            height: 30
        )
        
        FacebookButton.frame = CGRect(
            x: 20,
            y: AppleButton.top - 60,
            width: view.width-40,
            height: 50
        )
        
        FacebookImageView.frame = CGRect(
            x: FacebookButton.left + 10,
            y: FacebookButton.center.y - 15,
            width: 40,
            height: 30
        )
        
        GoogleButton.frame = CGRect(
            x: 20,
            y: FacebookButton.top - 60,
            width: view.width-40,
            height: 50
        )
        
        GoogleImageView.frame = CGRect(
            x: GoogleButton.left + 10,
            y: GoogleButton.center.y - 15,
            width: 40,
            height: 30
        )
        
        MobileButton.frame = CGRect(
            x: 20,
            y: GoogleButton.top - 60,
            width: view.width-40,
            height: 50
        )
        
        MobileImageView.frame = CGRect(
            x: MobileButton.left + 10,
            y: MobileButton.center.y - 15,
            width: 40,
            height: 30
        )
        
        SignupButton.frame = CGRect(
            x: 20,
            y: MobileButton.top - 60,
            width: view.width-40,
            height: 50
        )
        
        
        
        logoImageView.frame = CGRect(x: (view.width-60)/2, y: (view.height-300)/2, width: 60, height: 60)
        label.frame = CGRect(x: 30, y: logoImageView.bottom-30, width: view.width-60, height: 150)
        
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
