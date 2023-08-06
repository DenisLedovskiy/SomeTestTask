//
//  PViewSizesProtocol.swift
//  SomeTestTask
//
//  Created by Денис Ледовский on 04.08.2023.
//

import Foundation
import UIKit

protocol PViewSizesProtocol {

    static var scale: CGFloat { get }
    static var daScreenWidth: CGFloat { get }
    static var daLeftPadding: CGFloat { get }
    var currentLanguageIsRussian: Bool { get }
    func makeSize(eightLow scale2x: Double, tenUp scale3x: Double, withoutScale: Bool) -> CGFloat
    static func makeSizeStatic(eightLow scale2x: Double, tenUp scale3x: Double, withoutScale: Bool) -> CGFloat
}


extension PViewSizesProtocol {

    static var modelName:  String  { return UIDevice.modelName }
    static var differentModel: [String] {
        ["iPhone XR", "iPhone 11", "Simulator iPhone 11", "Simulator iPhone XR"]
    }
    static var scale: CGFloat { return UIScreen.main.scale }
    static var daScreenWidth: CGFloat { return  UIScreen.main.bounds.width }
    static var daLeftPadding: CGFloat { return  scale == 2 ? 8 : 16 }

    var currentLanguageIsRussian: Bool {

        if let preferredLanguage = Locale.preferredLanguages.first, preferredLanguage.hasPrefix("ru") {
            return true
        }
        return false
    }

    func makeSize(eightLow scale2x: Double, tenUp scale3x: Double, withoutScale: Bool = false) -> CGFloat {

        let aspectDisplay = UIScreen.main.bounds.width / UIScreen.main.bounds.height

        if withoutScale {
            if aspectDisplay > 0.5 {
                return CGFloat(scale2x)
            } else {
                return CGFloat(scale3x)
            }
        }

        let sizeFactorForTenAndHigher = sqrt(
            pow(UIScreen.main.bounds.height, 2) + pow( UIScreen.main.bounds.width, 2)
        ) / sqrt(pow(375, 2) + pow(812, 2))

        let scaleFactorForEightAndLower = sqrt(
            pow(UIScreen.main.bounds.height, 2) + pow( UIScreen.main.bounds.width, 2)
        ) / sqrt(pow(375, 2) + pow(667, 2))


        if aspectDisplay > 0.5 {
            /// apply scale factor for 8 iPhone and lower models
            return CGFloat(scale2x) * CGFloat(scaleFactorForEightAndLower)
        } else {
            /// apply scale factor for X iPhones and later models
            return CGFloat(scale3x) * CGFloat(sizeFactorForTenAndHigher)
        }
    }

    static func makeSizeStatic(eightLow scale2x: Double, tenUp scale3x: Double, withoutScale: Bool = false) -> CGFloat {

        let aspectDisplay = UIScreen.main.bounds.width / UIScreen.main.bounds.height

        if withoutScale {
            if aspectDisplay > 0.5 {
                return CGFloat(scale2x)
            } else {
                return CGFloat(scale3x)
            }
        }

        let sizeFactorForTenAndHigher = sqrt(
            pow(UIScreen.main.bounds.height, 2) + pow( UIScreen.main.bounds.width, 2)
        ) / sqrt(pow(375, 2) + pow(812, 2))

        let scaleFactorForEightAndLower = sqrt(
            pow(UIScreen.main.bounds.height, 2) + pow( UIScreen.main.bounds.width, 2)
        ) / sqrt(pow(375, 2) + pow(667, 2))


        if aspectDisplay > 0.5 {
            /// apply scale factor for 8 iPhone and lower models
            return CGFloat(scale2x) * CGFloat(scaleFactorForEightAndLower)
        } else {
            /// apply scale factor for X iPhones and later models
            return CGFloat(scale3x) * CGFloat(sizeFactorForTenAndHigher)
        }
    }
}
