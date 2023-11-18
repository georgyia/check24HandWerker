//
//  HandWerkerList.swift
//  check24
//
//  Created by Georgy Chomakhashvili on 18.11.23.
//

import SwiftUI

struct HandWerkersList: View {
    @State var selectedHandwerker: HandWerker? = nil
    @State var showHandWerkerDetail = false

    var body: some View {
        VStack(spacing: 25){
            ForEach(handWerkers){handWerker in
                ZStack{
                    Button(action: {
                        self.selectedHandwerker = handWerker
                        self.showHandWerkerDetail = true
                    }) {
                        HStack(spacing: 12){
                            Text("\(getIndex(handWerker: handWerker) + 1)")
                                .fontWeight(.semibold)
                            
                            Image(handWerker.handWerkerImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            
                            VStack(alignment: .leading, spacing: 10){
                                Text(handWerker.handWerkerName)
                                    .fontWeight(.semibold)
                                
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    Text("\(handWerker.rating, specifier: "%.1f")")
                                }
                                .font(.caption)
                                
                                HStack {
                                    Image(systemName: "location.circle.fill")
                                    Text("\(handWerker.distance, specifier: "%.2f") km")
                                }
                                .font(.caption)
                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                            
                            Button {
                                
                            } label: {
                                Image(systemName: handWerker.isLiked ? "suit.heart.fill" : "suit.heart")
                                    .font(.title3)
                                    .foregroundColor(handWerker.isLiked ? .red : .primary)
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "ellipsis")
                                    .font(.title3)
                                    .foregroundColor(.primary)
                            }
                        }
                    }.sheet(isPresented: $showHandWerkerDetail) {
                        if let handWerker = selectedHandwerker {
                            HandWerkerDetailView(handWerker: handWerker)
                        }
                    }
                }
            }
        }
        .padding(.top,15)
    }
    
    // MARK: Album Index
    func getIndex(handWerker: HandWerker)->Int{
        return handWerkers.firstIndex { HandWerker in
            HandWerker.id == handWerker.id
        } ?? 0
    }
}
