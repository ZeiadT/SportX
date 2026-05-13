//
//  MockURLProtocol.swift
//  SportXTests
//
//  Created by Wahid Ali Wahid on 13/05/2026.
//

import Foundation

final class MockURLProtocol: URLProtocol {

    static var stubResponseData: Data?
    static var stubError: Error?
    static var statusCode: Int = 200

    override class func canInit(
        with request: URLRequest
    ) -> Bool {

        return true
    }

    override class func canonicalRequest(
        for request: URLRequest
    ) -> URLRequest {

        return request
    }

    override func startLoading() {

        if let error = Self.stubError {

            client?.urlProtocol(
                self,
                didFailWithError: error
            )

            return
        }

        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: Self.statusCode,
            httpVersion: nil,
            headerFields: nil
        )!

        client?.urlProtocol(
            self,
            didReceive: response,
            cacheStoragePolicy: .notAllowed
        )

        if let data = Self.stubResponseData {

            client?.urlProtocol(
                self,
                didLoad: data
            )
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
