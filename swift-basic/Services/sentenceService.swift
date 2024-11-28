import Alamofire
import Foundation

class SentenceService {
    private let baseURL = "https://v1.jinrishici.com/all.json"
    // private let baseURL = "https://v1.hitokoto.cn/"
    
    func fetchSentence() async throws -> SentenceModel {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(baseURL)
                .responseDecodable(of: SentenceModel.self) { response in
                    switch response.result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}