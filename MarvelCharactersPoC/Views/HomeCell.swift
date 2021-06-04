//
//  MarvelCharacterCell.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 23/04/21.
//

import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    
    func setup(with viewModel: HomeCellVM) {
        itemNameLabel.text = viewModel.name
        itemDescriptionLabel.text = viewModel.description
        
        viewModel.getImage { [weak self] (image) in
            guard let _weakSelf = self else { return }
            
            DispatchQueue.main.async {
                _weakSelf.itemImageView.image = image
            }
        }
    }
    
}
