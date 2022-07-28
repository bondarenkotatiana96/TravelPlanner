//
//  OnboardingPageView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/28/22.
//

import SwiftUI

struct PageView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @Binding var shouldShowOnboarding: Bool
    
    var text: String
    var imageName: String
    let showsDismissButton: Bool
    
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.4))
            VStack {
                Button {
                    shouldShowOnboarding.toggle()
                } label: {
                    Text("skip".localized(language))
                }
                .offset(x: 150, y: -200)
                
                Text(text)
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 30)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("AccentColor").opacity(0.3)))
                    .frame(width: UIScreen.main.bounds.width - 50)
                
                if showsDismissButton {
                    Button {
                        shouldShowOnboarding.toggle()
                    } label: {
                        ButtonLabel(text: "start_button".localized(language), imageName: "", width: 200, height: 50, imageSize: 0)
                    }
                }
            }
        }
    }
}
