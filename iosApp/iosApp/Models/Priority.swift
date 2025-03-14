//
//  Priority.swift
//  iosApp
//
//  Created by kutasov on 13.03.2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

enum Priority: String, CaseIterable {
    case low = "LOW"
    case medium = "MEDIUM"
    case high = "HIGH"

    var displayName: String {
        switch self {
        case .low: return "Low"
        case .medium: return "Medium"
        case .high: return "High"
        }
    }

    var color: Color {
        switch self {
        case .low: return .blue
        case .medium: return .orange
        case .high: return .red
        }
    }
}
