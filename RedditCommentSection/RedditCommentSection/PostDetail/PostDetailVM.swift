//
//  PostDetailVM.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 07/11/2021.
//

import Foundation


class PostDetailVM: ObservableObject {
    @Published var comments: [Comment] = []
    @Published var loading: Bool
    @Published var postVm: PostVM
    
    init(post: Post){
        self.postVm = PostVM(post: post)
        self.loading = true
    }
    
    func fetchComments(postId: String) {
        //TODO: fetch comments using post id
        self.comments = Bundle.main.decode(type: [Comment].self, from: "comments.json")
        self.loading = false
    }

}
