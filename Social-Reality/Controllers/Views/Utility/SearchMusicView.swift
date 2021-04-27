//
//  SearchMusicView.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/26/21.
//

import UIKit

// MARK: - Search Music Utility View

class SearchMusicView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var doneButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var music = [String]()
    var musicFiltered = [String]()
    
    var selectedMusic: String?
    var isSearching = false
    var displaying = false
    private var addNotifications = false
    
    private var defaultBottomConstraint: CGFloat = 44
    
    weak var delegate: SearchMusicDelegate?
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupView()
        
    }
    
    func presented() {
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - View Setup
    
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
    
    // MARK: - Keyboard Observers
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            doneButtonBottomConstraint.constant = keyboardSize.height + 8
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        doneButtonBottomConstraint.constant = defaultBottomConstraint
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - Music Fetching
    
    func isSelected(model: String) -> Bool {
        return model == selectedMusic
    }
    
    // MARK: - Action Outlets
    
    @IBAction func tapDone(_ sender: UIButton) {
        sender.pulsate()
        self.endEditing(true)
        searchBar.resignFirstResponder()
        delegate?.dismissSearchMusicView()
    }
    
}

// MARK: - Search Bar Delegate

extension SearchMusicView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearching = searchText.count > 0
        
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.endEditing(true)
        searchBar.resignFirstResponder()
        delegate?.dismissSearchMusicView()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.endEditing(true)
        searchBar.resignFirstResponder()
        delegate?.dismissSearchMusicView()
    }
    
}

// MARK: - ScrollView Delegate

extension SearchMusicView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - TableView Delegate

extension SearchMusicView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            if musicFiltered.count > 0 {
                tableView.alpha = 1
            } else {
                tableView.alpha = 0
            }
            return musicFiltered.count
        } else {
            if music.count > 0 {
                tableView.alpha = 1
            } else {
                tableView.alpha = 0
            }
            return music.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.searchMusicCell.rawValue, for: indexPath) as? searchMusicCell {
            isSearching ?
                cell.configureCell(music: musicFiltered[indexPath.row],
                                   selectedCell: isSelected(model: musicFiltered[indexPath.row])) :
                cell.configureCell(music: music[indexPath.row],
                                   selectedCell: isSelected(model: music[indexPath.row]))
            return cell
        } else {
            return searchMusicCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? searchMusicCell else {
            return
        }
        
        if isSearching {
            if isSelected(model: musicFiltered[indexPath.row]) {
                selectedMusic = nil
            } else {
                selectedMusic = musicFiltered[indexPath.row]
            }
        } else {
            if isSelected(model: music[indexPath.row]) {
                selectedMusic = nil
            } else {
                selectedMusic = music[indexPath.row]
            }
        }
        
        
        delegate?.selectMusic()
        
        cell.tapSelect()
        
    }
    
}
