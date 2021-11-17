//
//  CommentVM.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 07/11/2021.
//

import Foundation
import SwiftUI

class CommentVM: ObservableObject, Identifiable {
    
    var id: String = UUID().uuidString
    public weak var parent: CommentVM?
    public var depth: Int?
    private var replies: [CommentVM] = []

    @Published var comment: Comment
    @Published public var children: [CommentVM] = []
    @Published var loading: Bool = false
    @Published var padding: CGFloat = 0
    
    init(comment: Comment){
        self.comment = comment;
        
        if self.parent == nil {
            self.depth = 0
        }
    }
    
    func fetchReplies(vm: PostDetailVM) {
        self.loading = true
        //Todo: provide parent id to fetch replies
        let replies = Bundle.main.decode(type: [Comment].self, from: "comments.json").map{CommentVM(comment: $0)}
        addAllChildren(children: replies)
        
        if let index = self.getCommentIndex(from: vm.commentSection, comment: self) {
            vm.commentSection.insert(contentsOf: self.children, at: index+1)
        }
        
        
        self.loading = false
    }
    
    public func addChild(_ node: CommentVM) {
        node.parent = self
        if let depthParent = self.depth {
            node.depth = depthParent + 1
            node.padding = CGFloat(depthParent + 1)
        }
        children.insert(node, at: 0)
    }
    
    public func addAllChildren(children: [CommentVM]) {
        children.forEach{addChild($0)}
    }
    
    public static func preorder(_ node: CommentVM) -> [CommentVM] {
        var list = [CommentVM]()
        helper(&list, node)

        return list
    }
    
    public static func helper(_ list: inout[CommentVM], _ node: CommentVM) {
        list.append(node)
        for n in node.children {
            helper(&list, n)
        }
    }
    
    func getCommentIndex(from: [CommentVM], comment: CommentVM) -> Int? {
        return from.firstIndex(where: { $0 === comment })
    }
}
