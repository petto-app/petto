//
//  ShopViewController.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 22/06/23.
//

import Foundation
import SwiftUI

class ShopViewController {
    var shopItemModel = ShopItemModel()
    var equipmentModel = EquipmentModel()
    
    func buy(shopItem: ShopItem) {
        switch shopItem.type {
        case .energy:
            equipmentModel.addEnergy(amount: shopItem.lifeAmount)
        case .fun:
            equipmentModel.addFun(amount: shopItem.lifeAmount)
        case .hygiene:
            equipmentModel.addHygiene(amount: shopItem.lifeAmount)
        }
        
        equipmentModel.reduceCoin(amount: shopItem.price)
    }
}
