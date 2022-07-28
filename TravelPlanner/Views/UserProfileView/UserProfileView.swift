//
//  UserProfileView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/13/22.
//

import SwiftUI

struct UserProfileView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @AppStorage var shouldShowOnboarding: Bool
    
    // Variables for sending feedback email
    @Environment(\.openURL) var openURL
    var email = SupportEmail(
        toAddress: "96bondarenkotatiana@gmail.com",
        subject: "Feedback Email",
        messageHeader: "Please describe your feedback/issue below."
    )
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 40) {
                    
                    Spacer()
                    Image("avatar")
                    Spacer()
                    
                    Button {
                        shouldShowOnboarding.toggle()
                    } label: {
                        ButtonLabel(
                            text: "help".localized(language),
                            imageName: "questionmark.circle",
                            width: 300, height: 50, imageSize: 32
                        )
                    }
                    
                    NavigationLink {
                        SettingsView()
                    } label: {
                        ButtonLabel(
                            text: "settings".localized(language),
                            imageName: "gear.circle", width: 300, height: 50, imageSize: 32
                        )
                    }
                    
                    Button {
                        email.send(openURL: openURL)
                    } label: {
                        ButtonLabel(
                            text: "feedback".localized(language),
                            imageName: "envelope.circle",
                            width: 300, height: 50, imageSize: 32
                        )
                    }
                    .navigationTitle("profile_title".localized(language))
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}
