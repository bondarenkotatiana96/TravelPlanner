//
//  Strings+Localizations.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/27/22.
//

import Foundation

extension String {

    /// Localizes a string using given language from Language enum.
    func localized(_ language: Language) -> String {
        let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj")
        let bundle: Bundle
        if let path = path {
            bundle = Bundle(path: path) ?? .main
        } else {
            bundle = .main
        }
        return localized(bundle: bundle)
    }

    /// Localizes a string using given language from Language enum with dynamic arguments provided for the localized string
    func localized(_ language: Language, args arguments: CVarArg...) -> String {
        let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj")
        let bundle: Bundle
        if let path = path {
            bundle = Bundle(path: path) ?? .main
        } else {
            bundle = .main
        }
        return String(format: localized(bundle: bundle), arguments: arguments)
    }

    /// Localizes a string using self as key.
    private func localized(bundle: Bundle) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
