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
        case success(data: [Result.Record])
        case failed(error: Error)
    }
    
    @Published private(set) var state: State = .na
    @Published var hasError: Bool = false
    
    private var service: Network
    private var resultPageNumber = 2
    // The number 10 below is just a placeholder
    private var resultTotalNumberOfPages = 10
    
    init(service: Network) {
        self.service = service
    }
    
    // MARK: - ViewModel Fetches Result from Service
    func getResult() async {
        self.state = .loading
        self.hasError = false
        
        do {
            // Apply Page Number & Filter
            // Page Number
            let resultPageNumberStr = String (resultPageNumber)
            service.changeResultPageNumber(pageNumber: resultPageNumberStr)
            
            // Filter by keyword
            //Network.keywordFilterURL = "keyword="
            
            let results = try await service.fetchResults()
            // Discard records without Images if there are still any (Also checked in Network -> URL)
            let records = results.records.filter { $0.imagecount > 0 }
            // Pass filtered data to View
            self.state = .success(data: records)
            // Update total number of pages in result
            resultTotalNumberOfPages = results.info.pages
        } catch {
            self.state = .failed(error: error)
            self.hasError = true
        }
    }
    
    // MARK: - User Intent
    
    // Page number change to next "+1" or prev "-1"
    func getPageNumber(pageNumberChange: Int) async {
        // Change page number if available
        if pageNumberChange == +1 {
            if resultPageNumber + 1 <= resultTotalNumberOfPages {
                resultPageNumber += 1
                await getResult()
            }
        } else if pageNumberChange == -1 {
            if resultPageNumber > 1 {
                resultPageNumber -= 1
                await getResult()
            }
        }
    }
}
