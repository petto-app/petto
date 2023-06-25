//
//  DataTestView.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 24/06/23.
//

import SwiftUI

// TODO: Testing
struct DataTestView: View {
    @EnvironmentObject var shopViewController: ShopViewController
    @EnvironmentObject var shopItemModel: ShopItemModel

    // will be required for initialization
//    @StateObject var shopItemModel: ShopItemModel
//    @ObservedObject var shopItemModel: ShopItemModel

    @AppStorage("shopItems")
    var shopItemsData: Data = .init()

    @AppStorage("shopItemA")
    var shopItemA: String = "Tes"

    var body: some View {
        VStack {
            List(shopViewController.getAll()) {
                Text($0.name)
            }

            Button(action: {
                shopViewController.add()
            }) {
                Text("Add More")
            }

            Button(action: {
                shopViewController.change()
            }) {
                Text("Change Name")
            }

            Button(action: {
                shopViewController.changeStorageValue()
            }) {
                Text(shopItemA)
            }
        }
    }
}

struct DataTestView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var shopViewController = ShopViewController()
        @StateObject var shopItemModel = ShopItemModel()

        DataTestView()
            .environmentObject(shopViewController)
            .environmentObject(shopItemModel)
    }
}
