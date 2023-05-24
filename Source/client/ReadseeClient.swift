import Foundation

public class ReadseeClient{

    var tokenName = "token"
    let anonymousName = "anonymousId"
    let distintName = "distinctId"
    let api = "https://apista.readsee.io/v1/track/profile"

    public init(token: String) {
        UserDefaults.standard.set(token, forKey: tokenName)
        print("\(tokenName): \(UserDefaults.standard.string(forKey: tokenName) ?? "")")
        register()
    }
    
    private func getToken() -> String {
        return UserDefaults.standard.string(forKey: tokenName) ?? ""
    }
    
    private func saveAnonymous(id: String) {
        UserDefaults.standard.set(id, forKey: anonymousName)
        print("\(anonymousName): \(UserDefaults.standard.string(forKey: anonymousName) ?? "")")
    }

    private func getAnonymousId() -> String {
        return UserDefaults.standard.string(forKey: anonymousName) ?? ""
    }
    
    private func saveDistinct(id: String) {
        UserDefaults.standard.set(id, forKey: distintName)
        print("\(distintName): \(UserDefaults.standard.string(forKey: distintName) ?? "")")
    }
    
    private func getDistinctId() -> String {
        return UserDefaults.standard.string(forKey: distintName) ?? ""
    }
    
    func register() {
        if (!getAnonymousId().isEmpty && !getDistinctId().isEmpty) {
            print("anonymous: \(getAnonymousId()), distinct: \(getDistinctId())")
            return
        }
        guard let url = URL(string: api) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.setValue("Bearer \(getToken())", forHTTPHeaderField: "Authorization")
        
        let params = ["asdf": "", "token": getToken()]
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        
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
