//
//  PostView.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 04/11/2021.
//

import SwiftUI

struct PostView: View {
    
    @ObservedObject var vm: PostVM
    
    var body: some View {
        HStack{
            VStack {
                HStack {
                    Text(vm.post.displayName).font(.headline.bold())
                Spacer()
                }
                HStack {
                    Text(vm.post.content)
                    Spacer()
                }
                HStack {
                    Text(vm.post.created.toDate().timeAgoDisplay())
                    Spacer()
                    Image(systemName: "heart")
                    Text(vm.post.likes.description)
                }.padding(.top, 5)
            }
            Spacer()
        }.padding(5)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(vm: PostVM(post: Post(postId: "test", content: "Hello everyone", displayName: "Alked", created: "2021-09-18T11:21:35Z", likes: 3)))
    }
}
