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
    
    @Environment(\.openURL) var openURL
    
    var email = SupportEmail(toAddress: "96bondarenkotatiana@gmail.com", subject: "Feedback Email", messageHeader: "Please describe your feedback/issue below.")
    
    @AppStorage var shouldShowOnboarding: Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 40) {
                Image("avatar")
                    .padding(.bottom)
                NavigationLink {
                    BucketListView()
                } label: {
                    ButtonLabel(text: "bucket_list".localized(language), imageName: "heart.circle", width: 300, height: 50, imageSize: 32)
                }
                
                Button {
                    shouldShowOnboarding.toggle()
                } label: {
                    ButtonLabel(text: "help".localized(language), imageName: "questionmark.circle", width: 300, height: 50, imageSize: 32)
                }
                
                Button {
                    email.send(openURL: openURL)
                } label: {
                    ButtonLabel(text: "feedback".localized(language), imageName: "envelope.circle", width: 300, height: 50, imageSize: 32)
                }
                
                NavigationLink {
                    SettingsView()
                } label: {
                    ButtonLabel(text: "settings".localized(language), imageName: "gear.circle", width: 300, height: 50, imageSize: 32)
                }
                .navigationTitle("profile_title".localized(language))
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
