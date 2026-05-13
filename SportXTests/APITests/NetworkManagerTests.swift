//
//  NetworkManagerTests.swift
//  SportXTests
//
//  Created by Wahid Ali Wahid on 13/05/2026.
//

import XCTest
import Alamofire
@testable import SportX

final class NetworkManagerTests: XCTestCase {

    var sut: NetworkManager!

    override func setUp() {

        super.setUp()

        let configuration =
            URLSessionConfiguration.ephemeral

        configuration.protocolClasses = [
            MockURLProtocol.self
        ]

        let session = Session(
            configuration: configuration
        )

        sut = NetworkManager(
            session: session
        )
    }

    override func tearDown() {

        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.stubError = nil
        MockURLProtocol.statusCode = 200

        sut = nil

        super.tearDown()
    }
}


extension NetworkManagerTests {

    func testFetchSportsSuccess()
    async throws {

        // GIVEN

        let json = """
        {
            "success": 1,
            "result": [
                {
                    "sport_key": 1,
                    "sport_name": "Football"
                }
            ]
        }
        """

        MockURLProtocol.stubResponseData =
            json.data(using: .utf8)

        // WHEN

        let sports = try await sut.fetchSports()

        // THEN

        XCTAssertEqual(sports.count, 1)

        XCTAssertEqual(
            sports.first?.sport_name,
            "Football"
        )
    }
}

extension NetworkManagerTests {

    func testFetchSportsFailure()
    async {

        MockURLProtocol.stubError =
            NSError(
                domain: "TestError",
                code: 500
            )

        do {

            _ = try await sut.fetchSports()

            XCTFail(
                "Expected error but succeeded"
            )

        } catch {

            XCTAssertNotNil(error)
        }
    }
}
extension NetworkManagerTests {

    func testFetchSportsEmpty()
    async throws {

        let json = """
        {
            "success": 1,
            "result": []
        }
        """

        MockURLProtocol.stubResponseData =
            json.data(using: .utf8)

        let sports =
            try await sut.fetchSports()

        XCTAssertTrue(sports.isEmpty)
    }
}

extension NetworkManagerTests {

    func testFetchLeaguesSuccess()
    async throws {

        let json = """
        {
            "success": 1,
            "result": [
                {
                    "league_key": 152,
                    "league_name": "Premier League"
                }
            ]
        }
        """

        MockURLProtocol.stubResponseData =
            json.data(using: .utf8)

        let leagues =
            try await sut.fetchLeagues(
                sport: "football"
            )

        XCTAssertEqual(leagues.count, 1)

        XCTAssertEqual(
            leagues.first?.league_name,
            "Premier League"
        )
    }
}

extension NetworkManagerTests {
    
    func testFetchTeamsSuccess()
    async throws {

        let json = """
        {
            "success": 1,
            "result": [
                {
                    "team_key": 10,
                    "team_name": "Barcelona"
                }
            ]
        }
        """

        MockURLProtocol.stubResponseData =
            json.data(using: .utf8)

        let teams =
            try await sut.fetchTeams(
                sport: "football",
                leagueId: 152
            )

        XCTAssertEqual(teams.count, 1)

        XCTAssertEqual(
            teams.first?.team_name,
            "Barcelona"
        )
    }
}


extension NetworkManagerTests {

    func testFetchFixturesSuccess()
    async throws {

        let json = """
        {
            "success": 1,
            "result": [
                {
                    "event_key": 1,
                    "event_home_team": "Real Madrid",
                    "event_away_team": "Barcelona"
                }
            ]
        }
        """

        MockURLProtocol.stubResponseData =
            json.data(using: .utf8)

        let fixtures =
            try await sut.fetchFixtures(
                sport: "football",
                leagueId: 152
            )

        XCTAssertEqual(fixtures.count, 1)

        XCTAssertEqual(
            fixtures.first?.event_home_team,
            "Real Madrid"
        )
    }
}


extension NetworkManagerTests {

    func testHTTPValidationFailure()
    async {

        MockURLProtocol.statusCode = 404

        MockURLProtocol.stubResponseData =
            "{}".data(using: .utf8)

        do {

            _ = try await sut.fetchSports()

            XCTFail("Expected HTTP failure")

        } catch {

            XCTAssertNotNil(error)
        }
    }
}
