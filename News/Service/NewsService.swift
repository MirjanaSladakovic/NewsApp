//
//  NewsService.swift
//  News
//
//  Created by macbook on 23.8.22..
//

import Foundation
import Combine

protocol NewsService {
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError>
    func searchRequest(from endpoint: NewsAPI, keyword: String) -> AnyPublisher<NewsResponse, APIError>
}

struct NewsServiceImpl: NewsService {
    
    func searchRequest(from endpoint: NewsAPI, keyword: String) -> AnyPublisher<NewsResponse, APIError> {
        return requestImplementation(urlRequest: endpoint.searchNews(searchKeyword: keyword))
    }
    
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError> {
        return requestImplementation(urlRequest: endpoint.urlRequest)
    }
    
    func requestImplementation(urlRequest: URLRequest) -> AnyPublisher<NewsResponse, APIError>{
        
        return URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<NewsResponse, APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    
                    return Just(data)
                        .decode(type: NewsResponse.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                    
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
                
            }
            .eraseToAnyPublisher()
    }
}
