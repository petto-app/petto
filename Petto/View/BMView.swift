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

struct BMView: UIViewControllerRepresentable {
    typealias UIViewControllerType = BMViewController
    @EnvironmentObject var bottomSheet: BottomSheet
    @EnvironmentObject var statController: StatController
    @EnvironmentObject var bodyMovementTaskModel: BodyMovementTaskModel
    @EnvironmentObject var statModel: StatModel
    
    func makeUIViewController(context: Context) -> BMViewController {
        let sb = UIStoryboard(name: "BodyMovement", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "BMViewStoryboard") as! BMViewController
        vc.coordinator = context.coordinator
        
        if let bodyMovementTask = bodyMovementTaskModel.getRandomTask() {
            vc.bodyMovementTask = bodyMovementTask
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
        ZStack{
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
    class Coordinator: NSObject, ObservableObject, BottomSheetDelegate {
        var parent: BMView

        init(_ parent: BMView) {
            self.parent = parent
        }

        func dismissBottomSheet() {
            parent.bottomSheet.showSheet = false
        }
    }
}
