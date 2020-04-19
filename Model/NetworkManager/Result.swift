//
//  Result.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 17/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}
