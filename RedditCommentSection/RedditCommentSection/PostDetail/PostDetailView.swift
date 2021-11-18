//
//  PostDetailView.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 07/11/2021.
//

import SwiftUI

struct PostDetailView: View {
    @ObservedObject var vm: PostDetailVM
    @State var comment: String = ""
    
    var body: some View {
        VStack(spacing: 0){
            ScrollView {
                Divider()
                PostView(vm: vm.postVm).padding()
                Divider()
                if self.vm.loading {
                    ProgressView().progressViewStyle(.circular)
                } else {
                    LazyVStack(spacing:0){
                        ForEach(vm.commentSection, id: \.id){ comment in
                            if comment.padding == 1 { Rectangle().frame(height: 10).foregroundColor(Color.gray.opacity(0.2))
                                Divider()
                            }
                            CommentView(postDetailVM: vm, vm: comment)
                        }
                    }.listRowInsets(EdgeInsets())
                }
            }.listStyle(PlainListStyle())
            
            VStack(spacing: 0){
                Divider()
                if vm.currentParentReply != nil {
                    HStack{
                        Text("Replying to: " + vm.currentParentReply!.comment.displayName)
                        Spacer()
                        Button(action: {
                            withAnimation{self.vm.currentParentReply = nil}
                        }){
                            Image(systemName: "xmark.circle.fill")
                        }
                    }.padding(.horizontal, 5)
                        .padding()
                        .font(.footnote)
                }
                HStack {
                    ZStack{
                        TextEditor(text: $comment)
                        Text(comment).opacity(0).padding()
                    }.shadow(radius: 1)
                        .buttonBorderShape(ButtonBorderShape.capsule)
                        .cornerRadius(10)
                        .ignoresSafeArea(.keyboard,edges: .bottom)
                        .shadow(radius: 2)
                        .frame(height: 60)
                    Button("Send"){
                        self.vm.sendReply(commentText: comment)
                        self.comment = ""
                    }
                }.padding()
                
            }.background(Color.primary.opacity(0.1))
            
        }
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
