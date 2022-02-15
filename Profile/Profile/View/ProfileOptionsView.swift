//
//  ProfileOptionsView.swift
//  Profile
//
//  Created by Daniel Gomes on 15/02/22.
//

import SwiftUI

struct ProfileOptionsView: View {

    var itens: [ProfileItems] = [
        ProfileItems(id: 1, item: "Notifications", icon: Image(systemName: "app.badge")),
        ProfileItems(id: 2, item: "Edit profile", icon: Image(systemName: "person")),
        ProfileItems(id: 3, item: "Help", icon: Image(systemName: "questionmark.circle")),
        ProfileItems(id: 4, item: "Privacy", icon: Image(systemName: "lock.circle")),
        ProfileItems(id: 5, item: "Change number", icon: Image(systemName: "iphone.homebutton")),
        ProfileItems(id: 6, item: "Blockeds", icon: Image(systemName: "person.badge.minus")),
    ]

    var body: some View {
        ZStack {
            Color.black
                .opacity(0.4)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(self.itens, id: \.self) { item in
                        HStack {
                            item.icon.foregroundColor(.white)
                            Text(item.item).foregroundColor(.white)
                            Spacer()
                            Image(systemName: "chevron.right").foregroundColor(.white)
                        }
                        Spacer()
                    }
                }
            }.padding(.top, 24).padding(.leading, 32).padding(.trailing, 32)
        }
    }
}
