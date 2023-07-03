//
//  HealthKitController.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 26/06/23.
//

import Foundation
import HealthKit
import SwiftUI
import UIKit

class HealthKitController: ObservableObject {
    @ObservedObject var HKModel = HealthKitModel.shared
    @ObservedObject var dailyTaskModel = DailyTaskModel.shared
    @ObservedObject var statModel = StatModel.shared

    var hasRequestedHealthData = false

    init() {
        authorizeHealthKit { [self] success in
            if success {
                fetchHealthData()
            }
        }
    }

    func authorizeHealthKit(completion: @escaping (Bool) -> Void) {
        if HKHealthStore.isHealthDataAvailable() {
            let infoToRead = Set([
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleStandTime)!,
            ])

            HKModel.healthStore.requestAuthorization(toShare: nil, read: infoToRead, completion: { success, error in
                if let error = error {
                    print("HealthKit Authorization Error: \(error.localizedDescription)")
                    completion(false)
                } else {
                    if success {
                        if self.hasRequestedHealthData {
                            print("You've already requested access to health data. ")
                        } else {
                            print("HealthKit authorization request was successful! ")
                        }
                        self.hasRequestedHealthData = true
                        completion(true)
                    } else {
                        print("HealthKit authorization did not complete successfully.")
                        completion(false)
                    }
                }
            })
        } else {
            completion(false)
        }
    }

    func fetchHealthData() {
        var totalStepCount: Double?
        var totalStandTime: Double?
        let group = DispatchGroup() // synchronize the completion of the multiple asynchronous operations

        group.enter()
        getStepCount { stepCountData in
            if let stepCountData = stepCountData {
                totalStepCount = stepCountData
                group.leave()
            }
        }

        group.enter()
        getStandTime { standTimeData in
            if let standTimeData = standTimeData {
                totalStandTime = standTimeData
                group.leave()
            }
        }

        group.notify(queue: .main) { [self] in // if all operations completed
            self.HKModel.setTotalStepCount(stepCount: totalStepCount!)
            self.HKModel.setTotalStandTime(standTime: totalStandTime!)

            // Change daily task values directly
            let coinAddition = dailyTaskModel.updateDailyTasksData(totalStepCount: Int(totalStepCount!), totalStandTime: Int(totalStandTime!))
            statModel.addCoin(amount: coinAddition)
        }
    }

    func getStepCount(completion: @escaping (Double?) -> Void) {
        HKModel.queryStepCount(for: .stepCount, completion: { stepCountData, error in
            if let error = error {
                print("HealthKit query step count data Error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            completion(stepCountData)
        })
    }

    func getStandTime(completion: @escaping (Double?) -> Void) {
        HKModel.queryStandTime(completion: { totalStandTime, error in
            if let error = error {
                print("HealthKit query stand time data Error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            completion(totalStandTime)
        })
    }
}
