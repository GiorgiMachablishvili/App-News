//
//  NewsInfo.swift
//  Project 32 გიორგი მაჩაბლიშვილი
//
//  Created by Gio's Mac on 19.06.24.
//

import Foundation

struct NewsInfo: Codable {
    let status: String
    let totalResults: Int
    let articles: [Articles]
}

struct Articles: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String
}
