//
//  CommentVM.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 07/11/2021.
//

import Foundation
import SwiftUI

class CommentVM: ObservableObject {
    @Published var comment: Comment
    
    init(comment: Comment){
        self.comment = comment;
    }
}
