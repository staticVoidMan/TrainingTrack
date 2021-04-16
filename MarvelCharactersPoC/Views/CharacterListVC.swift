//
//  CharacterListVC.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 16/04/21.
//

import UIKit

class CharacterListVC: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var viewModel: CharacterListVM = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadData(with searchTerm: String) {
        viewModel.loadData(with: searchTerm) { (result) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let item = viewModel.characters[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
    }
    
}
