//
//  CharacterListVC.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 16/04/21.
//

import UIKit

class CharacterListVC: UIViewController {
    
    static var cellName: String { "CharacterCell" }
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var viewModel: CharacterListVM = .init(provider: CharacterProvider_API())

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        tableView.register(UINib(nibName: "MarvelCharacterCell", bundle: nil),
                           forCellReuseIdentifier: Self.cellName)
        tableView.rowHeight = 96
    }
    
    func loadData(with searchTerm: String) {
        viewModel.loadData(with: searchTerm) { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

}

extension CharacterListVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchTerm = searchBar.text ?? ""
        loadData(with: searchTerm)
        searchBar.resignFirstResponder()
    }
    
}

extension CharacterListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellName,
                                                 for: indexPath) as! MarvelCharacterCell
        
        let cellVM = self.viewModel.characters[indexPath.row]
        cell.setup(with: cellVM)
        
        return cell
    }
    
}
