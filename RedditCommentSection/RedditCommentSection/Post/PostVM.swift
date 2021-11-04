//
//  PostVM.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 04/11/2021.
//

import SwiftUI

class PostVM: ObservableObject {
    @Published var post: Post
    
    init(post: Post){
        self.post = post;
    }
}
