//
//  NewsModel.swift
//  AccessibleNews
//
//  Created by Ani's Mac on 27.12.23.
//

import Foundation

struct ArticlesData: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
}

