@testable import LivefrontTimes
import XCTest

final class DefaultAPIRequestTests: XCTestCase {
    let exampleUrlString = "https://example.com"

    /// Tests data mismatch is thrown.
    func testDataMismatch() async throws {
        let data = try XCTUnwrap("{ }".data(using: .utf8))
        let url = try XCTUnwrap(URL(string: exampleUrlString))
        let response = try XCTUnwrap(
            HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )
        )

        let mock = NetworkSessionMock(response: response, data: data)
        let subject = DefaultAPIRequest(networkSession: mock)

        do {
            let _: String = try await subject.request(urlString: exampleUrlString)
            XCTFail("Should have throw exception")
        } catch APIRequestError.dataObjectMismatch( _) {
            // Success
        } catch {
            XCTFail("Should have caught exception earlier \(error)")
        }
    }

    /// Tests invalid response type (when the response is not an HTTPURLResponse).
    func testInvalidResponseType() async {
        let subject = DefaultAPIRequest(networkSession: NetworkSessionMock(response: URLResponse()))

        do {
            let _: String = try await subject.request(urlString: exampleUrlString)
            XCTFail("Should have throw exception")
        } catch APIRequestError.invalidResponseType {
            // Success
        } catch {
            XCTFail("Should have caught exception earlier \(error)")
        }
    }

    /// Tests invalid url is thrown.
    func testInvalidURL() async {
        let subject = DefaultAPIRequest(networkSession: NetworkSessionMock())

        do {
            let _: String = try await subject.request(urlString: "")
            XCTFail("Should have throw exception")
        } catch APIRequestError.invalidURL {
            // Success
        } catch {
            XCTFail("Should have caught exception earlier \(error)")
        }
    }

    /// Tests error is thrown when the response status code is non-2xx.
    func testOtherStatusCodeError() async throws {
        let url = try XCTUnwrap(URL(string: exampleUrlString))
        let response = try XCTUnwrap(
            HTTPURLResponse(
                url: url,
                statusCode: 401,
                httpVersion: nil,
                headerFields: nil
            )
        )

        let mock = NetworkSessionMock(response: response)
        let subject = DefaultAPIRequest(networkSession: mock)

        do {
            let _: String = try await subject.request(urlString: exampleUrlString)
            XCTFail("Should have throw exception")
        } catch APIRequestError.otherStatusCodeError(let code) {
            // Success
            XCTAssertEqual(code, response.statusCode)
        } catch {
            XCTFail("Should have caught exception earlier \(error)")
        }
    }

    /// Tests when request throws an error.
    func testRequestError() async throws {
        let thrownError = APIRequestError.invalidURL
        let mock = NetworkSessionMock(error: thrownError)
        let subject = DefaultAPIRequest(networkSession: mock)

        do {
            let _: String = try await subject.request(urlString: exampleUrlString)
            XCTFail("Should have throw exception")
        } catch APIRequestError.requestError( _) {
            // Success
        } catch {
            XCTFail("Should have caught exception earlier \(error)")
        }
    }

    /// Tests the success scenario.
    func testSuccess() async throws {
        let apiMock = APIRequestMock()
        let data = apiMock.getData(filename: "TopStoriesData")
        let url = try XCTUnwrap(URL(string: exampleUrlString))
        let response = try XCTUnwrap(
            HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )
        )

        let mock = NetworkSessionMock(response: response, data: data)
        let subject = DefaultAPIRequest(networkSession: mock)

        do {
            let stories: TopStoriesData = try await subject.request(urlString: exampleUrlString)
            XCTAssertEqual(stories.results.count, 37)
        } catch {
            XCTFail("Should not have caught any error: \(error)")
        }
    }
}
