//
//  SettingsView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/27/22.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("settings_language".localized(language))
                    .foregroundColor(Color("SecondaryDark"))
                    .font(.title)
                    .bold()
                    .padding()
                Menu {
                    Button {
                        LocalizationService.shared.language = .russian
                    } label: {
                        Text("Русский")
                    }
                    Button {
                        LocalizationService.shared.language = .english_us
                    } label: {
                        Text("English (US)")
                    }
                    Button {
                        LocalizationService.shared.language = .spanish
                    } label: {
                        Text("Español")
                    }
                    Button {
                        LocalizationService.shared.language = .korean
                    } label: {
                        Text("한국어")
                    }
                } label: {
                    Spacer()
                    Image(systemName: "ellipsis.circle.fill")
                        .font(.system(size: 25))
                }.padding()
            }
            Text("settings_language_footer".localized(language))
                .foregroundColor(Color("SecondaryDark"))
                .font(.headline)
                .padding(.leading)
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
