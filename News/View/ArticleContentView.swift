//
//  ArticleContentView.swift
//  News
//
//  Created by macbook on 23.8.22..
//

import SwiftUI
import URLImage

struct ArticleContentView: View {
    
    let article: Article
    
    var body: some View {
        VStack {
            
            if let imgURL = article.urlToImage,
               let url = URL(string: imgURL) {
                
                URLImage(url,
                         failure: { error, _ in
                    PlaceholderImageView()
                },
                         content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                })
                .frame(maxWidth: .infinity, maxHeight: 300)
                .cornerRadius(10)
                
            } else {
                PlaceholderImageView()
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(article.title ?? "")
                        .font(.title)
                    Text(article.source?.name ?? "")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                }
                
                Spacer()
            }
            .padding()
            
            Text(article.content ?? "")
                .font(.body)
                .padding()
            
            Spacer()
        }
    }
}

struct ArticleContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleContentView(article: Article.dummyData)
    }
}
