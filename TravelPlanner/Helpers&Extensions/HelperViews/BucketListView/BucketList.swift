//
//  BucketList.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/23/22.
//

import SwiftUI

struct BucketList: View {
    @ObservedObject var bucketListVM: BucketListViewModel
    @State var searching: Bool
    var body: some View {
        List {
            ForEach(bucketListVM.destinations) { destination in
                HStack(spacing: 22) {
                    Button {
                        bucketListVM.toggleIsVisited(destination)
                    } label: {
                        Image(systemName: destination.isVisited ? "pin.circle.fill" : "pin.circle")
                            .foregroundColor(Color("AccentColor"))
                            .font(.system(size: 30))
                    }
                    Text(destination.name)
                }
            }
            .onDelete(perform: bucketListVM.deleteDestination(index:))
            .frame(minHeight: 50)
            .listRowSeparator(.hidden, edges: .top)
            .listRowSeparatorTint(Color("AccentColor"), edges: .bottom)
        }
        .listStyle(.plain)
        .navigationTitle(searching ? "Searching" : "My Bucket List")
        .navigationBarTitleDisplayMode(.inline)
    }
}
