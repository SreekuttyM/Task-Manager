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
            Font.custom("Poppins-Light", size: size)
        case .medium:
            Font.custom("Poppins-Medium", size: size)
        case .bold:
            Font.custom("Poppins-Bold", size: size)
        case .black:
            Font.custom("Poppins-Black", size: size)
        case .regular:
            Font.custom("Poppins-Regular", size: size)
        }
    }
}
