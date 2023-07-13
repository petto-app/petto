//
//  BMView.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 02/07/23.
//

import SwiftUI

protocol BottomSheetDelegate {
    func dismissBottomSheet()
}

protocol PopUpDelegate {
    func addPopUp(bodyMovementTask: BodyMovementTaskItem)
}

struct BMView: UIViewControllerRepresentable {
    typealias UIViewControllerType = BMViewController
    @EnvironmentObject var bottomSheet: BottomSheet
    @EnvironmentObject var statController: StatController
    @EnvironmentObject var bodyMovementTaskModel: BodyMovementTaskModel
    @EnvironmentObject var statModel: StatModel
    @EnvironmentObject var popUpModel: PopUpModel

    func makeUIViewController(context: Context) -> BMViewController {
        let sb = UIStoryboard(name: "BodyMovement", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "BMViewStoryboard") as! BMViewController
        vc.coordinator = context.coordinator

        if let bodyMovementTask = bodyMovementTaskModel.getRandomTask() {
            vc.bodyMovementTask = bodyMovementTask
            print("Assigned BM Task: \(bodyMovementTask.movementType)")
        }

        vc.statModel = statModel

        return vc
    }

    func updateUIViewController(_: BMViewController, context _: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }

    func makeCoordinator() -> BMView.Coordinator {
        return Coordinator(self)
    }
}

struct BMView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BMView()
                .ignoresSafeArea()

            Image("shiba-1")
                .resizable()
                .scaledToFit().frame(width: 250)
                .padding(.top, -190)
                .padding(.leading, -100)
        }
    }
}

extension BMView {
    class Coordinator: NSObject, ObservableObject, BottomSheetDelegate, PopUpDelegate {
        var parent: BMView

        init(_ parent: BMView) {
            self.parent = parent
        }

        func dismissBottomSheet() {
            parent.bottomSheet.showSheet = false
        }

        func addPopUp(bodyMovementTask: BodyMovementTaskItem) {
            parent.popUpModel.addItem(
                PopUpItem(
                    type: .bodyMovementTask,
                    bodyMovementTask: bodyMovementTask,
                    state: .showing(totalCoin: bodyMovementTask.coin)
                )
            )
            print("BM Task pop up added!")
        }

        func getBodyMovementStringType(item: BodyMovementTaskItem) -> String {
            return parent.bodyMovementTaskModel.getStringType(item: item)
        }
    }
}
