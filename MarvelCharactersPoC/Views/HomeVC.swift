//
//  HomeVC.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 04/06/21.
//

import UIKit

class HomeVC: UIViewController {
    
    static var characterCellName: String { "HomeCell" }
    
    @IBOutlet var segmentController: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var viewModel: HomeVM = .init(characterProvider : CharacterProvider_API(),
                                  comicProvider     : ComicProvider_API())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "HomeCell", bundle: nil),
                           forCellReuseIdentifier: Self.characterCellName)
        tableView.rowHeight = 96
    }
    
    @IBAction func segmentControllerChanged(_ sender: UISegmentedControl) {
        viewModel.segmentChanged(sender.selectedSegmentIndex)
        loadData()
    }
    
    func loadData() {
        viewModel.loadData(searchTerm: searchBar.text ?? "") { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

}

extension HomeVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadData()
        searchBar.resignFirstResponder()
    }
    
}

extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.characterCellName,
                                                 for: indexPath) as! HomeCell
        
        let cellVM = self.viewModel.items[indexPath.row]
        cell.setup(with: cellVM)
        
        return cell
    }
    
}
