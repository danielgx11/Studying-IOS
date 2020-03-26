//
//  Buying.swift
//  HowToUseCoordinatorPattern
//
//  Created by Daniel Gx on 25/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import Foundation

// MARK: - Protocols

protocol Buying: AnyObject {
    func buySubscription(to productType: Int) /// passing data between views
}

protocol AccountCreating: AnyObject {
    func createAccount()
}

protocol profile: AnyObject {
    func profileView(name: String, email: String, phoneNumber: String, gender: String)
}
