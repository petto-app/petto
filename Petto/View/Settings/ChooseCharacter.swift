//
//  ChooseCharacter.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 10/07/23.
//

import SwiftUI

struct ChooseCharacter: View {
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var bottomSheet: BottomSheet

    @EnvironmentObject var fToast: FancyToastClass
    @EnvironmentObject var characterController: CharacterController

    @State private var currentIndex = 0

    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .brown
        UIPageControl.appearance().pageIndicatorTintColor = .gray
    }

    var body: some View {
        VStack {
            ZStack {
                Image("SettingsBg").resizable().ignoresSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image("Arrow").resizable().frame(width: 22, height: 22)
                        }.buttonStyle(IconButton(width: 30, height: 30)).offset(y: 20)
                        Spacer()
                        PrimeTime().opacity(0)
                    }
                    SettingsHeaderButton(width: 60, height: 60, title: "Choose Your Character", image: "Paw", active: true) {}
                    TabView(selection: $currentIndex) {
                        VStack {
                            Image("DogCharacter").resizable()
                                .scaledToFit().frame(width: UIScreen.main.bounds.size.width * 0.7)
                        }
                        .tag(0)
                        VStack {
                            Image("CatCharacter").resizable()
                                .scaledToFit().frame(width: UIScreen.main.bounds.size.width * 0.5)
                        }
                        .tag(1)
                    }.onChange(of: currentIndex) { value in print("selected tab = \(value)") }
                        .background(.white)
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        .frame(width: UIScreen.main.bounds.size.width * 0.8, height: UIScreen.main.bounds.size.height * 0.5)
                        .cornerRadius(10)
                    Button("Save") {
                        if currentIndex == 0 {
                            characterController.setCharacter(character: .dog)
                        } else {
                            characterController.setCharacter(character: .cat)
                        }

                        fToast.toast = FancyToast(type: .success, title: "Success", message: "Character saved", duration: 3)
                    }
                    .buttonStyle(MainButton(width: 80))
                    Spacer()
                }.padding()
            }
        }
        .onAppear {
            bottomSheet.showSheet = false
            currentIndex = characterController.getCharacter() == "dog" ? 0 : 1
        }
        .navigationBarBackButtonHidden(true)
        .toastView(toast: $fToast.toast)
    }
}

struct ChooseCharacter_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var fToast = FancyToastClass()
        @StateObject var statController = StatController()
        @StateObject var gameKitController = GameKitController()
        @StateObject var bottomSheet = BottomSheet()
        @StateObject var characterController = CharacterController()
        ChooseCharacter().environmentObject(fToast)
            .environmentObject(statController)
            .environmentObject(gameKitController)
            .environmentObject(bottomSheet)
            .environmentObject(characterController)
    }
}
