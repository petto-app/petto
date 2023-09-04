//
//  SummaryView.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 02/07/23.
//

import SwiftUI

struct SummaryView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SummaryViewController

    func makeUIViewController(context _: Context) -> SummaryViewController {
        let vc = SummaryViewController()
        return vc
    }

    func updateUIViewController(_: SummaryViewController, context _: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
