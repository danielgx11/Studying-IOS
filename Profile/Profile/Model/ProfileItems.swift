//
//  ProfileItems.swift
//  Profile
//
//  Created by Daniel Gomes on 15/02/22.
//

import SwiftUI

struct ProfileItems {
    
    let id: Int
    let item: String
    let icon: Image
}

extension ProfileItems: Hashable {

    static func == (lhs: ProfileItems, rhs: ProfileItems) -> Bool {
        lhs.id == rhs.id && lhs.item == rhs.item && lhs.icon == rhs.icon
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
