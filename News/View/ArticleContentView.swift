//
//  ArticleContentView.swift
//  News
//
//  Created by macbook on 23.8.22..
//

import SwiftUI
import URLImage
import FASwiftUI

struct ArticleContentView: View {
    
    let article: Article
    
    var body: some View {
        ScrollView {
            
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
                
            } else {
                PlaceholderImageView()
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(article.title ?? "")
                        .font(.title)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(article.source?.name ?? "")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        .fixedSize(horizontal: false, vertical: true)
                    Link(article.url ?? "",
                         destination: URL(string: article.url ?? "")!)
                    
                    HStack {
                        FAText(iconName: "facebook", size: 40)
                            .foregroundColor(Color.blue)
                        FAText(iconName: "instagram", size: 40)
                            .foregroundColor(Color.yellow)
                        FAText(iconName: "twitter", size: 40)
                            .foregroundColor(Color.blue)
                        FAText(iconName: "share", size: 40)
                            .foregroundColor(Color.purple)
                    } .padding(.top)
                        
                }
            
                Spacer()
                
            }.padding()
                
            Text(article.content ?? "")
                .font(.body)
                .padding()
        }
    }
}

struct ArticleContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleContentView(article: Article.dummyData)
    }
}
