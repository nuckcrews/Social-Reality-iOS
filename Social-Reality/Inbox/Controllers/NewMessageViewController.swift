//
//  NewMessageViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/9/21.
//

import UIKit

// MARK: - New Message View Controller

class NewMessageViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Variables
    
    var users = [UserModel]()
    var filteredUsers = [UserModel]()
    private var isSearching = false
    
    // MARK: - View Instantiation
    
    internal static func instantiate() -> NewMessageViewController? {

        guard let viewController = Storyboard.NewMessageViewController.instantiate(NewMessageViewController.self) else {
            return nil
        }
        
        return viewController
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getUsers()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        searchBar.becomeFirstResponder()
        
    }
    
    // MARK: - View Setup
    
    func setupView() {
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    // MARK: - Fetch Users
    
    func getUsers() {
        // #SCALEFIX
        Query.remote.get.users { [weak self] models in
            guard let models = models else { return }
            self?.users = models
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Action Outlets
    
    @IBAction func tapBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Search Bar Delegate

extension NewMessageViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearching = searchText.count > 0
        
        let res = users.filter { user in
            return user.username.lowercased().contains(searchText.lowercased()) ||
                user.first.lowercased().contains(searchText.lowercased()) ||
                user.last.lowercased().contains(searchText.lowercased())
        }
        
        filteredUsers = res
        
        tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        view.endEditing(true)
    }
    
}

// MARK: - ScrollView Delegate

extension NewMessageViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
}

// MARK: - TableView Delegate Methods

extension NewMessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredUsers.count
        } else {
            return users.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchUserMessageCell.identifiers.searchUserMessageCell.rawValue, for: indexPath) as? SearchUserMessageCell {
            isSearching ?
                cell.configureCell(user: filteredUsers[indexPath.row]) :
                cell.configureCell(user: users[indexPath.row])
            return cell
        } else {
            return SearchUserMessageCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        isSearching ?
            MainToCoverDelegate?.segueToMessage(recipientID: filteredUsers[indexPath.row].id, conversationID: nil) :
            MainToCoverDelegate?.segueToMessage(recipientID: users[indexPath.row].id, conversationID: nil)
        
        
    }
    
}

