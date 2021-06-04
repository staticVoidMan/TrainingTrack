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

extension HomeCellVM {
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = imageURL else { completion(nil); return }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                completion(image)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
}
