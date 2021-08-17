//
//  PhotoViewModel.swift
//  VKTestM
//
//  Created by Dmitry on 17.08.2021.
//

import Foundation

struct PhotoViewModel {
    struct Cell: PhotoCellViewModel {
        var photoUrlString: String
    }
    
    var cells: [Cell]
}
