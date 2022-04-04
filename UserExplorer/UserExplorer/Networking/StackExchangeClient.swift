import Foundation

final class StackExchangeClient {
    private lazy var baseURL: URL = {
        return URL(string: "https://api.stackexchange.com/2.3/")!
    }()
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchModerators(with request: ModeratorRequest, page: Int,
                         completion: @escaping (Result<PagedModeratorResponse, DataResponseError>) -> Void) {
        // 1
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
        // 2
        let parameters = ["page": "\(page)"].merging(request.parameters, uniquingKeysWith: +)
        // 3
        let encodedURLRequest = urlRequest.encode(with: parameters)
        
        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            // 4
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
            else {
                completion(Result.failure(DataResponseError.network))
                return
            }
            
            // 5
            guard let decodedResponse = try? JSONDecoder().decode(PagedModeratorResponse.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            
            // 6
            completion(Result.success(decodedResponse))
        }).resume()
    }
    
}
