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
    case getScienceNews
    case getSportNews
    case getHealthNews
    case getBusinessNews
    case getEntertainmentNews
    case getTechnologyNews
}

extension NewsAPI: APIBuilder {
    
    var urlRequest: URLRequest {
//        return URLRequest(url: self.baseURL.appendingPathComponent(self.apiKey))
        return URLRequest(url: self.baseURL)
    }
    
    var baseURL: URL {
        switch self {
        case .getNews:
            return URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=general&sortBy=publishedAt&apiKey=8631663fe2b14af68b2a07fc89cbafce")!
        case .getScienceNews:
            return URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=science&sortBy=publishedAt&apiKey=8631663fe2b14af68b2a07fc89cbafce")!
        case .getSportNews:
            return URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=sports&sortBy=publishedAt&apiKey=8631663fe2b14af68b2a07fc89cbafce")!
        case .getBusinessNews:
            return URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&sortBy=publishedAt&apiKey=8631663fe2b14af68b2a07fc89cbafce")!
        case .getHealthNews:
            return URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=health&sortBy=publishedAt&apiKey=8631663fe2b14af68b2a07fc89cbafce")!
        case .getEntertainmentNews:
            return URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=entertainment&sortBy=publishedAt&apiKey=8631663fe2b14af68b2a07fc89cbafce")!
        case .getTechnologyNews:
            return URL(string: "https://newsapi.org/v2/top-headlines?country=&category=technology&sortBy=publishedAt&apiKey=8631663fe2b14af68b2a07fc89cbafce")!
        }
    }
    
    var apiKey: String {
        return "8631663fe2b14af68b2a07fc89cbafce"
    }
    
    
}
