//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 07/07/23.
//

import Foundation
import SDWebImage
import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    public var shared = ProfileViewController()
    
    private let tableView: UITableView = {
            let tableView = UITableView()
            tableView.isHidden = true
            tableView.register(UITableViewCell.self,
                               forCellReuseIdentifier: "cell")
            return tableView
        }()

    private var models = [String]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        fetchProfile()
        view.backgroundColor = .systemBackground
       
    }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            tableView.frame = view.bounds
        }
    private func fetchProfile() {
            APICaller.shared.getCurrentUserProfile { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let model):
                        self?.updateUI(with: model)
                    case .failure(let error):
                        print("Profile Error: \(error.localizedDescription)")
                        self?.failedToGetProfile()
                    }
                }
            }
        }
    
    
    private func updateUI(with model: UserProfile) {
            tableView.isHidden = false
            // configure table models
            models.append("Full Name: \(model.display_name)")
            models.append("Email Address: \(model.email)")
            models.append("User ID: \(model.id)")
            models.append("Plan: \(model.product)")
            createTableHeader(with: model.images.first?.url)
            tableView.reloadData()
        }
    private func createTableHeader(with string: String?){
        guard let uriString = string, let url = URL(string: uriString) else {
            return
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))
        let imageSize : CGFloat = headerView.height/2
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageview)
        imageview.center = headerView.center
        imageview.contentMode = .scaleAspectFill
        imageview.sd_setImage(with: url, completed: nil)
        imageview.layer.masksToBounds = true
        imageview.layer.cornerRadius = imageSize/2
        tableView.tableHeaderView = headerView
    }
    
    
    private func failedToGetProfile() {
            let label = UILabel(frame: .zero)
            label.text = "Failed to load profile."
            label.sizeToFit()
            label.textColor = .secondaryLabel
            view.addSubview(label)
            label.center = view.center
        }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = models[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
