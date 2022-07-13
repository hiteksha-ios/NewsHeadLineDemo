//
//  ViewController.swift
//  NewsHeadlineDemo
//
//  Created by Admin on 7/13/22.
//

import UIKit
import SafariServices

class NewsListVC: UIViewController {
    
    @IBOutlet weak var newsFeedTableView: UITableView!
    
    
    private var newsFeedListVM : NewsFeedListViewModel!
    private let refreshController = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI(){
        self.newsFeedTableView.tableFooterView = UIView()
        self.getData(isRefresh: false)
    }

    func configureTableView(){
        refreshController.tintColor = .white
        refreshController.addTarget(self, action: #selector(refreshNewsFeedData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            newsFeedTableView.refreshControl = refreshController
        } else {
            newsFeedTableView.addSubview(refreshController)
        }
        
        newsFeedTableView.register(NewsFeedCell.className)
        newsFeedTableView.dataSource = self
        newsFeedTableView.delegate = self
        newsFeedTableView.reload()
    }
    
    @objc private func refreshNewsFeedData(_ sender: Any) {
        // Fetch Flight Data
        fetchFlightData(isFromRefresh : true)
    }
    
    func fetchFlightData(isFromRefresh: Bool = false){
        self.refreshController.beginRefreshing()
        PersistanceStoreManager.shared.getNewsFeed(isShowIndicator: !isFromRefresh, data:{ [self] in
            self.getData()
            self.refreshController.endRefreshing()
        })
    }
    func getData(isRefresh: Bool = true){
        let resultData = RealmHelper.shared.getAllFlightObjects()
        if resultData.isEmpty == false {
            let arrNewsDetails =   resultData.toArray()
            self.newsFeedListVM = NewsFeedListViewModel(newsDetails: arrNewsDetails)
            self.configureTableView()
        }
        if isRefresh == false {
            self.fetchFlightData()
        }
        
    }
}


extension NewsListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsFeedListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.className, for: indexPath) as? NewsFeedCell else {
            fatalError("NewsFeedCell not found")
        }
        cell.configure(newsDetails: self.newsFeedListVM.newsAtIndex(indexPath).newsDetail)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsList = self.newsFeedListVM.newsAtIndex(indexPath).newsDetail
        if let url = URL (string: newsList.articleUrl) {
                        let objVC = SFSafariViewController(url:url)
                        objVC.delegate = self
            self.present(objVC, animated: true, completion: nil)
                    }
    }
    
}

extension NewsListVC: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
