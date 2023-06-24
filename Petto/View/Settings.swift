//
//  Settings.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 24/06/23.
//

import SwiftUI

struct Settings: View {
    @Environment(\.dismiss) var dismiss
    @State private var interval = 2
    @State private var startHour = "09"

    var body: some View {
        VStack {
            ZStack {
                Image("SettingsBg").resizable().ignoresSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.22)
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                        }.buttonStyle(IconButton(width: 30, height: 30)).offset(y: 20)
                        Coin(coin: 100, totalCoin: 1000).offset(y: 20)
                        Spacer()
                        PrimeTime().offset(x: -5, y: 20)
                    }
                    Stats().offset(y: -20)
                    SettingsContainer(intervalSelection: $interval, startSelection: $startHour)
                        .padding(.bottom)
                    Button("Save") {
                        print("Button pressed!")
                    }
                    .buttonStyle(MainButton(width: 80))
                    Spacer()
                }.padding()
            }
        }

        .navigationBarBackButtonHidden(true)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
