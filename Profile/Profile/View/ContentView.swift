//
//  ContentView.swift
//  Profile
//
//  Created by Daniel Gomes on 10/02/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HeaderView()
                .padding()
                .padding(.top, 16)
            ProfileOptionsView()
        }.background(Color.black.opacity(0.75)).ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        HeaderView()
//        PersonDataView()
//        ProfileOptionsView()
//            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
