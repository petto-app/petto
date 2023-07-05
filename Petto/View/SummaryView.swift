//
//  SummaryView.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 02/07/23.
//

import SwiftUI

struct SummaryView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SummaryViewController
    
    func makeUIViewController(context: Context) -> SummaryViewController {
        let vc = SummaryViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: SummaryViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}

