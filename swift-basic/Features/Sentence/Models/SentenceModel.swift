import Foundation

struct SentenceModel: Codable {
    let content: String
    let origin: String  
    let author: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case content
        case origin
        case author 
        case category
    }
}
