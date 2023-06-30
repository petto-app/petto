//
//  Shop.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 29/06/23.
//

import SwiftUI

struct Shop: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var bottomSheet: BottomSheet

    @StateObject var timeController: TimeController = .init()

    @EnvironmentObject var fToast: FancyToastClass
    @EnvironmentObject var statController: StatController

    var body: some View {
        VStack {
            ZStack {
                Image("ShopBg").resizable().ignoresSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                        }.buttonStyle(IconButton(width: 30, height: 30)).offset(y: 20)
                        Coin(coin: 100, totalCoin: 1000).offset(y: 20)
                        Spacer()
                        PrimeTime().offset(x: -25, y: 20)
                    }
                    Stats(fun: $statController.statModel.fun.amount, hygiene: $statController.statModel.hygiene.amount, energy: $statController.statModel.energy.amount).offset(y: -20)
                    Spacer()
                }.padding()
            }
        }
        .onAppear {
            bottomSheet.showSheet = false
        }
        .navigationBarBackButtonHidden(true)
        .toastView(toast: $fToast.toast)
    }
}

struct Shop_Previews: PreviewProvider {
    static var previews: some View {
        Shop().environmentObject(FancyToastClass())
    }
}
