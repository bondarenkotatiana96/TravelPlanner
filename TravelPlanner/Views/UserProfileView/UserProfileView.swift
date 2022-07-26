//
//  UserProfileView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/13/22.
//

import SwiftUI

struct UserProfileView: View {
    
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
                    ButtonLabel(text: "My Bucket List", imageName: "heart.circle", width: 300, height: 50, imageSize: 32)
                }
                
                Button {
                    shouldShowOnboarding.toggle()
                } label: {
                    ButtonLabel(text: "Help & how-to", imageName: "questionmark.circle", width: 300, height: 50, imageSize: 32)
                }
                
                Button {
                    email.send(openURL: openURL)
                } label: {
                    ButtonLabel(text: "Feedback & support", imageName: "envelope.circle", width: 300, height: 50, imageSize: 32)
                }
                .navigationTitle("My Profile")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
