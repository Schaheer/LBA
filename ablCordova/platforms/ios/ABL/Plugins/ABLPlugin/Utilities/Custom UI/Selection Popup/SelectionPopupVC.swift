//
//  SelectionPopupVC.swift
//  ABL
//
//  Created by Schaheer Saleem
//

import UIKit

class SelectionPopupVC: UIViewController {

    @IBOutlet weak var titleLabel   : LabelSetting!
    @IBOutlet weak var searchField  : UITextField!
    
    @IBOutlet weak var tableView    : UITableView!
    
    var dataSource: [String] = []
    var searchedItems: [String] = []
    
    var alertTitle : String = ""
    var completionHandler: ((Int, String) -> ()) = { _, _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = alertTitle

        tableView.register(UINib(nibName: "SelectionCell", bundle: nil), forCellReuseIdentifier: "SelectionCell")
    }
    
    @IBAction func searchTextEditingChanged(_ sender: Any) {
        if searchField.text == "" {
            searchedItems = dataSource
        } else {
            searchedItems = dataSource.filter({ (result) -> Bool in
                return result.range(of: searchField.text ?? "", options: .caseInsensitive) != nil
            })
        }

        tableView.reloadData()
    }
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func setAlertWith(datasource: [String], title: String? = "", block: @escaping ((Int, String) -> ()) = { _, _ in }) {
        dataSource = datasource
        searchedItems = datasource
        
        alertTitle = title ?? ""

        completionHandler = block
    }
    
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension SelectionPopupVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionCell") as? SelectionCell {
            
            var item: String?
            
            if searchField.text == "" {
                item = dataSource[indexPath.row]
            } else {
                item = searchedItems[indexPath.row]
            }
            
            cell.setCell(with: item ?? "")
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchField.text == "" {
            return dataSource.count
        } else {
            return searchedItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchField.text == "" {
            completionHandler(indexPath.row, dataSource[indexPath.row])
        } else {
            completionHandler(indexPath.row, searchedItems[indexPath.row])
        }
        
        dismiss(animated: true)
    }
    
}
