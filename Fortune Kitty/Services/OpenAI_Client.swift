//
//  OpenAI_Client.swift
//  Fortune Kitty
//
//  Created by Nicholas Nguyen on 9/4/24.
//

import Foundation

class OpenAI_Client {
    static let shared = OpenAI_Client()
    
    private init() {}
    
    func generateQuote(completion: @escaping (Result<String, Error>) -> Void) {
        guard let apiKey = APIKeyManager.shared.getAPIKey(for: "openAI") else {
            completion(.failure(NSError(domain: "APIKeyError", code: 1, userInfo: [NSLocalizedDescriptionKey: "OpenAI API key is unavailable."])))
            return
        }
        
        let randomTheme = DataProvider.shared.getRandomTheme()
        
        let prompt = """
        Generate a playful and absurd fortune cookie-style quote about \(randomTheme). Use an original quote attributed to a famous philosopher, then modify it to be silly, incoherent, and filled with a touch of illogical charm. When quoting single words or phrases inside the main quote, use single quotes (' ') instead of double quotes (" "). The entire quote must be surrounded by double quotation marks. Include subtle misspellings and playful language within the quote, but avoid simple errors like dropping a trailing 'e' or changing 'ce' to 'y'/'ay'. Avoid making the mispellings too egregious. The quote should resemble fake wisdom or quirky advice that is amusing and slightly confusing. The quote should stand alone and not reference or include any other quotes, avoiding any form of meta-quoting, such as 'in the words of', 'as <person> once said', or quoting someone quoting another person (or themselves). Keep the quote concise, under 15 words. The quote must be surrounded by double quotation marks, and the citation must be on a separate line, never as part of the quote. The format should be exactly: 

        "<quote surrounded by double quotation marks>"
        – <name>

        Ensure the citation always starts with an en dash "–" followed by a space and then the philosopher's name, with no quotation marks around the citation. Do not include phrases like "as this person once said" or any other meta-quoting. Ensure any misspelling of the philosopher's name is subtle, changing only two or three letters at most. The quote itself should be in double quotation marks, and the citation should not have any quotation marks.
        """
        
        let params: [String: Any] = [
            "model": "gpt-3.5-turbo-instruct",
            "prompt": prompt,
            "max_tokens": 60,
            "temperature": 1
        ]
        
        let headers = ["Content-Type": "application/json", "Authorization": "Bearer " + apiKey]
        
        guard let url = URL(string: "https://api.openai.com/v1/completions") else {
            completion(.failure(NSError(domain: "URLError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid URL."])))
            return
        }
        
        do {
            let body = try JSONSerialization.data(withJSONObject: params)
            
            NetworkManager.shared.performRequest(method: "POST", url: url, headers: headers, body: body) { result in
                switch result {
                    case .success(let data):
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let choices = json["choices"] as? [[String: Any]],
                               let text = choices.first?["text"] as? String {
                                completion(.success(text.trimmingCharacters(in: .whitespacesAndNewlines)))
                            }
                            
                            else {
                                completion(.failure(NSError(domain: "JSONError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON."])))
                            }
                        } catch {
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
