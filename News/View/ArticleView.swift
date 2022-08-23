//
//  ArticleView.swift
//  News
//
//  Created by macbook on 23.8.22..
//

import SwiftUI
import URLImage

struct ArticleView: View {
    
    let article: Article
    
    var body: some View {
        HStack {
            
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
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                
            } else {
                PlaceholderImageView()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(article.title ?? "")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                Text(article.source?.name ?? "")
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            
        }
    }
}

struct PlaceholderImageView: View {
    
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(width: 100, height: 100)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
