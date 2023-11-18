//
//  Home.swift
//  check24
//
//  Created by Georgy Chomakhashvili on 18.11.23.
//


import SwiftUI
import MapKit

// ViewModel for the Home view
class ViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.2048, longitude: 55.2708), latitudinalMeters: 10000, longitudinalMeters: 10000)
    // Sample HandWerker data
    var handWerkers: [HandWerker] = [
        HandWerker(handWerkerName: "Handwerker1", handWerkerImage: "Handwerker", rating: Double.random(in: 0...5), distance: Double.random(in: 0...10)),
        HandWerker(handWerkerName: "Handwerker2", handWerkerImage: "Handwerker", isLiked: true, rating: Double.random(in: 0...5), distance: Double.random(in: 0...10)),
        HandWerker(handWerkerName: "Handwerker3", handWerkerImage: "Handwerker", rating: Double.random(in: 0...5), distance: Double.random(in: 0...10)),
        HandWerker(handWerkerName: "Handwerker4", handWerkerImage: "Handwerker", rating: Double.random(in: 0...5), distance: Double.random(in: 0...10)),
        HandWerker(handWerkerName: "Handwerker5", handWerkerImage: "Handwerker", isLiked: true, rating: Double.random(in: 0...5), distance: Double.random(in: 0...10)),
        HandWerker(handWerkerName: "Handwerker6", handWerkerImage: "Handwerker", rating: Double.random(in: 0...5), distance: Double.random(in: 0...10)),
        HandWerker(handWerkerName: "Handwerker7", handWerkerImage: "Handwerker", rating: Double.random(in: 0...5), distance: Double.random(in: 0...10)),
        HandWerker(handWerkerName: "Handwerker8", handWerkerImage: "Handwerker", isLiked: true, rating: Double.random(in: 0...5), distance: Double.random(in: 0...10)),
        HandWerker(handWerkerName: "Handwerker9", handWerkerImage: "Handwerker", rating: Double.random(in: 0...5), distance: Double.random(in: 0...10)),
    ]

}

struct Home: View {
    @State var showAnotherSheet: Bool = false
        @StateObject var viewModel = ViewModel()
        @State var selectedHandWerker: HandWerker? = nil
        @State var showHandWerkerDetail = false
    
    var body: some View {
        NavigationView {
            ZStack{
                // Map view
                Map(coordinateRegion: $viewModel.region)
                    .ignoresSafeArea()
                    .overlay(alignment: .topTrailing, content: {
                        // Settings button
                        Button {
                            showAnotherSheet.toggle()
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .font(.title2)
                        }
                        .padding()
                    })
                // MARK: Building Sheet UI
                // Since We Always Need Bottom Sheet At Bottom Setting to True By Default
                    .bottomSheet(presentationDetents: [.medium,.large,.height(70)], isPresented: .constant(true), sheetCornerRadius: 20,isTransparentBG: true) {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 15){
                                TextField("Search Handwerker", text: .constant(""))
                                    .padding(.vertical,10)
                                    .padding(.horizontal)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(.ultraThickMaterial)
                                    }
                                
                                // Handwerkers List View
                                HandWerkersList()
                            }
                            .padding()
                            .padding(.top)
                        }
                        .background(content: {
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .ignoresSafeArea()
                        })
                        .sheet(isPresented: $showAnotherSheet) {
                            Text("Hi Setting 👋")
                        }
                    } onDismiss: {}
            }
        }
    }
    
    
    @ViewBuilder
    func HandWerkersList()->some View{
        VStack(spacing: 25){
            ForEach(Array(viewModel.handWerkers.enumerated()), id: \.element.id) { index, handWerker in
                ZStack{
                    Button(action: {
                        self.selectedHandWerker = handWerker
                        self.showHandWerkerDetail = true
                    }) {
                        // HandWerker item view
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
                                viewModel.handWerkers[index].isLiked.toggle()
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
                        if let handWerker = selectedHandWerker {
                            HandWerkerDetailView(handWerker: handWerker)
                        }
                    }
                }
            }
        }
        .padding(.top,15)
    }
    
    // Function to get index of a HandWerker
    func getIndex(handWerker: HandWerker)->Int{
        return viewModel.handWerkers.firstIndex { HandWerker in
            HandWerker.id == handWerker.id
        } ?? 0
    }
}



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
