import Foundation

/// The API call to fetch food items from Spoonacular library.
/// This Class contains one method : searchFood
final class APIService {
    static let shared = APIService()
    private let baseURL = "https://api.spoonacular.com/recipes/"
    private let apiKey = "16c4468726e0410db5a99894ce76716e"
    
    /// searchFood is a method of the final class APIService which fetches data from the Spoonacular API.
    /// - Parameters:
    ///   - query: query is the search string which is sent to the API.
    ///   - completion: completion is an @escaping parameter which stores the result if the API call is a success, and stores the error if the API call is a failure.
    func searchFood(query: String, completion: @escaping (Result<SearchResults, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)complexSearch?query=\(query)&apiKey=\(apiKey)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received from server"])))
                return
            }
            
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                completion(.success(searchResults))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
