//
//  HealthKitController.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 26/06/23.
//

import Foundation
import HealthKit
import UIKit

class HealthKitController: ObservableObject {
    var HKModel = HealthKitModel.shared
    var dailyTaskModel = DailyTaskModel.shared
    var hasRequestedHealthData = false

    init() {
        authorizeHealthKit()
        fetchHealthData()
    }
    
    func authorizeHealthKit() {
        if HKHealthStore.isHealthDataAvailable() {
            let infoToRead = Set([
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleStandTime)!,
            ])

            HKModel.healthStore.requestAuthorization(toShare: nil, read: infoToRead, completion: { success, error in
                if let error = error {
                    print("HealthKit Authorization Error: \(error.localizedDescription)")
                } else {
                    if success {
                        if self.hasRequestedHealthData {
                            print("You've already requested access to health data. ")
                        } else {
                            print("HealthKit authorization request was successful! ")
                        }
                        self.hasRequestedHealthData = true
                    } else {
                        print("HealthKit authorization did not complete successfully.")
                    }
                }
            })
        }
    }
    
    func fetchHealthData() {
//        var totalStepCount: Double?
//        var totalStandTime: Double?
        let group = DispatchGroup() // synchronize the completion of the multiple asynchronous operations
        
        group.enter()
        getStepCount { stepCountData in
            if let stepCountData = stepCountData {
//                totalStepCount = stepCountData
                self.HKModel.setTotalStepCount(stepCount: stepCountData)
                group.leave()
            }
        }
        
        group.enter()
        getStepCount { standTimeData in
            if let standTimeData = standTimeData {
//                totalStandTime = standTimeData
                self.HKModel.setTotalStandTime(standTime: standTimeData)
                group.leave()
            }
        }
        
        group.notify(queue: .main) { // if all operations completed

        }
        
    }

    func getStepCount(completion: @escaping (Double?) -> Void) {
        HKModel.queryData(for: .stepCount, completion: { stepCountData, error in
            if let error = error {
                print("HealthKit query data Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            completion(stepCountData)
        })
    }
    
    func getStandTime(completion: @escaping (Double?) -> Void) {
        HKModel.queryData(for: .appleStandTime, completion: { standTimeData, error in
            if let error = error {
                print("HealthKit query data Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            completion(standTimeData)
        })
    }
}
