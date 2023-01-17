//
//  ViewController.swift
//  YouTube_Project
//
//  Created by Admin on 17.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(VideoViewCell.self, forCellReuseIdentifier: VideoViewCell.identifier)
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
        
        
        //setTableView()
        model.getVideos()
        
        setNavigationBarItem()
        
    }
    //set the color of the status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func setNavigationBarItem() {
        
        UINavigationBar.appearance().isTranslucent = false
        navigationController?.navigationBar.barTintColor = .red
        
        // Make the navigation bar's title with red text.
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemRed
        appearance.titleTextAttributes = [.foregroundColor: UIColor.lightText] // With a red background, make the title more readable.
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance // For iPhone small navigation bar in landscape.
        
       // let titleLabel = NavigationBarView(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height), name: "Home", font: .systemFont(ofSize: 20), color: .white)
        // navigationItem.titleView = titleLabel
        
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        
        //navigationItem.title = "home"
        
        /*
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.left
        

        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
                                                                   NSAttributedString.Key.paragraphStyle: paragraphStyle]
        //TitleSizeLevelOne
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = .red
        navigationController?.navigationBar.shadowImage = UIImage();
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
    
    func setTableView() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
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

