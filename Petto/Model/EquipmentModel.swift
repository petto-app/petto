//
//  EquipmentModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 22/06/23.
//

import Foundation
import SwiftUI

struct Equipment {
    public var coin: Int
    public var energy: Int
    public var fun: Int
    public var hygiene: Int
}

class EquipmentModel {
    @AppStorage("coin") var coin: Int?
    @AppStorage("energy") var energy: Int?
    @AppStorage("fun") var fun: Int?
    @AppStorage("hygiene") var hygiene: Int?
    
    init() {
        if coin == nil {
            coin = 0
        }
        
        if energy == nil {
            energy = 100
        }
        
        if fun == nil {
            fun = 100
        }
        
        if hygiene == nil {
            hygiene = 100
        }
    }
    
    func addCoin(amount: Int) {
        coin! += amount
    }
    
    func reduceCoin(amount: Int) {
        coin! -= amount
    }
    
    func addEnergy(amount: Int) {
        energy! += amount
        print(energy!)
    }
    
    func reduceEnergy(amount: Int) {
        energy! -= amount
    }
    
    func addFun(amount: Int) {
        fun! += amount
    }
    
    func reduceFun(amount: Int) {
        fun! -= amount
    }
    
    func addHygiene(amount: Int) {
        hygiene! += amount
    }
    
    func reduceHygiene(amount: Int) {
        hygiene! -= amount
    }
}
