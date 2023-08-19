//
//  PopUp.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 04/07/23.
//

import SwiftUI
import StoreKit

struct PopUp: View {
    @State var popUp: PopUpItem
    @Environment(\.requestReview) var requestReview
    @EnvironmentObject var popUpModel: PopUpModel
    @EnvironmentObject var statController: StatController
    @EnvironmentObject var dailyTaskController: DailyTaskController
    @EnvironmentObject var gameKitController: GameKitController
    @EnvironmentObject var audioController: AudioController
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

                        if let dailyTask = popUp.dailyTask, popUp.type == .dailyTask {
                            Text("You've completed \(popUp.dailyTask!.name) and got \(popUp.dailyTask!.coin) Star Coins")
                                .foregroundColor(Color("StarCoin"))
                                .font(.footnote)
                                .padding(.bottom, 13)
                                .padding(.horizontal, 90)
                                .multilineTextAlignment(.center)
                        } else {
                            Text("You got \(popUp.bodyMovementTask!.coin) Star Coins")
                                .foregroundColor(Color("StarCoin"))
                                .font(.footnote)
                                .padding(.bottom, 13)
                                .padding(.horizontal, 90)
                                .multilineTextAlignment(.center)
                        }

                        Button("Claim Now") {
                            if let index = popUpModel.popUpItems.firstIndex(where: {
                                $0.id == popUp.id
                            }) {
                                var taskCoin: Int?
                                if popUp.type == .dailyTask {
                                    // Update daily task to Done
                                    if let taskIndex = dailyTaskModel.dailyTasks.lastIndex(where: { $0.name == popUp.dailyTask!.name }) {
                                        dailyTaskModel.dailyTasks[taskIndex].isDone = true

                                        // Update "Finish All Task" daily task
                                        if dailyTaskModel.dailyTasks[4].amount! < dailyTaskModel.dailyTasks[4].maxAmount {
                                            dailyTaskModel.dailyTasks[4].amount! += 1
                                        }
                                        if dailyTaskModel.dailyTasks[4].amount! == dailyTaskModel.dailyTasks[4].maxAmount {
                                            if dailyTaskModel.dailyTasks[4].isDone == false {
                                                popUpModel.addItem(
                                                    PopUpItem(type: .dailyTask, dailyTask: dailyTaskModel.dailyTasks[4], state: .showing(totalCoin: dailyTaskModel.dailyTasks[4].coin))
                                                )
                                            }
                                        }
                                        taskCoin = popUp.dailyTask!.coin
                                        print("Claimed: \(popUp.dailyTask!.name)")
                                    }
                                } else {
                                    taskCoin = popUp.bodyMovementTask!.coin
                                    print("Claimed: \(popUp.bodyMovementTask!.movementType)")
                                }

                                // Delete PopUp Items
                                popUpModel.popUpItems[index].state = .hidden
                                statController.increaseCoin(amount: taskCoin!)
                                gameKitController.reportScore(totalCoin: statController.statModel.totalCoin!)
                                audioController.audioPlayer.playSound(soundFileName: "kaching")
                                if popUp.type == .bodyMovementTask && popUpModel.popUpItems.count == 1 {
                                    requestReview()
                                }
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

struct PopUpDailyTask_Previews: PreviewProvider {
    static var previews: some View {
        PopUp(popUp:
            PopUpItem(
                type: .dailyTask,
                dailyTask:
                DailyTaskItem(name: "Take 1000 steps", amount: 1200, maxAmount: 1000, coin: 100, isDone: true, type: .stepCount),
                state: .showing(totalCoin: 100)
            )
        )
    }
}

struct PopUpBodyMovement_Previews: PreviewProvider {
    static var previews: some View {
        PopUp(popUp:
            PopUpItem(
                type: .bodyMovementTask,
                bodyMovementTask:
                BodyMovementTaskItem(movementType: .twistingBody, amount: 3, coin: 100, images: ["shiba-1", "shiba-2", "shiba-3"]),
                state: .showing(totalCoin: 100)
            )
        )
    }
}
