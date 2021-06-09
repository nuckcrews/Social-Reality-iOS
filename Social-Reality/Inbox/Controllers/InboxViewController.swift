//
//  InboxViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit

// MARK: - Inbox View Controller -> Tab 4

class InboxViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - View Instantiation
    
    internal static func instantiate() -> InboxViewController? {

        guard let viewController = Storyboard.InboxViewController.instantiate(InboxViewController.self) else {
            return nil
        }
        
        return viewController
    }
    
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

        DispatchQueue.main.async { 
            
            if let viewController = NewMessageViewController.instantiate() {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
        
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
        
        if indexPath.row % 2 == 0 { // #FIX
            if let cell = tableView.dequeueReusableCell(withIdentifier: InboxCell.identifiers.inboxCell.rawValue) as? InboxCell {
                return cell
            } else {
                return InboxCell()
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: PromoCell.identifiers.promoCell.rawValue) as? PromoCell {
                return cell
            } else {
                return PromoCell()
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
        MainToCoverDelegate?.segueToMessage(recipientID: "dvjnyEy9LDa2knI5tY1T5hxyn6q1", conversationID: nil)
    }
    
}
