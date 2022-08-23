//
//  ResultState.swift
//  News
//
//  Created by macbook on 23.8.22..
//

import Foundation

enum ResultState {
    case loading
    case success(content: [Article])
    case failed(error: Error)
}
