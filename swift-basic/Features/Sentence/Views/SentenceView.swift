import SwiftUI

// MARK: - 父组件
struct SentenceView: View {
    @StateObject private var viewModel = SentenceViewModel.shared

    var body: some View {
        VStack(spacing: 20) {
            LoadingView(isLoading: viewModel.isLoading)
            ContentView(data: viewModel.sentenceData)
            RefreshButton(isLoading: viewModel.isLoading) {
                Task {
                    await viewModel.fetchSentence()
                }
            }
        }
        .padding(.horizontal, 16)
        .task {
            await viewModel.fetchSentence()
        }
    }
}

// MARK: - 子组件
private struct LoadingView: View {
    let isLoading: Bool

    var body: some View {
        if isLoading {
            ProgressView()
        }
    }
}

private struct ContentView: View {
    let data: SentenceViewModel.sentenceDisplayData

    var body: some View {
        VStack(spacing: 12) {
            QuoteView(text: data.sentence)
            Divider()
                .padding(.horizontal, 12)
            InfoView(data: data)
        }
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)
        )
        .padding(.horizontal, 12)
    }
}

private struct QuoteView: View {
    let text: String

    var body: some View {
        ScrollView {
            Text(text)
                .font(.system(size: 20, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .multilineTextAlignment(.center)
                .lineSpacing(6)
        }
        .frame(minHeight: 50, maxHeight: 100)
    }
}

private struct InfoView: View {
    let data: SentenceViewModel.sentenceDisplayData

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                InfoRow(title: "诗名", content: data.from)
                InfoRow(title: "作者", content: data.creator) 
                InfoRow(title: "分类", content: data.type)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .frame(maxHeight: 150)
    }
}

private struct InfoRow: View {
    let title: String
    let content: String

    var body: some View {
        if !content.isEmpty {
            HStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                Text(content)
                    .font(.system(size: 15))
            }
        }
    }
}

private struct RefreshButton: View {
    let isLoading: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "arrow.clockwise")
                Text("换一条")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(isLoading ? Color.gray.opacity(0.8) : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .disabled(isLoading)
        .animation(.easeInOut, value: isLoading)
    }
}

// new
#Preview("古诗") {
    SentenceView()
}

// old
// struct sentenceView_Previews: PreviewProvider {
//     static var previews: some View {
//         sentenceView()
//     }
// }
