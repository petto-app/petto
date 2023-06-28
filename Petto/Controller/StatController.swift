//
//  TimeController.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 25/06/23.
//

import Foundation
import SwiftUI

class StatController: ObservableObject {
    @ObservedObject var statModel = StatModel()

    var fun: Int {
        return statModel.fun.amount ?? 0
    }

    func increaseFun(amount: Int) {
        statModel.addFun(amount: amount)
    }

    func decreaseFun(amount: Int) {
        statModel.reduceFun(amount: amount)
    }

    func increaseHygiene(amount: Int) {
        statModel.addHygiene(amount: amount)
    }

    func decreaseHygiene(amount: Int) {
        statModel.reduceHygiene(amount: amount)
    }

    func increaseEnergy(amount: Int) {
        statModel.addEnergy(amount: amount)
    }

    func decreaseEnergy(amount: Int) {
        statModel.reduceEnergy(amount: amount)
    }
}
