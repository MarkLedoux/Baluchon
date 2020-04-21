//
//  NetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 14/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

final class URLComponentManager {
    private var components = URLComponents()
    func createURL(scheme: String, host: String, path: String, queryItems: [URLQueryItem]? ) -> URL? {
        var url: URL? {
            components.scheme = scheme
            components.host = host
            components.path = path
            components.queryItems = queryItems
            return components.url
        }
        return url
    }
}
