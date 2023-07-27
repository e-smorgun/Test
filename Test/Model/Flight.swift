//
//  Flight.swift
//  Test
//
//  Created by Evgeny on 25.07.23.
//

import Foundation

struct FlightResult: Codable {
    let passengers_count: Int
    let origin: Origin
    let destination: Destination
    let results: [Results]
}

struct Origin: Codable {
    let iata: String
    let name: String
}

struct Destination: Codable {
    let iata: String
    let name: String
}

struct Results: Codable, Identifiable {
    let id: String
    let departure_date_time: String
    let arrival_date_time: String
    let price: Price
    let airline: String
    let available_tickets_count: Int
}

struct Price: Codable {
    let currency: String
    let value: Int
}
