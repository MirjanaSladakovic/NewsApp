//
//  SearchView.swift
//  News
//
//  Created by macbook on 24.8.22..
//

import SwiftUI

struct SearchView: View {
    
    @State var searchQuery = ""
    
    var body: some View {
        NavigationView {
            
            List() { }
            .searchable(text: $searchQuery)
            .navigationTitle(Text("Search news"))
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
