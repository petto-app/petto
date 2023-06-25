//
//  ContentView.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 18/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
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
