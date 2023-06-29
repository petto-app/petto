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
            ShopItem(name: "Pisang", price: 50, type: .energy, lifeAmount: 10),
            ShopItem(name: "Watch Netflix", price: 60, type: .fun, lifeAmount: 20),
            ShopItem(name: "Sweep the floor", price: 70, type: .hygiene, lifeAmount: 30)
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
