//
//  FancyToast.swift
//
//
//  Created by Aaron Christopher Tanhar on 18/04/23.
//

import Foundation

struct FancyToast: Equatable {
    var type: FancyToastStyle
    var title: String
    var message: String
    var duration: Double = 3
}

class FancyToastClass: ObservableObject {
    @Published var toast: FancyToast?
}
