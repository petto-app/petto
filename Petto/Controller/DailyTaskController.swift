//
//  DailyTaskController.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 27/06/23.
//

import Foundation
import SwiftUI

class DailyTaskController: ObservableObject {
    var dailyTaskModel = DailyTaskModel.shared

    func getData() -> [DailyTaskItem] {
        return dailyTaskModel.dailyTasks
    }
}
