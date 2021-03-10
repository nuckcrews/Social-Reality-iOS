//
//  InboxViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit

class InboxViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.tag = TabbarItemTag.fourthViewConroller.rawValue
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        addData()
        
    }
    
    func addData() {
        var creation = CreationModel(id: "firstCreation", title: "Robot", description: "", lastViewed: "", accessibility: .public, status: "draft")
//        Query.api.write.creation(creation) { (model) in
//            print(creation)
//        }
        creation.description = "The first ever"
        Query.api.update.creation(creation) { (res) in
            print(res)
        }
    }
    
    
}

extension InboxViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 4
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 { // Need to fix this
            if let cell = tableView.dequeueReusableCell(withIdentifier: "inboxCell") as? inboxCell {
                return cell
            } else {
                return inboxCell()
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "promoCell") as? promoCell {
                return cell
            } else {
                return promoCell()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 42))
        headerView.backgroundColor = .background
        let label = UILabel()
        label.frame = CGRect(x: 24, y: 6, width: headerView.frame.width-10, height: headerView.frame.height-10)
        
        if section == 0 {
            label.text = "Recent"
        } else {
            label.text = "Previous"
        }
        
        label.textColor = .grayText
        label.font = UIFont.systemFont(ofSize: 14)
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
}
