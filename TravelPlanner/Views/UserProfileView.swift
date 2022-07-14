//
//  UserProfileView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/13/22.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                BucketListView()
            } label: {
                HStack {
                    Image(systemName: "heart")
                    Text("My Bucket List")
                }
            }
            .navigationTitle("My Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
