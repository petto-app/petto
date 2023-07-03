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
    
    func makeUIViewController(context: Context) -> BMViewController {
        let sb = UIStoryboard(name: "BodyMovement", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "BMViewStoryboard") as! BMViewController
        vc.coordinator = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: BMViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
    
    func makeCoordinator() -> BMView.Coordinator {
        return Coordinator(self)
    }
}

struct BMView_Previews: PreviewProvider {
    static var previews: some View {
        BMView()
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
