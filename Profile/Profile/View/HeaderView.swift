//
//  HeaderView.swift
//  Profile
//
//  Created by Daniel Gomes on 15/02/22.
//

import SwiftUI

struct HeaderView: View {

    var body: some View {
        ZStack {
            
            VStack(spacing: 16) {
                HStack(alignment: .top, spacing: 32) {
                    Image("icon")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 120, height: 120, alignment: .leading)
                        .overlay(Circle().stroke(.white, lineWidth: 4))
                        .shadow(radius: 12)
                        .padding(.top)
                        .padding(.leading)
                    
                    PersonDataView().padding(.trailing).padding(.top, 48)
                }
                
                Text("Life is too short to don't admit Swift is the best programming language in the world")
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(.top)
            }
        }.frame(width: .infinity,
                height: ScreenSize.aQuarterOfScreen,
                alignment: .center)
    }
}
