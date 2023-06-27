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
    var hasRequestedHealthData = false

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        authorizeHealthKit()
//    }

    func authorizeHealthKit() {
        if HKHealthStore.isHealthDataAvailable() {
            let infoToRead = Set([
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!,
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

        getStepCount()
    }

    func getStepCount() {
        HKModel.queryData(for: .stepCount, completion: { stepCountData, error in
            if let error = error {
                // Handle error
                return
            }

            if let stepCountData = stepCountData {
                // Process the step count data for the current day
                print("Accumulative step count for today:")
                print(stepCountData)
            }
        })
    }
}
