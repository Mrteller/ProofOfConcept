import Foundation

protocol ModeratorsViewModelDelegate: AnyObject {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}

final class ModeratorsViewModel {
    private weak var delegate: ModeratorsViewModelDelegate?
    
    private var moderators: [Moderator] = []
    private var currentPage = 1
    private var total = 0
    private var isFetchInProgress = false
    
    let client = StackExchangeClient()
    let request: ModeratorRequest
    
    init(request: ModeratorRequest, delegate: ModeratorsViewModelDelegate) {
        self.request = request
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return moderators.count
    }
    
    func moderator(at index: Int) -> Moderator {
        return moderators[index]
    }
    
    func fetchModerators() {
        // 1
        guard !isFetchInProgress && (totalCount != currentCount || totalCount == 0) else {
            return
        }
        
        // 2
        isFetchInProgress = true
        
        client.fetchModerators(with: request, page: currentPage) { result in
            switch result {
                // 3
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: error.reason)
                }
                // 4
            case .success(let response):
                DispatchQueue.main.async {
                    // 1
                    print("Fetched page: \(self.currentPage) of \(response.moderators.count) items")
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    // 2
                    self.total = response.total
                    self.moderators.append(contentsOf: response.moderators)
                    // 3
                    self.delegate?.onFetchCompleted()
                }
            }
        }
    }
    
    
}
