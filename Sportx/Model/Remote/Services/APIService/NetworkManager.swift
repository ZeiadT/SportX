//
//  NetworkManager.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 7/5/2026.
//

import Foundation
import Alamofire

final class NetworkManager {

    static let shared = NetworkManager()

    let session: Session

    init(session: Session = .default) {
        self.session = session
    }
}
