//
//  MarvelCharacterCell.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 23/04/21.
//

import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    func setup(with viewModel: HomeCellVM) {
        characterNameLabel.text = viewModel.name
        characterDescriptionLabel.text = viewModel.description
        
        viewModel.getImage { [weak self] (image) in
            guard let _weakSelf = self else { return }
            
            DispatchQueue.main.async {
                _weakSelf.characterImageView.image = image
            }
        }
    }
    
}
