//
//  AccessibilityModifier.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 01/03/2025.
//

import SwiftUI

enum AccessibilityType {
    case button(label: String? = nil), textField(label: String? = nil), image, text(label: String), slider, pulseButton, toolBarMenu, sortSheetOpen, filterSheetOpen

    var label: String {
        switch self {
            case .button(let label):
                if let label = label {
                    return label
                }
                return "Button"
            case .textField(let label):
                if let label = label {
                    return label
                }
                return "TextField"
            case .image:
                return "Image"
            case .text(let label):
                return label
            case .slider:
                return "Slider"
            case .pulseButton:
                return "Pulse Button"
            case .toolBarMenu:
                return "Tool Bar Menu"
            case .sortSheetOpen:
                return "Sort Sheet Open"
            case .filterSheetOpen:
                return "Filter Sheet Open"
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
        case .pulseButton:
            return "Pulse effect for Add Button"
        case .toolBarMenu:
            return "Tool Bar Menu for Search Option"
        case .sortSheetOpen:
            return "sheet for Search Option"
        case .filterSheetOpen:
            return "sheet for Search Option"
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
