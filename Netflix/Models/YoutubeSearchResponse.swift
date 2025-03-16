//
//  YoutubeSearchResponse.swift
//  Netflix
//
//  Created by Hậu Nguyễn on 15/3/25.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String?
    let channelId: String?
}
