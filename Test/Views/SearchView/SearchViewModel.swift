//
//  SearchViewModel.swift
//  Test
//
//  Created by Evgeny on 25.07.23.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var results = [Results]()
    @Published var errorMessage: String?
    @Published var isLoading: Bool = true
    @Published var origin: Origin?
    @Published var destination: Destination?
    
    var firstElementId: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let dataService = DataService()
    
    
    func loadData() {
        results.removeAll()
        isLoading = true
        
        dataService.getFlight { [weak self] result in
            switch result {
            case .success(let response):
                self?.results = response.results
                self?.results.sort(by: { $0.price.value < $1.price.value })
                self?.firstElementId = self?.results.first?.id
                self?.origin = response.origin
                self?.destination = response.destination
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
            
            self?.isLoading = false
        }
    }
    
    func repeatButtonAction() {
        errorMessage = ""
        loadData()
    }
}
