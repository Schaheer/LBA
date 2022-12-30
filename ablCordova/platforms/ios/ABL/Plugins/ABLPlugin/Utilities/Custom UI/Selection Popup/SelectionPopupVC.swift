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
    
    @IBOutlet weak var backGroundView: CustomUIView!
    @IBOutlet weak var tableView    : UITableView!
    @IBOutlet weak var backGroundView2: UIView!
    
    @IBOutlet weak var viewSearch: UIView!
    
    var dataSource: [String] = []
    var searchedItems: [String] = []
    var isSearchViewHidden = false
    var alertTitle : String = ""
    var completionHandler: ((Int, String) -> ()) = { _, _ in }
    override func viewWillAppear(_ animated: Bool) {
//        backGroundView.isHidden = true
        backGroundView2.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        backGroundView2.isHidden = false

    }
    override func viewWillDisappear(_ animated: Bool) {
        backGroundView2.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSearch.isHidden = isSearchViewHidden
        titleLabel.text = alertTitle

        tableView.register(UINib(nibName: "SelectionCell", bundle: nil), forCellReuseIdentifier: "SelectionCell")
        
        backGroundView.layer.borderWidth = 1
        backGroundView.layer.borderColor = UIColor.lightGray.cgColor
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
    
    func setAlertWith(datasource: [String], title: String? = "", isSearchViewHidden: Bool, block: @escaping ((Int, String) -> ()) = { _, _ in }) {
        dataSource = datasource
        searchedItems = datasource
        alertTitle = title ?? ""
        completionHandler = block
        self.isSearchViewHidden = isSearchViewHidden
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
