//
//  SettingsLauncher.swift
//  YouTube_Project
//
//  Created by Admin on 20.01.2023.
//

import UIKit

// for settings pop

class Setting {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
// The enum is used because if you want to change string of a piece of text at another time, the application will not crash
enum SettingName: String {
    case Cancel = "Cancel"
    case Settings = "Settings"
    case TermsPrivacy = "Terms & privacy"
    case SendFeedback = "Send feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
}

class SettingsLauncher: NSObject {
    
    let blackView = UIView()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        return tableView
    }()
    let settings: [Setting] = {
        let settingsSetting = Setting(name: .Settings, imageName: "settings")
        let termsPrivacySetting = Setting(name: .TermsPrivacy, imageName: "privacy")
        let feedbackSetting = Setting(name: .SendFeedback, imageName: "feedback")
        let helpSetting = Setting(name: .Help, imageName: "help")
        let switchAccountSetting = Setting(name: .SwitchAccount, imageName: "switch_account")
        let cancelSetting = Setting(name: .Cancel, imageName: "cancel")
        
        return[settingsSetting,termsPrivacySetting,feedbackSetting,helpSetting,switchAccountSetting,cancelSetting]
    }()
    
    var homeController: ViewController?
    
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

let cellHeight: CGFloat = 50

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
        return cellHeight
    }
  
   //TODO: setting ayarlar menüsü seçildiğinde arka plan darkgray yazı white yap!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath)! 
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.blackView.alpha = 0
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            
            if let window = windowScene?.windows.first {
                self.tableView.frame = CGRectMake(0, window.frame.height, self.tableView.frame.width, self.tableView.frame.height)
            }
        } completion: { (completed: Bool) in
            let setting = self.settings[indexPath.item]
            if setting.name != .Cancel{
                self.homeController?.showControllerForSetting(setting: setting)
            }
        }
    }
    
}
 
