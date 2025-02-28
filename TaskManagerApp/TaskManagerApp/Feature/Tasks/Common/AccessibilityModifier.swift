//
//  AccessibilityModifier.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 01/03/2025.
//

import SwiftUI

enum AccessibilityType {
    case button, textField, image, text, slider

    var label: String {
        switch self {
        case .button:
            return "Button"
        case .textField:
            return "Text Field"
        case .image:
            return "Image"
        case .text:
            return "Text"
        case .slider:
            return "Slider"
        }
    }

    var hint: String {
        switch self {
        case .button:
            return "Tap to perform an action."
        case .textField:
            return "Enter text into this field."
        case .image:
            return "Image element."
        case .text:
            return "Text Like Label"
        case .slider:
            return "Drag to adjust the value."
        }
    }
}

struct AccessibilityModifier: ViewModifier {
    var accessibilityType: AccessibilityType

    func body(content: Content) -> some View {
        content
            .accessibilityLabel(accessibilityType.label)
            .accessibilityHint(accessibilityType.hint)
    }
}

extension View {

    func accessible(_ type: AccessibilityType) -> some View {
        self.modifier(AccessibilityModifier(accessibilityType: type))
    }
}
