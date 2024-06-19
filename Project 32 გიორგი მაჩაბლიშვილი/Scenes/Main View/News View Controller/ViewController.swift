//
//  ViewController.swift
//  Project 32 გიორგი მაჩაბლიშვილი
//
//  Created by Gio's Mac on 19.06.24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var newsTableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var newsInfo: [Articles] = []
    
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layouts()
        loadData()
        refreshNews()
        
    }
    
    func setup() {
        view.addSubview(newsTableView)
    }
    
    func layouts() {
        newsTableView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func loadData() {
        let urlString = "https://saurav.tech/NewsAPI/everything/cnn.json"
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            
            guard let data else {
                return
            }
            
            do {
                let info = try JSONDecoder().decode(NewsInfo.self, from: data)
                DispatchQueue.main.async {
                    self.newsInfo = info.articles
                    self.newsTableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func refreshNews() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(newsInfoRefresh), for: .valueChanged)
        newsTableView.refreshControl = refreshControl
    }
    
    @objc func newsInfoRefresh() {
        loadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                   self.refreshControl.endRefreshing()
               }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        let newsInfos = newsInfo[indexPath.row]
        cell.configure(with: newsInfos)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
}
