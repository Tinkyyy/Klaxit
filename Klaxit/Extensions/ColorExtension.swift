//
//  ColorExtension.swift
//  Klaxit
//
//  Created by Sabri Belguerma on 07/01/2023.
//

import SwiftUI

extension Color {
    static func color(for colorScheme: ColorScheme) -> Color {
        return colorScheme == .dark ? .white : .black
    }
}
