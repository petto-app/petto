//
//  ShopItemModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 22/06/23.
//

import Foundation

enum ShopItemType {
    case energy
    case fun
    case hygiene
}

struct ShopItem {
    public var name: String
    public var price: Int
    public var type: ShopItemType
    public var lifeAmount: Int  // Will be added on Energy, Fun, Hygiene
    public var image: String
}

class ShopItemModel {
    @Published var shopItems: [ShopItem]?
    
    init(shopItems: [ShopItem]? = nil) {
        self.shopItems = shopItems
    }
}
