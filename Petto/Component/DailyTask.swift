//
//  DailyTask.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 27/06/23.
//

import SwiftUI

struct DailyTask: View {
    @Binding var dailyTasks: [DailyTaskItem]

    var body: some View {
        Grid(alignment: .leading, verticalSpacing: 12) {
            ForEach(dailyTasks.indices, id: \.self) { index in
                let task = dailyTasks[index]
                GridRow {
                    Toggle(isOn: .constant(task.isDone)) {}
                        .toggleStyle(IOSCheckboxToggleStyle())
                        .disabled(true)
                        .foregroundColor(task.isDone ? Color("TaskSheet") : .pink)
                        .background(task.isDone ? .pink : Color("TaskSheet"))

                    Text(task.name)
                        .font(.subheadline)

                    Text("\(task.amount!)/\(task.maxAmount)")
                        .font(.subheadline).opacity(0.4)
                    HStack {
                        StrokeText(text: "\(task.coin)", width: 1, color: Color("CoinBorder"))
                            .font(.subheadline)
                            .foregroundColor(Color("Coin")).fontWeight(.bold)

                        Image("StarCoin").resizable().frame(width: 20, height: 20)
                    }.gridColumnAlignment(.trailing)
                }

                if index != dailyTasks.indices.last {
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(Color.black)
                }
            }
        }
    }
}

struct DailyTask_Previews: PreviewProvider {
    static var previews: some View {
        DailyTask(dailyTasks: .constant([
            DailyTaskItem(name: "Take 1000 steps", amount: 1200, maxAmount: 1000, coin: 10, isDone: true, type: .stepCount),
            DailyTaskItem(name: "Take 5000 steps", amount: 0, maxAmount: 5000, coin: 50, isDone: false, type: .stepCount),
            DailyTaskItem(name: "Stand up for 10 minutes", amount: 0, maxAmount: 10, coin: 10, isDone: false, type: .appleStandTime),
            DailyTaskItem(name: "Stand up for 30 minutes", amount: 0, maxAmount: 30, coin: 50, isDone: false, type: .appleStandTime),
            DailyTaskItem(name: "Finish All Tasks", amount: 0, maxAmount: 5, coin: 100, isDone: false)
        ]))
    }
}
