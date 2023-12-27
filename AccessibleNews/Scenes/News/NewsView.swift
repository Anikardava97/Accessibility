//
//  NewsView.swift
//  AccessibleNews
//
//  Created by Ani's Mac on 27.12.23.
//

import SwiftUI

struct NewsView: View {
    // MARK: - Properties
    @EnvironmentObject var viewModel: NewsViewModel
    @Environment(\.sizeCategory) var sizeCategory
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            NewsCollectionView()
                .navigationTitle("🗞️ Daily News")
        }
        .minimumScaleFactor(sizeCategory.customMinScaleFactor)
    }
}

// MARK: - Custom ScaleFactor
extension ContentSizeCategory {
    var customMinScaleFactor: CGFloat {
        switch self {
        case .extraSmall, .small, .medium:
            return 1.0
        case .large, .extraLarge, .extraExtraExtraLarge:
            return 0.8
        default:
            return 0.6
        }
    }
}

#Preview {
    NewsView()
        .environmentObject(NewsViewModel())
}
