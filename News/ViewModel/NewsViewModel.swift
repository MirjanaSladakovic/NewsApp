//
//  NewsViewModel.swift
//  News
//
//  Created by macbook on 23.8.22..
//

import Foundation
import Combine

protocol NewsViewModel {
    func getArticles(categoryState: CategoryState)
    func getSearchArticles(categoryState: CategoryState, keyword: String)
}

class NewsViewModelImpl: ObservableObject, NewsViewModel {

    private let service: NewsService
    
    private(set) var articles = [Article]()
    private var cancellable = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading
    
    init(service: NewsService) {
        self.service = service
    }
    
    func getArticles(categoryState: CategoryState) {
        
        self.state = .loading
        
        let cancellable = service
            .request(from: getAPICategoryByState(state: categoryState))
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
    
    func getSearchArticles(categoryState: CategoryState, keyword: String) {
        
        self.state = .loading
        
        let cancellable = service
            .searchRequest(from: getAPICategoryByState(state: categoryState), keyword: keyword)
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
    
    func getAPICategoryByState(state: CategoryState) -> NewsAPI {
        
        switch state {
        case .general:
            return .getNews
        case .science:
            return .getScienceNews
        case .sport:
            return .getSportNews
        case .health:
            return .getHealthNews
        case .business:
            return .getBusinessNews
        case .entertainment:
            return .getEntertainmentNews
        case .technology:
            return .getTechnologyNews
        }
    }
}
