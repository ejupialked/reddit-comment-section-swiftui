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
            }
            Spacer()
        }.padding()
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(vm: PostVM(post: Post(postid: "test", content: "Hello everyone", displayName: "Alked")))
    }
}
