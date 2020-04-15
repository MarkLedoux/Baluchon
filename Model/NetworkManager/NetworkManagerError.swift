//
//  NetworkManagerError.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 14/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

/// errors that can happen in the application
enum NetworkManagerError: Error {
    case failedToFetchRessource
}

extension NetworkManagerError: LocalizedError {
    /// what the program needs to return depending on the error
    public var errorDescription: String? {
        switch self {
        case .failedToFetchRessource:
            return NSLocalizedString("error_failed_to_get_resource", comment: "")
        }
    }
}
