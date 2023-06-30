//
//  CameraView.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 30/06/23.
//

import SwiftUI

struct CameraView: View {
    @StateObject private var model = CameraModel()
    @EnvironmentObject var bottomSheet: BottomSheet
    
    private static let barHeightFactor = 0.10
    
    var body: some View {
        GeometryReader { geometry in
            ViewFinder(image:  $model.viewFinderImage )
                .overlay(alignment: .bottom) {
                    buttonsView()
                        .frame(height: geometry.size.height * Self.barHeightFactor)
                        .background(.black.opacity(0.75))
                }
                .overlay(alignment: .center)  {
                    Color.clear
                        .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                        .accessibilityElement()
                        .accessibilityLabel("View Finder")
                        .accessibilityAddTraits([.isImage])
                }
                .background(.black)
        }
        .task {
            await model.camera.start()
        }
        .onAppear {
            bottomSheet.showSheet = false
        }
    }
    
    func buttonsView() -> some View {
        HStack(spacing: 60) {
            Spacer()
            
            Button {
                model.camera.switchCaptureDevice()
            } label: {
                Label("Switch Camera", systemImage: "arrow.triangle.2.circlepath")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
        .padding()
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var bottomSheet = BottomSheet()
        
        CameraView()
            .environmentObject(bottomSheet)
    }
}
