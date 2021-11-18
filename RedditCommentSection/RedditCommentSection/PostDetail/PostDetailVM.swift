//
//  PostDetailVM.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 07/11/2021.
//

import Foundation
import SwiftUI


class PostDetailVM: ObservableObject {
    @Published var comments: [Comment] = []
    @Published var loading: Bool
    @Published var postVm: PostVM
    @Published var currentParentReply: CommentVM?
    
    //represents the root of the comments
    @Published var root: CommentVM = CommentVM(comment: Comment(commentId: "root", parentId: "", content: "", displayName: "", created: "", likes: 0))

    
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
    
    public func sendReply(commentText: String){
        let comment = CommentVM(comment: Comment(commentId: UUID().uuidString, parentId: "", content: commentText, displayName: "Admin", created: Date().ISO8601Format().description, likes: 0))
        
        //It's a reply
        if let parent = self.currentParentReply {
            // set depth
            // TODO: duplicated code, remove and use addChild(...)
            comment.comment.parentId = parent.comment.commentId //remove when using Api
            comment.depth = parent.depth! + 1
            comment.padding = parent.padding + 1

            if let index = parent.getCommentIndex(from: commentSection, comment: parent) {
                withAnimation{commentSection.insert(comment, at: index+1)}
            }
        }else{
            //It's a comment
            comment.depth = 1
            comment.padding = 1
            withAnimation{commentSection.insert(comment, at: 0)}
        }
        
        withAnimation{ self.currentParentReply = nil }

    }
    
    public func reply(currentParentReply: CommentVM){
        withAnimation{ self.currentParentReply = currentParentReply }
    }
}
