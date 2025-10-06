//
//  PhotoViewModel.swift
//  Foto
//
//  Created by Rodrigo González de la Garza on 01/10/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class PhotoViewModel: ObservableObject {
    @Published var arrPhotos = [Photo]()
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    func getPokemon() async {
        isLoading = true
        errorMessage = nil
        arrPhotos.removeAll()
        
        do {
            // Fetch 3 random Pokemon
            for _ in 1...3 {
                let num = Int.random(in: 1...1025)
                
                // url
                guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(num)/") else {
                    throw NSError(domain: "Invalid request", code: 0)
                }
                
                // request
                var urlRequest = URLRequest(url: url)
                urlRequest.timeoutInterval = 10.0
                
                do {
                    // llamar al http
                    let (data, response) = try await URLSession.shared.data(for: urlRequest)
                    
                
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw NSError(domain: "Server error (0)", code: 0)
                    }
                    
                   
                    guard httpResponse.statusCode == 200 else {
                        throw NSError(domain: "Server error (\(httpResponse.statusCode))", code: httpResponse.statusCode)
                    }
                    
                    //decode JSON
                    do {
                        let result = try JSONDecoder().decode(Photo.self, from: data)
                        arrPhotos.append(result)
                    } catch {
                        throw NSError(domain: "Unable to load data", code: 0)
                    }
                    
                } catch let urlError as URLError {
                    //  network errors
                    switch urlError.code {
                    case .notConnectedToInternet, .networkConnectionLost:
                        throw NSError(domain: "No connection. Please check your internet and try again", code: 0)
                    case .timedOut:
                        throw NSError(domain: "Server error (408)", code: 408)
                    default:
                        throw NSError(domain: "Something went wrong", code: 0)
                    }
                }
            }
            
         
            isLoading = false
            
        } catch let nsError as NSError {
            
            self.errorMessage = nsError.domain
            isLoading = false
        } catch {
            
            self.errorMessage = "Something went wrong. Please try again"
            isLoading = false
        }
    }
    
    // retry loading
    func retryLoading() async {
        await getPokemon()
    }
}
