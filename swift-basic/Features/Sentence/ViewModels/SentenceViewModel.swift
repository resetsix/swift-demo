import Foundation
import Alamofire
import Combine

class SentenceViewModel: ObservableObject {
    static let shared = SentenceViewModel()
    
    @Published private(set) var sentenceData = sentenceDisplayData()
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    
    private let sentenceService = SentenceService()
    
    struct sentenceDisplayData {
        var sentence = "请换一条..."
        var from = ""
        var creator = ""
        var fromWho = ""
        var type = ""
        
        static var empty: sentenceDisplayData {
            sentenceDisplayData()
        }
    }
    
    @MainActor
    func fetchSentence() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let data = try await sentenceService.fetchSentence()
            sentenceData = convertToDisplayData(data)
        } catch {
            errorMessage = error.localizedDescription
            sentenceData = .empty
        }
        
        isLoading = false
    }
    
    private func convertToDisplayData(_ model: SentenceModel) -> sentenceDisplayData {
        return sentenceDisplayData(
            sentence: model.content,
            from: model.origin,
            creator: model.author,
            fromWho: "",
            type: model.category
        )
    }
}
