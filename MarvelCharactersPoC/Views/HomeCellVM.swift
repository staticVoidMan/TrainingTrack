//
//  HomeCellVM.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 04/06/21.
//

import UIKit
protocol HomeCellVM {
    var name: String { get }
    var description: String { get }
    var imageURL: URL? { get }
    
    func getImage(completion: @escaping (UIImage?) -> Void)
}
