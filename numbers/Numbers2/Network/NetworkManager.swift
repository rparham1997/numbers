//
//  NetworkManager.swift
//  Numbers2
//
//  
//
//

import Foundation

/// This will call the API.
struct NetworkManager {
    
    // Use the type name NetworkHandler for the closure that accepts a string.
    typealias NetworkHandler = (Data) -> Void
    
    // MARK: - Properties
    private let session = URLSession.shared
    // Part of the header request.
    private let host: String = "numbersapi.p.rapidapi.com"
    // API Key is necessary for the API to know who's fetching the data.
    private let apiKey: String = "8c566b5c36msh863cffda667bca5p1f7124jsn58d842784c75"
    
    // MARK: - Public Methods
    // Argument completionHandler accepts a function with a string argument and returns nothing.
    func call(using number: Int, completionHandler: @escaping NetworkHandler) {
        guard let url = validUrl(using: number) else {
            print("Not a valid URL.")
            return
        }
        let request = createRequest(with: url)
        let task = createDataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }
    
    // MARK: - Private Methods
    private func validUrl(using number: Int) -> URL? {
        return URL(string: "https://numbersapi.p.rapidapi.com/\(number)/math?fragment=true&json=true")
    }
    
    private func createRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue(host, forHTTPHeaderField: "X-RapidAPI-Host")
        request.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        // Tells it to GET data. Other options are POST, PUT, DELETE
        request.httpMethod = "GET"
        return request
    }
    
    private func createDataTask(with request: URLRequest, completionHandler: @escaping NetworkHandler) -> URLSessionDataTask {
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("There was an error.")
                return
            }
            guard let data = data else {
                print("Data cannot be unwrapped.")
                return
            }
            
            // We need to convert the data object, into a readable JSON format.
            // This is only necessary if you will get the data from the json object yourself.
//            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                  // If you were to do it like this, this would SHOULD NOT be in the network class, pass the responsiblity to another class.
//                let fact = NumberFactModel()
//                fact.number = json["number"] as? Int ?? 0
//                fact.type = json["type"] as? String ?? ""
//                fact.description = json["text"] as? String ?? ""
//                print(json)
//            }
            
            // We are passing back the data type back to the view controller, or whoever called it.
            completionHandler(data)
        }
    }
}
