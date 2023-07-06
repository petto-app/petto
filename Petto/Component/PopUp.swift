//
//  PopUp.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 04/07/23.
//

import SwiftUI

struct PopUp: View {
    @State var popUp: PopUpItem
    @EnvironmentObject var popUpModel: PopUpModel
    @EnvironmentObject var statController: StatController
    @EnvironmentObject var dailyTaskController: DailyTaskController
    @ObservedObject var dailyTaskModel = DailyTaskModel.shared
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                ZStack {
                    Rectangle().frame(width: 300, height: 200)
                        .foregroundColor(Color("PrimetimeContainer"))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("BlueBorder"), lineWidth: 3)
                        )

                    VStack {
                        Text("Congratulations!")
                            .foregroundColor(Color("Coin"))
                            .fontWeight(.bold)
                        Text("You got \(popUp.dailyTask.coin) Star Coins")
                            .foregroundColor(Color("Coin"))
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                        Button("Claim") {
                            print("Claimed")

                            
                            if let index = popUpModel.popUpItems.firstIndex(where: { $0.dailyTask.name == popUp.dailyTask.name }) {
                                // Update daily task to Done
                                if let taskIndex = dailyTaskModel.dailyTasks.lastIndex(where: { $0.name == popUp.dailyTask.name }) {
                                    dailyTaskModel.dailyTasks[taskIndex].isDone = true
                                    
                                     // Update Finish All Task daily task
                                    if dailyTaskModel.dailyTasks[dailyTaskModel.dailyTasks.count - 1].amount! <= 4 {
                                        dailyTaskModel.dailyTasks[dailyTaskModel.dailyTasks.count - 1].amount! += 1
                                    }
                                    if dailyTaskModel.dailyTasks[dailyTaskModel.dailyTasks.count - 1].amount! == 4 {
                                        popUpModel.addItem(PopUpItem(dailyTask: dailyTaskModel.dailyTasks[dailyTaskModel.dailyTasks.count - 1], state: .showing(totalCoin: dailyTaskModel.dailyTasks[dailyTaskModel.dailyTasks.count - 1].coin)))
                                    }
                                }
                                // Delete PopUp Items
                                popUpModel.popUpItems[index].state = .hidden
                                statController.increaseCoin(amount: popUp.dailyTask.coin)
                                popUpModel.popUpItems.remove(at: index)
                            }
                        }
                        .buttonStyle(MainButton(width: 80))
                    }
                    
                }
                
            }
        }
    }

}

struct PopUp_Previews: PreviewProvider {
    static var previews: some View {
        PopUp(popUp: PopUpItem(
            dailyTask:
                DailyTaskItem(name: "Take 1000 steps", amount: 1200, maxAmount: 1000, coin: 100, isDone: true, type: .stepCount),
            state: .showing(totalCoin: 100)
            )
        )
    }
}
