//
//  ColorExtension.swift
//  UberApp
//
//  Created by Agata Menes on 22/03/2023.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryColor = Color("SecondaryBackgroundColor")
    let primaryColor = Color("PrimaryTextColor")
}
