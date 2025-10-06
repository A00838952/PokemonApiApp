//
//  ContentView.swift
//  Foto
//
//  Created by Rodrigo González de la Garza on 01/10/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var photoVM = PhotoViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if photoVM.isLoading {
                    ProgressView()
                       
                } else if let errorMessage = photoVM.errorMessage {
                    
                    VStack() {
                        
                        Text(errorMessage)
                            .font(.headline)
                            
                        
                        Button("Try Again") {
                            Task {
                                await photoVM.retryLoading()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                  
                } else {
                    
                    List {
                        ForEach(photoVM.arrPhotos) { pokemon in
                            NavigationLink{
                                VStack{
                                    HStack {
                                        Text("\(pokemon.id)")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.secondary)
                                        
                                        Text(pokemon.name.capitalized)
                                            .font(Font.title)
                                            .fontWeight(.bold)
                                    }
                                    if let imageUrl = pokemon.sprites.front_default {
                                        AsyncImage(url: URL(string: imageUrl)) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                    VStack(alignment: .center) {
                                        Text("Type(s):")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                        
                                        HStack {
                                            ForEach(pokemon.types, id: \.type.name) { pokemonType in
                                                Text(pokemonType.type.name.capitalized)
                                                    .padding()
                                                    .background(Color.blue.opacity(0.2))
                                                    
                                                    .fontWeight(.bold)
                                                    .cornerRadius(20)
                                            }
                                        }
                                    }
                                    
                                }
                            } label: {
                                PhotoView(pokemon: pokemon)
                             
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pokemon")
            .task {
                await photoVM.getPokemon()
            }
        }
    }
}

#Preview {
    ContentView()
}
