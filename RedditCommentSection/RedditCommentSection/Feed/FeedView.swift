//
//  FeedView.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 04/11/2021.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var vm: FeedVM = FeedVM()
    
    var body: some View {
        NavigationView{
            VStack{
                if vm.loading {
                    ProgressView().progressViewStyle(.circular)
                } else {
                    ListItem{
                        ForEach(vm.posts){ post in
                            PostView(vm: PostVM(post: post))
                            
                        }
                
                    }.refreshable {
                        vm.refreshFeed()
                    }.listStyle(PlainListStyle())
                    
                }
                
            }.navigationTitle(Text("Feed"))
                .onAppear(perform: vm.fetchPosts)
        }.navigationViewStyle(.automatic)
        
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
