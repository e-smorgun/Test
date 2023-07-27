//
//  DataService.swift
//  Test
//
//  Created by Evgeny on 25.07.23.
//

import Foundation

class DataService {
    private func fetchModel<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Data is nil", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                print(result.self)
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    //MARK: - Запрос
    func getFlight(urlStr: String = "https://nu.vsepoka.ru/api/search?origin=MOW&destination=LED", completion: @escaping (Result<FlightResult, Error>) -> Void) {
        let url = URL(string: urlStr)!
        fetchModel(from: url, completion: completion)
    }
}
