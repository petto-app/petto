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
    @EnvironmentObject var timerController: TimerController
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

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
                shopViewController.statModel.reduceFun(amount: 50)
                shopViewController.statModel.reduceFun(amount: 50)
                shopViewController.statModel.reduceFun(amount: 50)
            }) {
                Text("Add More")
                Text("\(shopViewController.statModel.fun.amount ?? 0)")
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
        }.onReceive(timer) { _ in
            shopViewController.statModel.addEnergy(amount: 5)
            shopViewController.statModel.addFun(amount: 5)
            shopViewController.statModel.addHygiene(amount: 5)
        }
    }
}
