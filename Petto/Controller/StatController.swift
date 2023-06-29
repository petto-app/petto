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
    private let baseDepletionAmount = 5

    var fun: Int {
        return statModel.fun.amount ?? 0
    }

    var hygiene: Int {
        return statModel.hygiene.amount ?? 0
    }

    var energy: Int {
        return statModel.energy.amount ?? 0
    }

    func updateStats() {
        let currentTime = Int(Date().timeIntervalSince1970)
        if statModel.energy.lastDepleted == nil {
            statModel.energy.lastDepleted = currentTime
        }
        if statModel.fun.lastDepleted == nil {
            statModel.fun.lastDepleted = currentTime
        }
        if statModel.hygiene.lastDepleted == nil {
            statModel.hygiene.lastDepleted = currentTime
        }
        let energyLastDepleted = statModel.energy.lastDepleted!
        let hygieneLastDepleted = statModel.hygiene.lastDepleted!

        statModel.energy.depletionSpeed = 1440
        statModel.hygiene.depletionSpeed = 1800
        statModel.fun.depletionSpeed = 1620

        let energyOld = statModel.energy.amount ?? 0
        let hygieneOld = statModel.hygiene.amount ?? 0

        let energyDepletionMultiplier = ((currentTime - energyLastDepleted) / statModel.energy.depletionSpeed!)
        if energyDepletionMultiplier > 0 {
            decreaseEnergy(amount: baseDepletionAmount * energyDepletionMultiplier)
            statModel.energy.lastDepleted! += energyDepletionMultiplier * statModel.energy.depletionSpeed!
        }

        let hygieneDepletionMultiplier = ((currentTime - hygieneLastDepleted) / statModel.hygiene.depletionSpeed!)

        if hygieneDepletionMultiplier > 0 {
            decreaseHygiene(amount: baseDepletionAmount * hygieneDepletionMultiplier)
            statModel.hygiene.lastDepleted! += hygieneDepletionMultiplier * statModel.hygiene.depletionSpeed!
        }

        let energyMean = (energyOld + statModel.energy.amount!) / 2
        let hygieneMean = (hygieneOld + statModel.hygiene.amount!) / 2
        let meanStat = (energyMean + hygieneMean) / 2

        let funDepletionRateMultiplier = 0.5 + (Double(meanStat) / 100.0)
        statModel.fun.depletionSpeed = Int(Double(statModel.fun.depletionSpeed!) * funDepletionRateMultiplier)
        let funLastDepleted = statModel.fun.lastDepleted!
        let funDepletionMultiplier = ((currentTime - funLastDepleted) / statModel.fun.depletionSpeed!)
        if funDepletionMultiplier > 0 {
            decreaseFun(amount: baseDepletionAmount * funDepletionMultiplier)
            statModel.fun.lastDepleted! += funDepletionMultiplier * statModel.fun.depletionSpeed!
        }
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
