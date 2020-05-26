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
	case failedToFetchRessource(underlineError: Error?)
	case requestFailed
	case jsonConversionFailure
	case invalidData
	case responseUnsuccessful
	case jsonParsingFailure
	case missingURL
	case noDataAfterFetchingResource
	case failedToCreateURL(message: String)
}

extension NetworkManagerError {
	/// what the program needs to return depending on the error
	public var errorDescription: String? {
		switch self {
		case .failedToFetchRessource:
			return "Failed to fetch resource"
		case .requestFailed:
			return "The request failed"
		case .jsonConversionFailure:
			return "The json data could not be converted properly"
		case .invalidData:
			return "The data is invalid"
		case .responseUnsuccessful:
			return "The response was not successful"
		case .jsonParsingFailure:
			return "There was an error parsing the json data"
		case .missingURL:
			return "The URL is missing, cannot make request"
		case .noDataAfterFetchingResource:
			return "An error occured, there was no data after fetching the resource"
		case .failedToCreateURL:
			return "Failed to create URL"
		}
	}
	
	// TODO: - create string localization even for storyboard titles 
}
