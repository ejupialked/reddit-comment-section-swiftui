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
    
    //represents the root of the comments
    @Published var root: CommentVM = CommentVM(comment: Comment(commentId: "root", content: "", displayName: "", created: "", likes: 0))

    
    @Published var commentSection: [CommentVM] = []
    
    init(post: Post){
        self.postVm = PostVM(post: post)
        self.loading = true
    }
    
    func fetchComments(postId: String) {
        //TODO: fetch comments using post id
        self.comments = Bundle.main.decode(type: [Comment].self, from: "comments.json")
        self.root.addAllChildren(children: comments.map{CommentVM(comment: $0)})
        flatTree()
        self.loading = false
    }
    

    public func flatTree(){
        self.commentSection = CommentVM.preorder(root)
        self.commentSection.removeFirst()
    }
}
