//
//  NewsView.swift
//  News
//
//  Created by macbook on 23.8.22..
//

import SwiftUI

struct NewsView: View {
    
    @State private var isShowingArticleContentView = false
    
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    
    var body: some View {
        Group {
            
            switch viewModel.state {
                
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.getArticles)
            case .success(let articles):
                NavigationView {
                    List(articles) { item in
                        
                        NavigationLink(destination: ArticleContentView(article: item), isActive: $isShowingArticleContentView) { EmptyView() }
                        
                        ArticleView(article: item)
                            .onTapGesture {
                                isShowingArticleContentView = true
                            }
                    }
                    .navigationTitle(Text("News"))
                }
            }
            
        }.onAppear(perform: viewModel.getArticles)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
