//
//  ResultViewModel.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-07-02.
//

import Foundation

@MainActor
class ResultViewModel: ObservableObject {
    
    enum State {
        case na
        case loading
        case success(data: Result)
        case failed(error: Error)
    }
    
    @Published private(set) var state: State = .na
    @Published var hasError: Bool = false
    
    private let service: Network
    
    init(service: Network) {
        self.service = service
    }
    
    func getResult() async {
        self.state = .loading
        self.hasError = false
        
        do {
            let results = try await service.fetchResults()
            self.state = .success(data: results)
        } catch {
            self.state = .failed(error: error)
            self.hasError = true
        }
    }
}
