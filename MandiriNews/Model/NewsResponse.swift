//
//  NewsResponse.swift
//  MandiriNews
//
//  Created by Alan Santoso on 12/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import Foundation

struct NewsResponse : Decodable{
    let status: String?
    let sources: [Source]?
}

// MARK: - Source
struct Source : Decodable{
    let id, name, description: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?
}



struct NewsModel {
    
    let id, name, sourceDescription: String?
    let url: String?
    let category: String?
    
}

