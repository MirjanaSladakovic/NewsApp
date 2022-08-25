//
//  NewsView.swift
//  News
//
//  Created by macbook on 23.8.22..
//

import SwiftUI
import FASwiftUI

struct NewsCategory {
    
    static let general = "General"
    static let science = "Science"
    static let sport = "Sport"
    static let health = "Health"
    static let business = "Business"
    static let entertainment = "Entertainment"
    static let technology = "Technology"
    
    static let categories = "Categories"
    
    static let news = "News"
}

struct NewsView: View {
    
    @State private var isShowingArticleContentView = false
    
    @State var searchQuery = ""
    @State var categoryState: CategoryState = .general
    
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    
    var body: some View {
                        
        Group {
            
            switch viewModel.state {
                
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, handler: {
                    viewModel.getArticles(categoryState: categoryState)
                } )
            case .success(let articles):
                
                NavigationView {
                    List(articles) { item in
                        
                        NavigationLink(destination: ArticleContentView(article: item), isActive: $isShowingArticleContentView) {
                        
                            ArticleView(article: item)
                                .onTapGesture {
                                    
                                    if(item.content?.isEmpty == true) {
                                        if let url = URL(string: item.url ?? "") {
                                               UIApplication.shared.open(url)
                                            }
                                    } else {
                                        isShowingArticleContentView = true
                                    }
                                    
                                }
                        }
                    }
                    .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
                    .onSubmit(of: .search) { viewModel.getSearchArticles(categoryState: categoryState, keyword: self.searchQuery) }
                    .onChange(of: searchQuery) { value in
                        if searchQuery.isEmpty{
                            viewModel.getArticles(categoryState: categoryState)
                        }
                    }
                    .navigationTitle(Text(getCategoryHeadline()))
                    .navigationBarItems(trailing: {
                        Menu {
                            Button(action: {
                                categoryState = .general
                                viewModel.getArticles(categoryState: categoryState)
                            }) {
                                Label(NewsCategory.general, systemImage: "")
                            }
                            Button(action: {
                                categoryState = .science
                                viewModel.getArticles(categoryState: categoryState)
                            }) {
                                Label(NewsCategory.science, systemImage: "")
                            }
                            Button(action: {
                                categoryState = .sport
                                viewModel.getArticles(categoryState: categoryState)
                            }) {
                                Label(NewsCategory.sport, systemImage: "")
                            }
                            Button(action: {
                                categoryState = .health
                                viewModel.getArticles(categoryState: categoryState)
                            }) {
                                Label(NewsCategory.health, systemImage: "")
                            }
                            Button(action: {
                                categoryState = .business
                                viewModel.getArticles(categoryState: categoryState)
                            }) {
                                Label(NewsCategory.business, systemImage: "")
                            }
                            Button(action: {                                categoryState = .entertainment
                                viewModel.getArticles(categoryState: categoryState)
                            }) {
                                Label(NewsCategory.entertainment, systemImage: "")
                            }
                            Button(action: {
                                categoryState = .technology
                                viewModel.getArticles(categoryState: categoryState)
                            }) {
                                Label(NewsCategory.technology, systemImage: "")
                            }
                        } label: {
                            Text(NewsCategory.categories)
                        }
                        
                    }())
                }
            }
            
        }.onAppear(perform: {
            viewModel.getArticles(categoryState: categoryState)
        } )
    }
    
    func getCategoryHeadline() -> String {
        
        switch categoryState {
            
        case .general:
            return NewsCategory.news
        case .science:
            return NewsCategory.science + " " + NewsCategory.news
        case .sport:
            return NewsCategory.sport + " " + NewsCategory.news
        case .health:
            return NewsCategory.health + " " + NewsCategory.news
        case .business:
            return NewsCategory.business + " " + NewsCategory.news
        case .entertainment:
            return NewsCategory.entertainment + " " + NewsCategory.news
        case .technology:
            return NewsCategory.technology + " " + NewsCategory.news
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
