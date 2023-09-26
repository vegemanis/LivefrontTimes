import Foundation
@testable import LivefrontTimes

struct NetworkSessionMock : NetworkSession {
    var response: URLResponse = URLResponse()
    var data: Data = Data()
    var error: Error?

    func makeRequest(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        return (data, response)
    }
}
