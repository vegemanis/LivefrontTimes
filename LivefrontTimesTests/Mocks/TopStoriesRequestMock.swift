import Foundation
@testable import LivefrontTimes

struct TopStoriesRequestMock: TopStoriesRequest {
    var apiRequest: APIRequest = APIRequestMock()
    var mockedDataFilename: String?
    var error: APIRequestError?

    func fetchStories() async throws -> [Story] {
        guard let mockRequest = apiRequest as? APIRequestMock else { return [] }

        mockRequest.error = error
        mockRequest.mockedDataFilename = mockedDataFilename 

        let data: TopStoriesData = try await mockRequest.request(urlString: "")
        return data.results.compactMap({ Story(data: $0) })
    }

}
