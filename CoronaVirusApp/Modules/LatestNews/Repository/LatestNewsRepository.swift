//
//  LatestNewsRepository.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 30.04.2021..
//

import Foundation
import Combine

protocol LatestNewsRepository {
    func getLatestNews(withOffset offset: Int) -> AnyPublisher<Result<LatestNewsResponseItem, ErrorType>, Never>
}

class LatestNewsRepositoryImpl: LatestNewsRepository {
    func getLatestNews(withOffset offset: Int) -> AnyPublisher<Result<LatestNewsResponseItem, ErrorType>, Never> {
        return RestManager.requestObservable(url: RestEndpoints.latestNews(offset: offset).endpoint())
    }
}
