//
//  API.swift
//  Word Finder
//
//  Created by Mert Ozseven on 7.06.2024.
//

import Foundation

// MARK: - RequestMethod
enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

// MARK: - Router
enum Router {
    case search(word: String)
    case synonyms(word: String)
    
    var path: String {
        switch self {
        case .search(let word):
            return "\(word)"
        case .synonyms(let word):
            return "words?rel_syn=\(word)"
        }
    }
    
    var baseURL: String {
        switch self {
        case .search:
            return Constants.baseURL
        case .synonyms:
            return Constants.datamuseBaseURL
        }
    }
}

// MARK: - API
final class API {
    
    static let shared: API = {
        let instance = API()
        return instance
    }()
    
    private var service: NetworkService
    
    init(service: NetworkService = NetworkManager()) {
        self.service = service
    }
}

extension API {
    
    func prepareURLRequestFor(
        router: Router,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        method: RequestMethod = .get
    ) -> URLRequest? {
        
        let urlString = router.baseURL + router.path
        guard let url = URL(string: urlString) else { return nil }
        
        var request = URLRequest(url: url)
        
        if let params = parameters {
            
            if method == .get {
                guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                    return nil
                }
                
                let queryItems = params.map {
                    URLQueryItem(name: $0.key, value: String(describing: $0.value))
                }
                
                urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
                
                guard let newUrl = urlComponents.url else { return nil }
                
                request = URLRequest(url: newUrl)
            } else {
                let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                request.httpBody = jsonData
            }
        }
        
        request.httpMethod = method.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let requestHeaders = headers {
            for (field, value) in requestHeaders {
                request.setValue(value, forHTTPHeaderField: field)
            }
        }
        
        return request
    }
    
    func executeRequestFor<T: Decodable> (
        router: Router,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        method: RequestMethod = .get,
        completion: @escaping(Result<[T], NetworkError>) -> Void
    ) {
        
        if let urlRequest = prepareURLRequestFor(
            router: router,
            parameters: parameters,
            headers: headers,
            method: method
        ) {
            service.execute(urlRequest: urlRequest, completion: completion)
        } else {
            completion(.failure(.invalidRequest))
        }
        
    }
    
}
