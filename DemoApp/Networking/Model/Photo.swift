//
//  Photo.swift
//  DemoApp
//
//  Created by Vineeth Aravindan on 05/03/19.
//  Copyright © 2019 vineeth. All rights reserved.
//

import Foundation

public struct Photo:Codable {
    private enum PhotoCodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadUrl = "download_url"
    }
    var id:String
    var author:String
    var width:Int
    var height:Int
    var url:String
    var downloadUrl:String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PhotoCodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        author = try container.decode(String.self, forKey: .author)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
        url = try container.decode(String.self, forKey: .url)
        downloadUrl = try container.decode(String.self, forKey: .downloadUrl)
        
    }
}

