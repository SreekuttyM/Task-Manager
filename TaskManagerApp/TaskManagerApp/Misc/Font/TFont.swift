//
//  TFont.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

enum FontWeight {
    case light
    case medium
    case bold
    case black
    case regular
}

extension Font {
    static  func customFont(fontType: FontWeight, size: CGFloat) -> Font {
        switch fontType {
        case .light:
            Font.custom("Roboto-Light", size: size)
        case .medium:
            Font.custom("Roboto-Medium", size: size)
        case .bold:
            Font.custom("Roboto-Bold", size: size)
        case .black:
            Font.custom("Roboto-Black", size: size)
        case .regular:
            Font.custom("Roboto-Regular", size: size)
        }
    }
}
