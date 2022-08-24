//
//  NewsEndpoint.swift
//  News
//
//  Created by macbook on 23.8.22..
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseURL: URL { get }
    var apiKey: String { get }
}

enum NewsAPI {
    case getNews
}

extension NewsAPI: APIBuilder {
    
    var urlRequest: URLRequest {
//        return URLRequest(url: self.baseURL.appendingPathComponent(self.apiKey))
        return URLRequest(url: self.baseURL.appendingPathExtension(self.apiKey))
    }
    
    var baseURL: URL {
        switch self {
        case .getNews:
            return URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=52995fcfaa124a7491780d889a25ca13")!
        }
    }
    
    var apiKey: String {
        return "52995fcfaa124a7491780d889a25ca13"
    }
    
    
}
