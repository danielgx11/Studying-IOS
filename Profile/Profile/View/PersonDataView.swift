//
//  PersonDataView.swift
//  Profile
//
//  Created by Daniel Gomes on 15/02/22.
//

import SwiftUI

struct PersonDataView: View {
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Hack Swift")
                    .font(.bold(.title3)())
                    .foregroundColor(.white)
                
                
                Text("swift.taylor@email.com")
                    .font(.body)
                    .accentColor(.white)
                    .opacity(0.5)
            }
            
        }
    }
}
