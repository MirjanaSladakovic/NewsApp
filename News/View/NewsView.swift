//
//  NewsView.swift
//  News
//
//  Created by macbook on 23.8.22..
//

import SwiftUI
import FASwiftUI

struct NewsView: View {
    
    @State private var isShowingArticleContentView = false
    
    @State var searchQuery = ""
    
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    
    var body: some View {
                        
        Group {
            
            switch viewModel.state {
                
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, handler: { viewModel.getArticles(category: .getNews) } )
            case .success(let articles):
                
                NavigationView {
                    List(articles) { item in
                        
                        NavigationLink(destination: ArticleContentView(article: item), isActive: $isShowingArticleContentView) { EmptyView() }
                        
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
                    .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
                    .onSubmit(of: .search) { viewModel.getSearchArticles(category: .getNews, keyword: self.searchQuery) }
                    .onChange(of: searchQuery) { value in
                        if searchQuery.isEmpty{
                            viewModel.getArticles(category: .getNews)
                        }
                    }
                    .navigationTitle(Text("News"))
                    .navigationBarItems(trailing: {
                        Menu {
                            Button(action: { viewModel.getArticles(category: .getScienceNews) }) {
                                Label("Science", systemImage: "")
                            }
                            Button(action: { viewModel.getArticles(category: .getSportNews) }) {
                                Label("Sport", systemImage: "")
                            }
                            Button(action: { viewModel.getArticles(category: .getHealthNews) }) {
                                Label("Health", systemImage: "")
                            }
                            Button(action: { viewModel.getArticles(category: .getBusinessNews) }) {
                                Label("Bussiness", systemImage: "")
                            }
                            Button(action: { viewModel.getArticles(category: .getEntertainmentNews) }) {
                                Label("Entertainment", systemImage: "")
                            }
                            Button(action: { viewModel.getArticles(category: .getTechnologyNews) }) {
                                Label("Technology", systemImage: "")
                            }
                        } label: {
                            Text("Categories")
                        }
                        
                    }())
                }
            }
            
        }.onAppear(perform: { viewModel.getArticles(category: .getNews) } )
    }
}



struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
