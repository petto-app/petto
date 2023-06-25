//
//  StatModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 23/06/23.
//

import Foundation
import SwiftUI

protocol Stat {
    var amount: Float { get set }
    var maxValue: Int { get set }
    var depletionSpeed: Float? { get set }

    init(amount: Float, maxValue: Int)
}

struct Energy: Stat, Codable {
    var amount: Float
    var maxValue: Int
    var depletionSpeed: Float?

    init(amount: Float = 100.00, maxValue: Int = 100) {
        self.amount = amount
        self.maxValue = maxValue
    }
}

struct Fun: Stat, Codable {
    var amount: Float
    var maxValue: Int
    var depletionSpeed: Float?

    init(amount: Float = 100.00, maxValue: Int = 100) {
        self.amount = amount
        self.maxValue = maxValue
    }
}

struct Hygiene: Stat, Codable {
    var amount: Float
    var maxValue: Int
    var depletionSpeed: Float?

    init(amount: Float = 100.00, maxValue: Int = 100) {
        self.amount = amount
        self.maxValue = maxValue
    }
}

class StatModel: ObservableObject {
    @AppStorage("coin")
    var coin: Int?

    @AppStorage("totalCoin")
    var totalCoin: Int?

    @AppStorage("energy")
    var energyData: Data = .init()

    @AppStorage("fun")
    var funData: Data = .init()

    @AppStorage("hygiene")
    var hygieneData: Data = .init()

    var energy: Energy { // Wrapper
        get {
            if let decodedItems = try? JSONDecoder().decode(Energy.self, from: energyData) {
                return decodedItems
            }
            return Energy()
        }
        set {
            // Update the AppStorage value
            if let encodedItems = try? JSONEncoder().encode(newValue) {
                energyData = encodedItems
            }
        }
    }

    var fun: Fun { // Wrapper
        get {
            if let decodedItems = try? JSONDecoder().decode(Fun.self, from: funData) {
                return decodedItems
            }
            return Fun()
        }
        set {
            // Update the AppStorage value
            if let encodedItems = try? JSONEncoder().encode(newValue) {
                energyData = encodedItems
            }
        }
    }

    var hygiene: Hygiene { // Wrapper
        get {
            if let decodedItems = try? JSONDecoder().decode(Hygiene.self, from: hygieneData) {
                return decodedItems
            }
            return Hygiene()
        }
        set {
            // Update the AppStorage value
            if let encodedItems = try? JSONEncoder().encode(newValue) {
                energyData = encodedItems
            }
        }
    }

    init() {
        if coin == nil {
            coin = 0
        }

        if totalCoin == nil {
            totalCoin = 0
        }
    }

    func addCoin(amount: Int) {
        coin! += amount
    }

    func reduceCoin(amount: Int) {
        coin! -= amount
    }

    func addEnergy(amount _: Int) {
//        energy?.test += amount
//        print(energy!)
    }

    func reduceEnergy(amount _: Int) {
//        energy! -= amount
    }

    func addFun(amount _: Int) {
//        fun! += amount
    }

    func reduceFun(amount _: Int) {
//        fun! -= amount
    }

    func addHygiene(amount _: Int) {
//        hygiene! += amount
    }

    func reduceHygiene(amount _: Int) {
//        hygiene! -= amount
    }
}
