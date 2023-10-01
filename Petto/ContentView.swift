//
//  ContentView.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 18/06/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isOnBoarded")
    var isOnBoarded: Bool?

    var body: some View {
        switch isOnBoarded {
        case nil, false:
            OnBoardingView(redirectTo: Home())
        case .some:
            Home()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var shopViewController = ShopViewController()
        @StateObject var timeController = TimeController()

        ContentView()
            .environmentObject(shopViewController)
            .environmentObject(timeController)
    }
}
