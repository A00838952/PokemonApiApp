//
//  PhotoView.swift
//  Foto
//
//  Created by Rodrigo González de la Garza on 01/10/25.
//

import SwiftUI

struct PhotoView: View {
    let pokemon: Photo
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("\(pokemon.id)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    
                    Text(pokemon.name.capitalized)
                        .font(.title2)
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
                    .frame(height: 80)
                }
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    PhotoView(pokemon: Photo(id: 25, name: "pikachu", types: [PokemonType(type: TypeInfo(name: "electric"))], sprites: PokemonSprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png")))
}
