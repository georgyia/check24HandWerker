//
//  HandWerkerDetailView.swift
//  check24
//
//  Created by Georgy Chomakhashvili on 18.11.23.
//

import SwiftUI

// Comment structure for HandWerker
struct Comment {
    var text: String
    var name: String
    var profilePicture: String
}

// Detail view for a HandWerker
struct HandWerkerDetailView: View {
    var handWerker: HandWerker
    @State private var commentText: String = ""
    @State private var showHandwerkerDetail = false
    @State private var comments: [Comment] = []
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    // HandWerker image
                    Image(handWerker.handWerkerImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                    
                    // HandWerker name
                    Text(handWerker.handWerkerName)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // HandWerker rating
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(handWerker.rating, specifier: "%.1f")")
                    }
                    .font(.caption)
                    
                    // HandWerker distance
                    HStack {
                        Image(systemName: "location.circle.fill")
                        Text("\(handWerker.distance, specifier: "%.2f") km")
                    }
                    .font(.caption)
                    
                    // Contact and View Details buttons
                    HStack {
                        Button(action: {
                            // Handle contact action here
                        }) {
                            Text("Contact")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }.sheet(isPresented: $showHandwerkerDetail) {
                            // Replace this with the view you want to navigate to
                            Text("HandWerker Details")
                        }
                        
                        Button(action: {
                            showHandwerkerDetail = true
                        }) {
                            Text("View Details")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    
                    // Comments section
                    Text("Comments")
                        .font(.headline)
                        .padding(.top)
                    
                    // Comment text field
                    TextField("Add a comment...", text: $commentText, onCommit: addComment)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    
                    // Comment list
                    Section(header: Text("")) {
                        ForEach(comments, id: \.text) { comment in
                            HStack {
                                Image(comment.profilePicture)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                VStack(alignment: .leading) {
                                    Text(comment.name)
                                        .font(.headline)
                                        .padding(.top, 20)
                                    Text(comment.text)
                                        .padding()
                                        .padding(.top, -15)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .cornerRadius(0)
                                }
                            }
                            .padding(.bottom, -5)
                        }
                    }
                }
            }
        }
        .padding()
    }
    func addComment() {
        comments.append(Comment(text: commentText, name: "Georgy Chomakhashvili", profilePicture: "ProfilePicture"))
        commentText = ""
    }
}
