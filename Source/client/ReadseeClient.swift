import Foundation

public class ReadseeClient{
    
    public static func config(apiKey: String) -> Builder {
        return Builder(apiKey: apiKey)
    }

    public class Builder {
        
        init(apiKey: String) {
            UserDefaults.standard.set(apiKey, forKey: Constant.APIKEY_KEY)
            print("\(Constant.APIKEY_KEY): \(UserDefaults.standard.string(forKey: Constant.APIKEY_KEY) ?? "")")
        }
        
        public func createApi() -> ReadseeAPIProtocol {
            return ReadseeApi()
        }
    }
    
    public class ReadseeApi: ReadseeAPIProtocol {
        
        public func event(eventName: String, eventData: [String : Any]) {
            
        }
        
        public func profile(profileData: [String : Any]) {
            
        }
        
        public func logout() {
            profileUpdate(properties: [:])
        }
        
        private func getToken() -> String {
            return UserDefaults.standard.string(forKey: Constant.APIKEY_KEY) ?? ""
        }
        
        private func saveAnonymous(id: String) {
            UserDefaults.standard.set(id, forKey: Constant.ANONYMOUS_ID_KEY)
            print("\(Constant.ANONYMOUS_ID_KEY): \(UserDefaults.standard.string(forKey: Constant.ANONYMOUS_ID_KEY) ?? "")")
        }

        private func getAnonymousId() -> String {
            return UserDefaults.standard.string(forKey: Constant.ANONYMOUS_ID_KEY) ?? ""
        }
        
        private func saveDistinct(id: String) {
            UserDefaults.standard.set(id, forKey: Constant.DISTINCT_ID_KEY)
            print("\(Constant.DISTINCT_ID_KEY): \(UserDefaults.standard.string(forKey: Constant.DISTINCT_ID_KEY) ?? "")")
        }
        
        private func getDistinctId() -> String {
            return UserDefaults.standard.string(forKey: Constant.DISTINCT_ID_KEY) ?? ""
        }
        
        private func profileUpdate(properties: [String: Any]) {
            guard let url = URL(string: Constant.BASE_URL_PROFILE) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(getToken())", forHTTPHeaderField: "Authorization")
            request.httpBody = try? JSONSerialization.data(withJSONObject: properties)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }
                    
                guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid response")
                    return
                }
                    
                do {
                    if let data = data {
                        // Deserialize the JSON data into a dictionary
                        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] else {
                                print("Error: Failed to deserialize JSON")
                                return
                            }
                        if (json["_$distinct_id"] != nil) {
                            self.saveDistinct(id: json["_$distinct_id"]!)
                        }
                        if (json["_$anonymous_id"] != nil) {
                            self.saveAnonymous(id: json["_$anonymous_id"]!)
                        }
                    } else {
                        print("asawau")
                    }
                } catch {
                    
                }
            }
            task.resume()
        }
    }
}

