//
//  FeedVM.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 04/11/2021.
//
import SwiftUI

class FeedVM: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var loading: Bool
    
    init(){
        self.posts = []
        self.loading = true
    }
    
    
    func fetchPosts(){
        self.posts = Bundle.main.decode(type: [Post].self, from: "feed.json")
        self.loading = false
    }
    
    func refreshFeed(){
        let newPosts = Bundle.main.decode(type: [Post].self, from: "feed2.json")
        newPosts.forEach{post in
            posts.insert(post, at: 0)
        }
    }
}
        	
