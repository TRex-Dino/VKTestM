//
//  PhotoViewModel.swift
//  VKTestM
//
//  Created by Dmitry on 17.08.2021.
//

import Foundation

struct PhotoViewModel { 
    var cells: [Cell]
}

struct Cell: PhotoCellViewModel {
    var photoUrlString: String
    var date: Double
}
