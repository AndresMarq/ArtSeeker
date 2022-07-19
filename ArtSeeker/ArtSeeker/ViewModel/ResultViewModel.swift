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
    
    // Vars for page number change and filtering by keyword
    private var resultPageNumber = 1
    // The number 10 below is just a placeholder
    private var resultTotalNumberOfPages = 10
    private var filterKeyword = ""
    
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
            let resultPageNumberStr = String(resultPageNumber)
            service.changeResultPageNumber(pageNumber: resultPageNumberStr)
            
            // Filter by keyword
            service.filterByKeyword(keyword: filterKeyword)
            
            let results = try await service.fetchResults()
            
            // Discard records without Images if there are still any (Also checked in Network -> URL)
            // Further filters required as the API sometimes shows records with empty or nil image arrays as having images
            let records = results.records.filter { $0.imagecount > 0 && $0.images != nil && $0.images?.isEmpty == false}
            
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
        let newIndex = resultPageNumber + pageNumberChange
        
        if newIndex <= resultTotalNumberOfPages {
            resultPageNumber = newIndex
            await getResult()
        }
    }
    
    // Implement keyword search in Model
    func applySearchFilter(keyword: String) async {
        
        // Ensure keyword is single word, if not discard all other ones
        filterKeyword = keyword.components(separatedBy: " ").first ?? ""
        await getResult()
    }
}
