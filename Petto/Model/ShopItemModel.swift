//
//  ShopItemModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 22/06/23.
//

import Foundation
import SwiftUI

enum ShopItemType: Codable {
    case energy
    case fun
    case hygiene
}

struct ShopItem: Identifiable, Codable, Hashable {
    public var id = UUID()
    public var name: String
    public var price: Int
    public var type: ShopItemType
    public var lifeAmount: Int // Will be added on Energy, Fun, Hygiene
    public var image: String?
}

class ShopItemModel: ObservableObject {
    public static var shared: ShopItemModel = .init()

    @AppStorage("shopItems")
    var shopItemsData: Data = .init()

    var shopItems: [ShopItem] { // Wrapper
        get {
            if let decodedItems = try? JSONDecoder().decode([ShopItem].self, from: shopItemsData) {
                return decodedItems
            }
            return []
        }
        set {
            // Update the AppStorage value
            if let encodedItems = try? JSONEncoder().encode(newValue) {
                shopItemsData = encodedItems
            }
        }
    }

    init() {
        shopItems = [
            ShopItem(name: "Banana", price: 5, type: .energy, lifeAmount: 5, image: "Banana"),
            ShopItem(name: "Milk", price: 10, type: .energy, lifeAmount: 10, image: "Milk"),
            ShopItem(name: "Sausage", price: 50, type: .energy, lifeAmount: 50, image: "Sausage"),
            ShopItem(name: "Steak", price: 100, type: .energy, lifeAmount: 100, image: "Steak"),
            ShopItem(name: "Bubbles", price: 5, type: .fun, lifeAmount: 5, image: "Bubbles"),
            ShopItem(name: "Sports", price: 10, type: .fun, lifeAmount: 10, image: "Sports"),
            ShopItem(name: "Shopping", price: 50, type: .fun, lifeAmount: 50, image: "Shopping"),
            ShopItem(name: "Travel", price: 100, type: .fun, lifeAmount: 100, image: "Travel"),
            ShopItem(name: "Tissue", price: 5, type: .hygiene, lifeAmount: 5, image: "Tissue"),
            ShopItem(name: "AromaTherapy", price: 10, type: .hygiene, lifeAmount: 10, image: "AromaTherapy"),
            ShopItem(name: "Spray", price: 50, type: .hygiene, lifeAmount: 50, image: "Spray"),
            ShopItem(name: "Vacuum", price: 100, type: .hygiene, lifeAmount: 100, image: "Vacuum")
        ]
    }

    func addItem(_ item: ShopItem) {
        var updatedItems = shopItems
        updatedItems.append(item)
        shopItems = updatedItems
    }

    // TODO: Testing
    @AppStorage("shopItemA")
    var shopItemA: String = "ini shop Item A" // not visible

    func setShopItemA(value: String) {
        shopItemA = value
    }
}
