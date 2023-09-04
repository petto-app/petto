//
//  SettingsContainer.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 24/06/23.
//

import SwiftUI

struct SettingsContainer: View {
    @Binding var intervalSelection: Int
    @Binding var startSelection: String
    @Binding var finishSelection: String

    @StateObject var timeController: TimeController = .init()

    @EnvironmentObject var fToast: FancyToastClass

    let interval = [1, 2, 3]
    let hours = Array(0 ... 23).map { String(format: "%02d", $0) }
    @State private var currentDate = Date()
    var body: some View {
        VStack {
            Grid(alignment: .leadingFirstTextBaseline, horizontalSpacing: 30) {
                GridRow(alignment: .center) {
                    Text("Working Hour")
                    HStack {
                        HStack {
                            Picker("Select starting hour", selection: $startSelection) {
                                ForEach(hours, id: \.self) {
                                    Text("\($0)").font(.callout).foregroundColor(.black)
                                }
                            }
                            .pickerStyle(.wheel)
                            .labelsHidden().clipped()
                            .frame(width: 40, height: 90)
                            .compositingGroup()
                            .padding(.trailing, -8)
                            Text(".00").padding(.leading, -8)
                        }
                        Text("-")
                        HStack {
                            Picker("Select finish hour", selection: $finishSelection) {
                                ForEach(hours, id: \.self) {
                                    Text("\($0)").font(.callout).foregroundColor(.black)
                                }
                            }
                            .pickerStyle(.wheel)
                            .labelsHidden().clipped()
                            .frame(width: 40, height: 90)
                            .compositingGroup()
                            .padding(.trailing, -8)
                            Text(".00").padding(.leading, -8)
                        }
                    }
                }
                GridRow(alignment: .center) {
                    Text("Remind me every")
                    HStack {
                        Picker("Select interval hours", selection: $intervalSelection) {
                            ForEach(interval, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.menu)
                        Text("Hours")
                    }
                }
            }
        }
        .padding(.horizontal, 17)
        .padding(.bottom, 20)
        .shadow(radius: 2, y: 3)
        .frame(maxWidth: nil)
        .background(.white)
        .cornerRadius(10)
        .foregroundColor(.black)
    }
}

struct SettingsContainer_Previews: PreviewProvider {
    static var previews: some View {
        SettingsContainer(intervalSelection: .constant(2), startSelection: .constant("09"), finishSelection: .constant("17"))
    }
}
