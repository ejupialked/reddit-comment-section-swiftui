//
//  Comment.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 07/11/2021.
//

import Foundation

struct Comment: Codable {
    var commentId: String
    var parentId: String
    var content: String
    var displayName: String
    var created: String
    var likes: Int
}

extension Comment: Identifiable {
    var id: UUID {  return UUID() }
}
