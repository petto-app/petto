//
//  OnBoardingView.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 08/07/23.
//

import SwiftUI

struct OnBoardingItem: Hashable {
    var image: String
    var header: String
    var content: String
}

struct OnBoardingView<Content: View>: View {
    @State private var currentIndex = 0
    var onBoards: [OnBoardingItem]
    var link: Content?

    @AppStorage("isOnBoarded")
    var isOnBoarded: Bool?

    init(redirectTo: Content) {
        link = redirectTo

        onBoards = [
            OnBoardingItem(image: "ob-1", header: "Take care of a pet!", content: "Make sure to keep the Energy, Fun, and Hygiene bar full."),
            OnBoardingItem(image: "ob-2", header: "It’s shopping time!", content: "Buy items with Star Coins to fill in the bars."),
            OnBoardingItem(image: "ob-3", header: "Move and stretch your body!", content: "Get Star Coins from finishing Daily Tasks and Prime Time Tasks."),
            OnBoardingItem(image: "ob-4", header: "Change character!", content: "You can choose your pet in the Settings.")
        ]

        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("BlueBorder"))
    }

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Rectangle().fill(Color("OnBoardingContainer")).ignoresSafeArea()

                    TabView(selection: $currentIndex) {
                        ForEach(onBoards.indices, id: \.self) { index in
                            let item = onBoards[index]

                            ZStack {
                                Image(item.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)

                                VStack(alignment: .center) {
                                    Spacer()
                                    Spacer()
                                    Spacer()

                                    Text(item.header)
                                        .fontWeight(.bold)

                                    Text(item.content)
                                        .padding(.top, 10)
                                        .padding(.horizontal, 40)
                                        .multilineTextAlignment(.center)

                                    Spacer()
                                }
                                .foregroundColor(Color("BlueBorder"))

                                if currentIndex >= (onBoards.count - 1) {
                                    VStack {
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        Spacer()

                                        Button(action: {}) {
                                            NavigationLink(
                                                destination: link
                                                    .navigationBarBackButtonHidden(true)
                                            ) {
                                                ZStack {
                                                    Rectangle()
                                                        .fill(Color("BlueBorder"))
                                                        .frame(width: 100, height: 50)
                                                        .cornerRadius(10)

                                                    Text("Next")
                                                        .foregroundColor(.white)
                                                }
                                            }
                                        }

                                        Spacer()
                                    }
                                }
                            }
                            .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                }
            }
            .onAppear {
                isOnBoarded = false
                print(isOnBoarded)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OnBoardingView(redirectTo: Home())
        }
    }
}
