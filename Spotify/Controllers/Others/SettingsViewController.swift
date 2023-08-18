//
//  SettingsViewController.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 07/07/23.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    private let tableView: UITableView = {
           let tableView = UITableView(frame: .zero, style: .grouped)
           tableView.register(UITableViewCell.self,
                              forCellReuseIdentifier: "cell")
           return tableView
       }()
    
    private var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        title = "Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureModels() {
           sections.append(Section(title: "Profile", options: [Option(title: "View Your Profile", handler: { [weak self] in
               DispatchQueue.main.async {
                   self?.viewProfile()
               }
           })]))

           sections.append(Section(title: "Account", options: [Option(title: "Sign Out", handler: { [weak self] in
               DispatchQueue.main.async {
                   self?.signOutTapped()
               }
           })]))
       }
    private func viewProfile() {
            let vc = ProfileViewController()
            vc.title = "Profile"
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        }
    private func signOutTapped() {
        
    }
    
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           tableView.frame = view.bounds
       }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = sections[indexPath.section].options[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        model.handler()
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
}
