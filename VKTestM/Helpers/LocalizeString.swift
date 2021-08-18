//
//  LocalizeString.swift
//  VKTestM
//
//  Created by Dmitry on 18.08.2021.
//

import Foundation

enum LocalizeString {
    case loginTitle
    case authAlertTitle
    case authAlertCommit
    case photosFailure
    case formatter
    case exitTitle
    case errorGetPhoto
    case savePhoto
    case errorSavePhoto
    
    var setString: String {
        switch self {
        case .loginTitle:
            return NSLocalizedString("Login VK", comment: "")
        case .authAlertTitle:
            return NSLocalizedString("Authorisation Error", comment: "")
        case .authAlertCommit:
            return NSLocalizedString("Sorry, try again later", comment: "")
        case .photosFailure:
            return NSLocalizedString("Error to fetch photos", comment: "")
        case .formatter:
            return NSLocalizedString("en_US", comment: "")
        case .exitTitle:
            return NSLocalizedString("Exit", comment: "")
        case .errorGetPhoto:
            return NSLocalizedString("Photo receiving Error", comment: "")
        case .savePhoto:
            return NSLocalizedString("Your photo saved", comment: "")
        case .errorSavePhoto:
            return NSLocalizedString("Error to save photo", comment: "")
        }
    }
}
