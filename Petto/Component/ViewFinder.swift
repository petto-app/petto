//
//  ViewfinderView.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 30/06/23.
//

import SwiftUI

struct ViewFinder: View {
    @Binding var image: Image?

    var body: some View {
        GeometryReader { geometry in
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

struct ViewFinder_Previews: PreviewProvider {
    static var previews: some View {
        ViewFinder(image: .constant(Image(systemName: "gearshape")))
    }
}
