//
//  KlaxitRoundedButtonStyle.swift
//  Klaxit
//
//  Created by Sabri Belguerma on 07/01/2023.
//

import SwiftUI

public struct KlaxitButtonStyle: ButtonStyle {
    var backgroundColor: Color
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(5)
            .foregroundColor(configuration.isPressed ? backgroundColor.opacity(0.5) : backgroundColor)
            .overlay(
                Capsule()
                    .stroke(configuration.isPressed ? backgroundColor.opacity(0.5) : backgroundColor, lineWidth: 1.5)
            )
     }
}
