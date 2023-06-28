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
    public static var shared: HealthKitModel = HealthKitModel()
    @Published var healthStore = HKHealthStore()
    @Published var totalStepCount: Double
    @Published var totalStandTime: Double

    init() {
        totalStepCount = 0.1
        totalStandTime = 0.1
    }
    
    func queryData(for typeIdentifier: HKQuantityTypeIdentifier, completion: @escaping (Double?, Error?) -> Void) {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: typeIdentifier) else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data type"]))
            return
        }

        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Date()
        var interval = DateComponents()
        interval.day = 1

        // TODO: Returned Array ([Double]?)
//        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
//        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
//            guard let samples = results as? [HKQuantitySample], error == nil else {
//                completion(nil, error)
//                return
//            }
//
//            let data = samples.map { $0.quantity.doubleValue(for: HKUnit.count()) }
//            completion(data, nil)
//        }

        // TODO: Returned Accumulative
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
