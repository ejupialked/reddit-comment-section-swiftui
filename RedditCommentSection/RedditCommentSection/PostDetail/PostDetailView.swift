//
//  PostDetailView.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 07/11/2021.
//

import SwiftUI

struct PostDetailView: View {
    @ObservedObject var vm: PostDetailVM
    
    var body: some View {
        ScrollView {
            VStack{
                Divider()
                PostView(vm: vm.postVm)
                Divider()
                if self.vm.loading {
                    ProgressView().progressViewStyle(.circular)
                } else {
                    VStack(spacing:0){
                        ForEach(vm.commentSection, id: \.id){ comment in
                            CommentView(postDetailVM: vm, vm: comment)
                        }
                    }.listRowInsets(EdgeInsets())
                }
            }
        }.listStyle(PlainListStyle())
            .navigationTitle(Text("Post Detail"))
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{vm.fetchComments(postId: "")}
        
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(vm: PostDetailVM(post: Post(postId: "test", content: "Hello everyone", displayName: "Alked", created: "2021-09-18T11:21:35Z", likes: 3)))
    }
}
