//
//  CommentView.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 07/11/2021.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var vm: CommentVM

    var body: some View {
            HStack{
                
                VStack {
                    HStack {
                        Text(vm.comment.displayName).font(.footnote.bold())
                    Spacer()
                    }
                    HStack {
                        Text(vm.comment.content).font(.footnote)
                        Spacer()
                    }
                    HStack {
                        Text(vm.comment.created.toDate().timeAgoDisplay()).font(.footnote)
                        Spacer()
                        Image(systemName: "heart").font(.footnote)
                        Text(vm.comment.likes.description).font(.footnote)
                    }
                }
                Spacer()
            
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(vm: CommentVM(comment: Comment(commentId: "dd", content: "Hello everyon", displayName: "myName", created: "2021-10-31T03:31:52Z", likes: 3)))
    }
}
