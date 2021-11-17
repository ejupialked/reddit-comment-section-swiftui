//
//  CommentView.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 07/11/2021.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var postDetailVM : PostDetailVM
    @ObservedObject var vm: CommentVM
    
    var body: some View {
        HStack{
            
            if vm.padding != 1{
                ForEach((1...Int(vm.padding)-1).reversed(), id: \.self) { i in
                    Rectangle().frame(width: 1)
                        .foregroundColor(Color(UIColor.lightGray).opacity(0.5))
                        .padding(.leading, 5)
                        .opacity(self.vm.padding == 1 ? 0 : 1)
                }
            }
            
            VStack(spacing:5) {
                HStack {
                    Text(vm.comment.displayName).font(.footnote.bold())
                    Spacer()
                }
                HStack {
                    Text(vm.comment.content).font(.footnote)
                    Spacer()
                }
                HStack {
                    Text(vm.comment.created.toDate().timeAgoDisplay())
                    Spacer()
                    if self.vm.loading {
                        ProgressView().progressViewStyle(.circular)
                    }else{
                        Button("Show replies") {
                            self.vm.fetchReplies(vm: postDetailVM)
                        }
                    }
                    Spacer()
                    Image(systemName: "heart")
                    Text(vm.comment.likes.description)
                }.font(.footnote)
            }.padding()
            Spacer()
            
        }.padding(.leading, 5)
    }
}

struct CommentView_Previews: PreviewProvider {
    static var vm = PostDetailVM(post: Post(postId: "", content: "Testy test my post is amazing", displayName: "My beautiful display name", created: "2021-09-18T11:21:35Z", likes: 2))
    static var previews: some View {
        CommentView(postDetailVM: vm, vm: CommentVM(comment: Comment(commentId: "dd", content: "Hello everyon", displayName: "myName", created: "2021-10-31T03:31:52Z", likes: 3)))
    }
}
