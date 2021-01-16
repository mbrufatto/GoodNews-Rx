//
//  Article.swift
//  GoodNews
//
//  Created by Marcio Habigzang Brufatto on 16/01/21.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

extension ArticleList {
    static var all: Resource<ArticleList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=br&apiKey=9d08f788c2534b3f9e400f5fd99d2bc9")!
        return Resource(url: url)
    }()
}

struct Article: Decodable {
    let title: String
    let description: String?
}

