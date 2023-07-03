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
        VStack {
            ForEach(dailyTasks.indices, id: \.self) { index in
                let task = dailyTasks[index]

                ZStack {
                    HStack(spacing: 40) {
                        Text(task.name)
                            .font(.subheadline)
                            .strikethrough(task.isDone, color: .black)
                        Text("\(task.amount!)/\(task.maxAmount)")
                            .font(.subheadline)
                            .strikethrough(task.isDone, color: .black)
                        HStack {
                            StrokeText(text: "\(task.coin)", width: 1, color: Color("CoinBorder"))
                                .font(.subheadline)
                                .foregroundColor(Color("Coin")).fontWeight(.bold)
                                .strikethrough(task.isDone, color: .black)

                            Image(systemName: "bitcoinsign.circle.fill").foregroundColor(.yellow)
                                .strikethrough(task.isDone, color: .black)
                        }
                    }
                    .padding(.bottom, 20)

                    if index != dailyTasks.indices.last {
                        Rectangle()
                            .frame(width: 350, height: 1)
                            .foregroundColor(Color.black)
                    }
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
            DailyTaskItem(name: "Finish All Tasks", amount: 0, maxAmount: 5, coin: 100, isDone: false),
        ]))
    }
}
