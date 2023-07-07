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
                    Image("shiba-1")
                        .resizable()
                        .scaledToFit().frame(width: 200)
                        .padding(.top, -190)
                        .padding(.leading, -100)

                    Rectangle().frame(width: 300, height: 180)
                        .foregroundColor(Color("PrimetimeContainer"))
                        .cornerRadius(10)

                    VStack {
                        Text("Congratulations!")
                            .foregroundColor(Color("StarCoin"))
                            .fontWeight(.bold)
                            .padding(.bottom, 1)
                        Text("You've completed \(popUp.dailyTask.name) and got \(popUp.dailyTask.coin) Star Coins")
                            .foregroundColor(Color("StarCoin"))
                            .font(.footnote)
                            .padding(.bottom, 13)
                            .padding(.horizontal, 90)
                            .multilineTextAlignment(.center)
                        Button("Claim Now") {
                            print("Claimed")

                            if let index = popUpModel.popUpItems.firstIndex(where: { $0.dailyTask.name == popUp.dailyTask.name }) {
                                // Update daily task to Done
                                if let taskIndex = dailyTaskModel.dailyTasks.lastIndex(where: { $0.name == popUp.dailyTask.name }) {
                                    dailyTaskModel.dailyTasks[taskIndex].isDone = true
                                    
                                    // Update "Finish All Task" daily task
                                    if dailyTaskModel.dailyTasks[4].amount! < dailyTaskModel.dailyTasks[4].maxAmount {
                                        dailyTaskModel.dailyTasks[4].amount! += 1
                                    }
                                    if dailyTaskModel.dailyTasks[4].amount! == dailyTaskModel.dailyTasks[4].maxAmount {
                                        if dailyTaskModel.dailyTasks[4].isDone == false {
                                            popUpModel.addItem(
                                                PopUpItem(dailyTask: dailyTaskModel.dailyTasks[4], state: .showing(totalCoin: dailyTaskModel.dailyTasks[4].coin))
                                            )
                                        }
                                        
                                    }
                                }
                                // Delete PopUp Items
                                popUpModel.popUpItems[index].state = .hidden
                                statController.increaseCoin(amount: popUp.dailyTask.coin)
                                popUpModel.popUpItems.remove(at: index)
                            }
                        }
                        .buttonStyle(MainButton(width: 80))
                        .font(.footnote)
                    }
                    
                    Image("Coins")
                        .resizable()
                        .scaledToFit().frame(width: 110)
                        .padding(.top, 210)
                        .padding(.leading, 240)
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
