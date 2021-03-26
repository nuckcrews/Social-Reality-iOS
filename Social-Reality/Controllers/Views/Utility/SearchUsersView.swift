//
//  SearchUsersViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/24/21.
//

import UIKit

class SearchUsersView: UIView {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var doneButtonBottomConstraint: NSLayoutConstraint!
    
    var selectedUsers = [UserModel]()
    var users = [UserModel]()
    var usersFiltered = [UserModel]()
    var isSearching = false
    var displaying = false
    private var addNotifications = false
    
    private var defaultBottomConstraint: CGFloat = 44
    
    weak var delegate: SearchUserDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupView()
        getUsers()
        
    }
    
    func setupView() {
        
        layer.cornerRadius = 12
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.searchTextField.leftView?.tintColor = .primary
        
        if !addNotifications {
            doneButtonBottomConstraint.priority = .defaultLow
            doneButtonBottomConstraint.constant = defaultBottomConstraint
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            addNotifications = true
        }
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            doneButtonBottomConstraint.constant = keyboardSize.height + 8
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        print("keyboard hiding", doneButtonBottomConstraint.constant)
        doneButtonBottomConstraint.constant = defaultBottomConstraint
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    func getUsers() {
        Query.get.users { res in
            guard let res = res else { return }
            self.users.removeAll()
            self.users = res
            self.tableView.reloadData()
        }
    }
    
    func presented() {
        searchBar.becomeFirstResponder()
    }
    
    func isSelected(model: UserModel) -> Bool {
        let res = selectedUsers.filter { mod in
            return mod.id == model.id
        }
        return res.count > 0
    }
    
    @IBAction func tapDone(_ sender: UIButton) {
        sender.pulsate()
        self.endEditing(true)
        searchBar.resignFirstResponder()
        delegate?.dismissSearchView()
    }
    
}

extension SearchUsersView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearching = searchText.count > 0
        
        let res = users.filter { user in
            return user.username.lowercased().contains(searchText.lowercased()) ||
                user.first.lowercased().contains(searchText.lowercased()) ||
                user.last.lowercased().contains(searchText.lowercased())
        }
        
        usersFiltered = res
        
        tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.endEditing(true)
        searchBar.resignFirstResponder()
        delegate?.dismissSearchView()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.endEditing(true)
        searchBar.resignFirstResponder()
        delegate?.dismissSearchView()
    }
    
}

extension SearchUsersView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
}

extension SearchUsersView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            if usersFiltered.count > 0 {
                tableView.alpha = 1
            } else {
                tableView.alpha = 0
            }
            return usersFiltered.count
        } else {
            if users.count > 0 {
                tableView.alpha = 1
            } else {
                tableView.alpha = 0
            }
            return users.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.searchUserCell.rawValue, for: indexPath) as? searchUserCell {
            isSearching ?
                cell.configureCell(user: usersFiltered[indexPath.row], selectedCell: isSelected(model: usersFiltered[indexPath.row])) :
                cell.configureCell(user: users[indexPath.row], selectedCell: isSelected(model: users[indexPath.row]))
            return cell
        } else {
            return searchUserCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? searchUserCell else {
            return
        }
        
        if isSearching {
            if isSelected(model: usersFiltered[indexPath.row]) {
                selectedUsers = selectedUsers.filter({ model in
                    return model.id != usersFiltered[indexPath.row].id
                })
            } else {
                selectedUsers.append(usersFiltered[indexPath.row])
            }
        } else {
            if isSelected(model: users[indexPath.row]) {
                selectedUsers = selectedUsers.filter({ model in
                    return model.id != users[indexPath.row].id
                })
            } else {
                selectedUsers.append(users[indexPath.row])
            }
        }
        
        delegate?.selectUsers(models: selectedUsers)
        
        cell.tapSelect()
        
    }
    
}
