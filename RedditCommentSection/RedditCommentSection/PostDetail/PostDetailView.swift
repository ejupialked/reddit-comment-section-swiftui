//
//  PostDetailView.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 07/11/2021.
//

import SwiftUI

struct PostDetailView: View {
    @ObservedObject var vm: PostVM

    var body: some View {
        ListItem {
            ForEach(1..<10){ i in
                if (i == 1){  PostView(vm: vm) } else { EmptyView()}
                
                Text("hello")
                
            }
    
        }.listStyle(PlainListStyle())
        .navigationTitle(Text("Post Detail"))
        .navigationBarTitleDisplayMode(.inline)

    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(vm: PostVM(post: Post(postId: "test", content: "Hello everyone", displayName: "Alked", created: "2021-09-18T11:21:35Z", likes: 3)))
    }
}
