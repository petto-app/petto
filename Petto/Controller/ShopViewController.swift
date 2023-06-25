//
//  ShopViewController.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 22/06/23.
//

import Foundation
import SwiftUI

class ShopViewController: ObservableObject {
    @ObservedObject var shopItemModel = ShopItemModel()
    @ObservedObject var statModel = StatModel()

    @AppStorage("shopItems")
    var shopItemsData: Data = .init()

    func buy(shopItem: ShopItem) {
        switch shopItem.type {
        case .energy:
            statModel.addEnergy(amount: shopItem.lifeAmount)
        case .fun:
            statModel.addFun(amount: shopItem.lifeAmount)
        case .hygiene:
            statModel.addHygiene(amount: shopItem.lifeAmount)
        }

        statModel.reduceCoin(amount: shopItem.price)
    }

    // TODO: Testing
    func getX() -> String {
        return shopItemModel.shopItems[0].name
    }

    func getAll() -> [ShopItem] {
        return shopItemModel.shopItems
    }

    func change() {
        shopItemModel.shopItems[0].name = "Anggur"
    }

    func changeStorageValue() {
        shopItemModel.setShopItemA(value: "haloo")
    }

    func add() {
        print("add")
        shopItemModel.addItem(
            ShopItem(id: 2, name: "Avocado", price: 3000, type: .energy, lifeAmount: 300)
        )
        print(shopItemsData)
    }
}
