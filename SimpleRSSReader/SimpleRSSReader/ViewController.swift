//
//  ViewController.swift
//  SimpleRSSReader
//
//  Created by yongbeomkwak on 2/6/24.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let feedParser = FeedParser()
    fileprivate let feedURL = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
      
    fileprivate var rssItems: [(title: String, description: String, pubDate: String)]?
    fileprivate var cellStates: [CellState]?
    
    var tableView: UITableView = {
        
        let view = UITableView()
       
        view.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.id)
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(tableView)
        
        tableView.fillSuperview()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        
        feedParser.parseFeed(feedURL: feedURL) { [weak self] rssItems in
            
            self?.rssItems = rssItems
            self?.cellStates = Array(repeating: .collapsed, count: rssItems.count)
            
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
            
        }
        
    }


}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        
        tableView.beginUpdates()
        cell.descriptionLabel.numberOfLines =  cell.descriptionLabel.numberOfLines == 4 ? 0 : 4
        cellStates?[indexPath.row] = cell.descriptionLabel.numberOfLines == 4 ? .collapsed : .expanded
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let rssItems = rssItems else {
            return 0
        }
        
        return rssItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.id, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        
           if let item = rssItems?[indexPath.row] {
             (cell.titleLabel.text, cell.descriptionLabel.text, cell.dateLabel.text) = (item.title, item.description, item.pubDate)
             
             if let cellState = cellStates?[indexPath.row] {
               cell.descriptionLabel.numberOfLines = cellState == .expanded ? 0: 4
             }
           }
        
        return cell
        
    }
    
    
}

