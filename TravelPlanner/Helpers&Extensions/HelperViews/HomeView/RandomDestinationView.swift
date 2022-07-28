//
//  RandomDestinationView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/23/22.
//

import SwiftUI

struct RandomDestinationView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @State var randomDestination: RandomDestination
    @State var isHidden: Bool
    
    var body: some View {
        Text("adventurous_question".localized(language))
            .foregroundColor(Color("Background"))
        Button {
            withAnimation(.linear.delay(0.3)) {
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
            }
        } label: {
            ButtonLabel(
                text: isHidden ? "get_destination".localized(language) : "close".localized(language),
                imageName: "airplane",
                width: 280, height: 50, imageSize: 25
            )
        }
            
        Text("\(randomDestination.city), \(randomDestination.country)")
            .foregroundColor(Color("Background"))
            .font(.system(size: 20))
            .isHidden(isHidden, remove: isHidden)
    }
}
