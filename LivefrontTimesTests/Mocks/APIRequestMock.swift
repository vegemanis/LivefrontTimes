@testable import LivefrontTimes
import XCTest

final class APIRequestMock: APIRequest {
    var urlStringRequested: String?
    var mockedDataFilename: String?
    var error: APIRequestError?

    func request<T>(urlString: String) async throws -> T where T: Decodable {
        urlStringRequested = urlString
        if let error = error {
            throw error
        }
        return try getObject(filename: mockedDataFilename ?? "")
    }

    func getObject<T>(filename: String) throws -> T where T: Decodable {
        let jsonData = getData(filename: filename)
        return try JSONDecoder().decode(T.self, from: jsonData)
    }

    func getPath(to filename: String) -> String {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json") else {
            fatalError("\(filename) not found")
        }

        return pathString
    }

    func getData(filename: String) -> Data {
        let pathString = getPath(to: filename)
        let url = URL(filePath: pathString)
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Unable to convert file contents to Data")
        }

        return data
    }
}

