//
//  SettingsLauncher.swift
//  YouTube_Project
//
//  Created by Admin on 20.01.2023.
//

import UIKit

// for settings pop

class Setting {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class SettingsLauncher: NSObject {
    
    let blackView = UIView()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        return tableView
    }()
    let cellHeight: CGFloat = 50
    let settings: [Setting] = {
        return [Setting(name: "Settings", imageName: "settings"),Setting(name: "Terms & privacy policy", imageName: "privacy"),Setting(name: "Send feedback", imageName: "feedback"),Setting(name: "Help", imageName: "help"),Setting(name: "Switch Account", imageName: "switch_account"),Setting(name: "Cancel", imageName: "cancel")]
    }()
    
    func showSettings() {
        
        // show menu
        // keyWindow yerine bulduğum çözüm
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        
        if let window = windowScene?.windows.first {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(tableView)
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            tableView.frame = CGRectMake(0, window.frame.height, window.frame.width, height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
                self.blackView.alpha = 1
                self.tableView.frame = CGRectMake(0, y, self.tableView.frame.width,                                        self.tableView.frame.height)
            }
            
        }
    }
    
    @objc func  handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            
            if let window = windowScene?.windows.first {
                self.tableView.frame = CGRectMake(0, window.frame.height, self.tableView.frame.width, self.tableView.frame.height)
            }
            
        }
    }
    
    override init() {
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}


extension SettingsLauncher: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    
}
