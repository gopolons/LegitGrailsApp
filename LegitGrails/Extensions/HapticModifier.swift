//
//  HapticModifier.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 01/12/2021.
//

import SwiftUI

enum HapticFeedback {
    
    case soft
    case light
    case heavy
    case rigid
    case medium
    case success
    case warning
    case error
    
    func impact() {
        let notificationGenerator = UINotificationFeedbackGenerator()
        switch self {
        case .soft:
            let impactGenerator = UIImpactFeedbackGenerator(style: .soft)
            impactGenerator.impactOccurred()
        case .light:
            let impactGenerator = UIImpactFeedbackGenerator(style: .light)
            impactGenerator.impactOccurred()
        case .heavy:
            let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
            impactGenerator.impactOccurred()
        case .rigid:
            let impactGenerator = UIImpactFeedbackGenerator(style: .rigid)
            impactGenerator.impactOccurred()
        case .medium:
            let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
            impactGenerator.impactOccurred()
        case .success:
            notificationGenerator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.success)
        case .warning:
            notificationGenerator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.warning)
        case .error:
            notificationGenerator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
        
        }
    }
}

struct HapticModifier: ViewModifier {
    
    let haptic: HapticFeedback
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                haptic.impact()
            }
    }
}

extension View {
    func hapticFeedback(_ haptic: HapticFeedback) -> some View {
        modifier(HapticModifier(haptic: haptic))
    }
}
