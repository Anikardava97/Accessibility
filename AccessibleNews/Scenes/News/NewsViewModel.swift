//
//  NewsViewModel.swift
//  AccessibleNews
//
//  Created by Ani's Mac on 27.12.23.
//

import SwiftUI

final class NewsViewModel: ObservableObject {
    // MARK: - Properties
    @Published private(set) var articles: [Article] = []
    @Published private(set) var error: String?
    
    // MARK: - Init
    init() {
        fetchNews()
    }
    
    // MARK: - Network Call
    func fetchNews() {
        let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2023-11-27&sortBy=publishedAt&apiKey=5caafd85a03e4e6ca9d985f69f5439a8#"
        guard let URL = URL(string: urlString) else { return }
        
        NetworkManager.shared.fetchDecodableData(from: URL, responseType: ArticlesData.self, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.articles = data.articles
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            }
        })
    }
}
