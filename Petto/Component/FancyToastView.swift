//
//  SwiftUIView.swift
//
//
//  Created by Aaron Christopher Tanhar on 18/04/23.
//

import SwiftUI

struct FancyToastView: View {
    var type: FancyToastStyle
    var title: String
    var message: String
    var onCancelTapped: () -> Void
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: type.iconFileName)
                    .foregroundColor(type.themeColor)

                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))

                    Text(message)
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.6))
                }

                Spacer(minLength: 10)

                Button {
                    onCancelTapped()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }
            .padding()
        }
        .background(Color("TaskSheet"))
        .overlay(
            Rectangle()
                .fill(type.themeColor)
                .frame(width: 6)
                .clipped(),
            alignment: .leading
        )
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
}

struct FancyToastModifier: ViewModifier {
    @Binding var toast: FancyToast?
    @State private var workItem: DispatchWorkItem?

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: -30)
                }.animation(.spring(), value: toast)
            )
            .onChange(of: toast) { _ in
                showToast()
            }
    }

    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                Spacer()
                FancyToastView(
                    type: toast.type,
                    title: toast.title,
                    message: toast.message
                ) {
                    dismissToast()
                }
            }
            .transition(.move(edge: .bottom))
        }
    }

    private func showToast() {
        guard let toast = toast else { return }

        UIImpactFeedbackGenerator(style: .light).impactOccurred()

        if toast.duration > 0 {
            workItem?.cancel()

            let task = DispatchWorkItem {
                dismissToast()
            }

            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }

    private func dismissToast() {
        withAnimation {
            toast = nil
        }

        workItem?.cancel()
        workItem = nil
    }
}

extension View {
    func toastView(toast: Binding<FancyToast?>) -> some View {
        modifier(FancyToastModifier(toast: toast))
    }
}

struct FancyToastView_Previews: PreviewProvider {
    static var previews: some View {
        FancyToastView(type: .info, title: "banger", message: "ciy", onCancelTapped: { print("to") })
    }
}
