//
//  ViewController.swift
//  YouTube_Project
//
//  Created by Admin on 17.01.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(VideoViewCell.self, forCellReuseIdentifier: VideoViewCell.identifier)
        //navigation bar heightına 50 verdiğimiz için toptan 50 boşluk bırakacak
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        // scroll etmeye navigation barın 50 birim altından yani bittiği yerden başlayacak.
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    // accesing the model in the viewcontroller
    var model = Model()
    var videos = [VideoModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegates()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        model.getVideos()
        
        setNavigationBarItem()
        setupMenuBar()
        setNavBarButtons()
    }
    
    func setNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    
        
    }
    lazy var settingsLauncher : SettingsLauncher = {
        var launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
     
    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
    func showControllerForSetting(setting: Setting) {
        let dummySettingViewController = UIViewController()
        dummySettingViewController.navigationItem.title = setting.name.rawValue
//        dummySettingViewController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.blue]
        dummySettingViewController.view.backgroundColor = .white
//        navigationController?.navigationBar.tintColor = .black
        navigationController?.pushViewController(dummySettingViewController, animated: true)
    }
    
    
    
    @objc func handleSearch() {
        print(123)
        
    }
    
    // Menu barın nerede olacağı ve yüksekliği belirleniyor.
    let menuBar: MenuBar = {
        let navbar = MenuBar()
        return navbar
    }()
    
    func setupMenuBar() {
//        navigationController?.hidesBarsOnSwipe = true
        view.addSubview(menuBar)
        menuBar.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    } 
    

    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

       if(velocity.y>0) {
           UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
               self.navigationController?.setNavigationBarHidden(true, animated: true)
               self.navigationController?.setToolbarHidden(true, animated: true)
               self.view.addSubview(self.menuBar)
               self.menuBar.snp.remakeConstraints { make in
                   make.top.equalTo(self.view.safeAreaLayoutGuide)
                   make.leading.equalToSuperview()
                   make.trailing.equalToSuperview()
//                   make.height.equalTo(50)
               }
               print("Hide")
           }, completion: nil)

       } else {
           UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
               self.navigationController?.setNavigationBarHidden(false, animated: true)
               self.navigationController?.setToolbarHidden(false, animated: true)
               self.view.addSubview(self.menuBar)
               self.menuBar.snp.remakeConstraints { make in
                   make.top.equalTo(self.view.safeAreaLayoutGuide)
                   make.leading.equalToSuperview()
                   make.trailing.equalToSuperview()
                   make.height.equalTo(50)
               }
               print("Unhide")
           }, completion: nil)
         }
      }

    
    //set the color of the status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func setNavigationBarItem() {
        
        UINavigationBar.appearance().isTranslucent = false
    //    navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
        // Make the navigation bar's title with red text.
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemRed
        appearance.titleTextAttributes = [.foregroundColor: UIColor.lightText] // With a red background, make the title more readable.
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance // For iPhone small navigation bar in landscape.
        
        // navigation bar ile top safe area arasındaki kalan çizgiyi yok etme
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
       /* let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
        imageView.image = UIImage(named: "logo")
        navigationItem.titleView = imageView
        */
    }
    
    func setDelegates() {
        
        tableView.delegate = self
        tableView.dataSource = self
        model.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

// MARK: TableView Methods

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoViewCell.identifier, for: indexPath) as! VideoViewCell
        let video = self.videos[indexPath.row]
            
        cell.setCell(video)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = (view.frame.width - 16 - 16) * 9 / 16 // returns 1.77 , aspect ratio for image
        return (height + 16 + 68) // ayrıca heightteki vermiş olduğumuz yükseklikleri de eklememiz gerekiyor
    }
   
    
    
}


// MARK: Model Delegate Methods

extension ViewController: ModelDelegate {
    func videosFetched(_ videos: [VideoModel]) {
        
        // set the returned video to our video property
        
        self.videos = videos
        
        // refresh tableview
        
         tableView.reloadData()
    }
    
    
}

