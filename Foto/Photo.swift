//
//  Photo.swift
//  Foto
//
//  Created by Rodrigo González de la Garza on 01/10/25.
//

import Foundation

struct Photo : Decodable, Identifiable{
    var id: Int
    var name: String
    var types: [PokemonType]
    var sprites: PokemonSprites
    
    enum CodingKeys: String, CodingKey {
        case id, name, types, sprites
    }
}

struct PokemonType: Decodable {
    var type: TypeInfo
}

struct TypeInfo: Decodable {
    var name: String
}

struct PokemonSprites: Decodable {
    var front_default: String?
}
