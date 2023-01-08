//
//  EnvironmentValuesExtension.swift
//  Klaxit
//
//  Created by Sabri Belguerma on 08/01/2023.
//

import SwiftUI

@available(iOS 14.0, *)
extension EnvironmentValues {
    var dismiss: () -> Void {
        { presentationMode.wrappedValue.dismiss() }
    }
}
