//
//  NewsViewModel.swift
//  News
//
//  Created by macbook on 23.8.22..
//

import Foundation
import Combine

protocol NewsViewModel {
    func getArticles(category: NewsAPI)
}

class NewsViewModelImpl: ObservableObject, NewsViewModel {
    
    private let service: NewsService
    
    private(set) var articles = [Article]()
    private var cancellable = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading
    
    init(service: NewsService) {
        self.service = service
    }
    
    func getArticles(category: NewsAPI) {
        
        self.state = .loading
        
        let cancellable = service
            .request(from: category)
            .sink { res in
                switch res {
                    
                case .finished:
                    self.state = .success(content: self.articles)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.articles = response.articles
            }
        
        self.cancellable.insert(cancellable)
    }
    
    func getSearchArticles(category: NewsAPI, keyword: String) {
        
        self.state = .loading
        
        let cancellable = service
            .searchRequest(from: category, keyword: keyword)
            .sink { res in
                switch res {
                    
                case .finished:
                    self.state = .success(content: self.articles)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.articles = response.articles
            }
        
        self.cancellable.insert(cancellable)
    }
}
