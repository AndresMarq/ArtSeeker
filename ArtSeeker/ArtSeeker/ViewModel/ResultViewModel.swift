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
    // Stores whether last action was to move to the next page (1) or to the previous one (-1)
    private var pageNumberChanged = 1
    
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
            
            // Define empty array to store the records fetched
            var records = [Result.Record]()
            
            // Ensures that results after filtering return at least four records
            while records.count < 4 {
                let results = try await service.fetchResults()
                
                // Discard records without Images if there are still any (Also checked in Network -> URL)
                // Further filters required as the API sometimes shows records with empty or nil image arrays as having images
                records = results.records.filter { $0.imageCount > 0 && $0.images != nil && $0.images?.isEmpty == false}
                
                // Update total number of pages in result
                resultTotalNumberOfPages = results.info.pages
                
                // If filtering by keyword in UI, we must break from the while loop
                if !filterKeyword.isEmpty {
                    break
                }
                
                // If we still don't have enough records change page prior to next iteration
                if records.count < 4 {
                    let newPage = resultPageNumber + pageNumberChanged
                    
                    // Verify new page is still within range
                    if newPage >= 1 && newPage <= resultTotalNumberOfPages {
                        resultPageNumber = newPage
                    }
                }
            }
            
            // Pass filtered data to View
            self.state = .success(data: records)
            
        } catch {
            self.state = .failed(error: error)
            self.hasError = true
        }
    }
    
    // MARK: - User Intent
    
    // Page number change to next "+1" or prev "-1"
    func getPageNumber(pageNumberChange: Int) async {
        // Update last pageNumberChanged value in ViewModel
        pageNumberChanged = pageNumberChange
        
        // Change page number if available
        let newIndex = resultPageNumber + pageNumberChange
        
        if newIndex >= 1 && newIndex <= resultTotalNumberOfPages {
            resultPageNumber = newIndex
            await getResult()
        }
    }
    
    // Implement keyword search in Model
    func applySearchFilter(keyword: String) async {
        
        // Ensure keyword is single word, if not discard all other ones
        filterKeyword = keyword.components(separatedBy: " ").first ?? ""
        
        // Reset page number
        resultPageNumber = 1
        
        await getResult()
    }
}
