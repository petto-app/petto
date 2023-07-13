//
//  StatModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 23/06/23.
//

import Foundation
import SwiftUI

protocol Stat {
    var amount: Int? { get set }
    var maxValue: Int { get set }
    var depletionSpeed: Int? { get set }
    var lastDepleted: Int? { get set }

    init(maxValue: Int)
}

struct Energy: Stat, Codable {
    var amount: Int?
    var maxValue: Int
    var depletionSpeed: Int?
    var lastDepleted: Int?

    init(maxValue: Int = 100) {
        self.maxValue = maxValue
        depletionSpeed = 1440
    }
}

struct Fun: Stat, Codable {
    var amount: Int?
    var maxValue: Int
    var depletionSpeed: Int?
    var lastDepleted: Int?

    init(maxValue: Int = 100) {
        self.maxValue = maxValue
        depletionSpeed = 1620
    }
}

struct Hygiene: Stat, Codable {
    var amount: Int?
    var maxValue: Int
    var depletionSpeed: Int?
    var lastDepleted: Int?

    init(maxValue: Int = 100) {
        self.maxValue = maxValue
        depletionSpeed = 1800
    }
}

class StatModel: ObservableObject {
    public static var shared: StatModel = .init()
    
    @EnvironmentObject var gameKitController: GameKitController

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
                funData = encodedItems
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
                hygieneData = encodedItems
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
        if coin == nil {
            coin = 0
        }
        coin! += amount
        totalCoin! += amount
        gameKitController.reportScore(totalCoin: totalCoin!)
    }

    func reduceCoin(amount: Int) {
        if coin == nil {
            coin = 0
        }
        coin! -= amount
        coin = max(coin ?? 0, 0)
    }

    func addEnergy(amount: Int) {
        var temp = energy.amount
        if temp == nil {
            temp = 0
        }
        temp! += amount
        energy.amount = min(temp!, energy.maxValue)
    }

    func reduceEnergy(amount: Int) {
        var temp = energy.amount
        if temp == nil {
            temp = 0
        }
        temp! -= amount
        energy.amount = max(temp!, 0)
    }

    func addFun(amount: Int) {
        var temp = fun.amount
        if temp == nil {
            temp = 0
        }
        temp! += amount
        fun.amount = min(temp!, fun.maxValue)
    }

    func reduceFun(amount: Int) {
        var temp = fun.amount
        if temp == nil {
            temp = 0
        }
        temp! -= amount
        fun.amount = max(temp!, 0)
    }

    func addHygiene(amount: Int) {
        var temp = hygiene.amount
        if temp == nil {
            temp = 0
        }
        temp! += amount
        hygiene.amount = min(temp!, hygiene.maxValue)
    }

    func reduceHygiene(amount: Int) {
        var temp = hygiene.amount
        if temp == nil {
            temp = 0
        }
        temp! -= amount
        hygiene.amount = max(temp!, 0)
    }
}
