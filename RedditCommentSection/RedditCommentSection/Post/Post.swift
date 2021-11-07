//
//  Post.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 04/11/2021.
//

import Foundation

struct Post: Codable {
    var postId: String
    var content: String
    var displayName: String
    var created: String
    var likes: Int
}

extension Post: Identifiable {
    var id: UUID {  return UUID() }
}




