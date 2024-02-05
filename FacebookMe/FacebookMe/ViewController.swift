//
//  ViewController.swift
//  FacebookMe
//
//  Created by yongbeomkwak on 2/5/24.
//

import UIKit

class ViewController: UIViewController {

    typealias RowModel = [String: String]
    
    fileprivate var user : FBMeUser {
        get {
            return FBMeUser(name: "Hamp", education: "CMU")
        }
    }
    
    fileprivate var tableViewDataSource : [[String: Any]] {
        get {
            return TableKeys.populate(withUser: user)
        }
    }
    
    private let tableView : UITableView = {
        
        let view = UITableView(frame: .zero,style: .grouped)
        
        view.register(FBMeCell.self, forCellReuseIdentifier: FBMeCell.id)
       
        return view 
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Specs.color.gray
        
       
        
        
        
        navigationController?.navigationBar.barTintColor = Specs.color.tint
        self.navigationItem.title = "Facebook"
        
        DEBUG_LOG(self.navigationItem.title)
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        
        tableView.fillSuperview()
    }


}

extension ViewController {
    fileprivate func rows(at section: Int) -> [Any] {
      return tableViewDataSource[section][TableKeys.Rows] as! [Any]
    }
    
    fileprivate func title(at section: Int) -> String? {
      return tableViewDataSource[section][TableKeys.Section] as? String
    }
    
    fileprivate func rowModel(at indexPath: IndexPath) -> RowModel {
      return rows(at: indexPath.section)[indexPath.row] as! RowModel
    }
}

extension ViewController : UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let modelForRow = rowModel(at: indexPath)
        
        guard let title = modelForRow[TableKeys.Title] else {
          return 0.0
        }
        
        if title == user.name {
          return 64.0
        } else {
          return 44.0
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let modelForRow = rowModel(at: indexPath)
          
          guard let title = modelForRow[TableKeys.Title] else {
            return
          }
        
        
          if title == TableKeys.seeMore || title == TableKeys.addFavorites {
            cell.textLabel?.textColor = Specs.color.tint
            cell.accessoryType = .none
          } else if title == TableKeys.logout {
            cell.textLabel?.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            cell.textLabel?.textColor = Specs.color.red
            cell.textLabel?.textAlignment = .center
            cell.accessoryType = .none
          } else {
              cell.accessoryType = .disclosureIndicator
          }
        
        
        
    }
    
}

extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return rows(at: section).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        title(at:section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let modelForRow = rowModel(at:indexPath)
        var cell = UITableViewCell()
        
        guard let title = modelForRow[TableKeys.Title] else {
              return cell
            }
            
            if title == user.name {
              cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: nil)
            } else {
              cell = tableView.dequeueReusableCell(withIdentifier: FBMeCell.id, for: indexPath)
            }
        
            var content = cell.defaultContentConfiguration()

            content.text = title
        
            
            if let imageName = modelForRow[TableKeys.ImageName] {
            content.image = UIImage(named: imageName)
            } else if title != TableKeys.logout {
                content.image = UIImage(named: Specs.imageName.placeholder)
            }
            
            if title == user.name {
                content.secondaryText = modelForRow[TableKeys.SubTitle]
            }
        
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}
