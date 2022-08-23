//
//  NewsResponse.swift
//  News
//
//  Created by macbook on 23.8.22..
//

import Foundation

// MARK: - Welcome
struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Identifiable {
    let id = UUID()
    let source: Source?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}

extension Article {
    
    static var dummyData: Article {
        .init(source: Source(id: "the-washington-post", name: "The Washington Post"),
              author: "Adela Suliman",
              title: "Stunning Jupiter images shown by NASA's James Webb telescope - The Washington Post",
              articleDescription: "NASA described the images from the James Webb telescope, showing Jupiter's storms, auroras and faint rings, as « giant news from a giant planet. »",
              url: "https://www.washingtonpost.com/technology/2022/08/23/jupiter-photo-nasa-webb-telescope/",
              urlToImage: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/7L75FQRCFQI63JZPDZYUSBZPXQ.jpg&w=1440",
              publishedAt: Date(),
              content: "Comment on this story\r\nStunning images taken by NASAs James Webb Space Telescope show Jupiter in new glory.\r\nFifth in line from the Sun, Jupiter is the largest planet in our solar system more than tw… [+4700 chars]")
    }
}
