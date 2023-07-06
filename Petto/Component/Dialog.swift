//
//  Dialog.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 06/07/23.
//

import SwiftUI

struct Dialog: View {
    @State var message: String
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                ZStack {
                    Rectangle().frame(width: 279, height: 71)
                        .foregroundColor(Color("PrimetimeContainer"))
                        .cornerRadius(10)
                    
                    VStack {
                        Text(message)
                            .foregroundColor(Color("StarCoin"))
                            .fontWeight(.bold)
                            .padding(.bottom, 1)
                    }
                }
            }
        }
    }
}

struct Dialog_Previews: PreviewProvider {
    static var previews: some View {
        Dialog(message: "Great! 4 to go!")
    }
}

struct Dialog2_Previews: PreviewProvider {
    static var previews: some View {
        Dialog(message: "You can do it better!")
    }
}
