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
                .padding(.bottom, -130)
                
            } else {
                PlaceholderImageView()
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Title")
                        .font(.title)
                    Text("Source")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                }
                
                Spacer()
            }
            .padding()
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
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
