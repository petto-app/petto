//
//  HealthKitModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 26/06/23.
//

import Foundation
import HealthKit
import SwiftUI

class HealthKitModel: ObservableObject {
    public static var shared: HealthKitModel = .init()
    @Published var healthStore = HKHealthStore()
    @Published var totalStepCount: Double
    @Published var totalStandTime: Double

    init() {
        totalStepCount = 1.0
        totalStandTime = 1.0
    }

    func queryStandTime(completion: @escaping (Double?, Error?) -> Void) {
        let standType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleStandTime)!

        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Date()
        var interval = DateComponents()
        interval.day = 1

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let query = HKStatisticsCollectionQuery(quantityType: standType, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: startDate, intervalComponents: interval)
        query.initialResultsHandler = { _, result, _ in
            var minutes = 0.0
            result?.enumerateStatistics(from: startDate, to: endDate, with: { statistics, _ in
                if let sumQuantity = statistics.sumQuantity() {
                    minutes = sumQuantity.doubleValue(for: .minute())
                }
                DispatchQueue.main.async {
                    completion(minutes, nil) // Return the minutes
                }
            })
        }

        healthStore.execute(query)
    }

    func queryStepCount(for typeIdentifier: HKQuantityTypeIdentifier, completion: @escaping (Double?, Error?) -> Void) {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: typeIdentifier) else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data type"]))
            return
        }

        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Date()
        var interval = DateComponents()
        interval.day = 1

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let query = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: startDate, intervalComponents: interval)
        query.initialResultsHandler = { _, result, _ in
            var sumStepCount = 0.0
            result?.enumerateStatistics(from: startDate, to: endDate) { statistics, _ in
                if let sumQuantity = statistics.sumQuantity() {
                    sumStepCount = sumQuantity.doubleValue(for: HKUnit.count()) // Get the step count as Double.
                }
                DispatchQueue.main.async {
                    completion(sumStepCount, nil) // Return the step count.
                }
            }
        }

        healthStore.execute(query)
    }

    func setTotalStepCount(stepCount: Double) {
        totalStepCount = stepCount
        print(totalStepCount)
    }

    func setTotalStandTime(standTime: Double) {
        totalStandTime = standTime
        print(totalStandTime)
    }
}
