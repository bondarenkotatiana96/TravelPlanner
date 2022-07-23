//
//  RandomDestinationView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/23/22.
//

import SwiftUI

struct RandomDestinationView: View {
    @State var randomDestination: RandomDestination
    @State var isHidden: Bool
    
    var body: some View {
        Text("Feeling adventurous?")
            .foregroundColor(Color("BackgroundYellow"))
        Button {
            if isHidden {
                RandomDestinationService().getRandomDestination { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let randomDestination):
                            self.randomDestination = randomDestination
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
                isHidden.toggle()
            } else {
                isHidden.toggle()
            }
        } label: {
            ButtonLabel(text: isHidden ? "Get a random destination" : "Close", imageName: "airplane", width: 280, height: 50, imageSize: 25)
        }
            
        Text("\(randomDestination.city), \(randomDestination.country)")
            .foregroundColor(Color("BackgroundYellow"))
            .font(.system(size: 20))
            .isHidden(isHidden, remove: isHidden)
    }
}
