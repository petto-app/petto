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
            ForEach(dailyTasks) { task in
                ZStack {
                    HStack(spacing: 40) {
                        Text(task.name)
                        Text("\(task.amount!)/\(task.maxAmount)")
                        HStack {
                            StrokeText(text: "\(task.coin)", width: 1, color: Color("CoinBorder"))
                                .foregroundColor(Color("Coin")).fontWeight(.bold)

                            Image(systemName: "bitcoinsign.circle.fill").foregroundColor(.yellow)
                        }
                    }
                    .padding(.bottom, 35)

                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(Color.black)
                }
            }
        }
    }
}

// struct DailyTask_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyTask(dailyTasks: [
//            DailyTaskItem(name: "Take 1000 steps", amount: 100, maxAmount: 1000, coin: 10, isDone: false),
//            DailyTaskItem(name: "Take 50 steps", amount: 100, maxAmount: 1000, coin: 10, isDone: false)
//        ])
//    }
// }
