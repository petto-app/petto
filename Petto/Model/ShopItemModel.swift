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

struct ShopItem: Identifiable, Codable {
//    public var id = UUID()
    public var id: Int
    public var name: String
    public var price: Int
    public var type: ShopItemType
    public var lifeAmount: Int // Will be added on Energy, Fun, Hygiene
    public var image: String?
}

class ShopItemModel: ObservableObject {
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
            ShopItem(id: 1, name: "Pisang", price: 2000, type: .energy, lifeAmount: 100)
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
