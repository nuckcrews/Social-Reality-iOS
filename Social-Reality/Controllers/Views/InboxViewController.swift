//
//  InboxViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit

class InboxViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.tag = TabBarItemTag.fourthViewController.rawValue
        
        setupView()
       
    }
    
    func setupView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        searchBar.searchTextField.leftView?.tintColor = .primary
        
    }
    
    @IBAction func tapNewMessage(_ sender: UIButton) {
        
    }
    
}

extension InboxViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension InboxViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        view.endEditing(true)
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.inboxCell.rawValue) as? inboxCell {
                return cell
            } else {
                return inboxCell()
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.promoCell.rawValue) as? promoCell {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MainToCoverDelegate?.segueToMessage(recipientID: Testing.defaultUser.model!.id, conversationID: nil)
    }
    
}
