//
//  Covid19Repository.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 20.04.2021..
//

import Foundation
import Combine

protocol Covid19Repository {
    func getCountriesList() -> AnyPublisher<Result<[Country], NetworkError>, Never>
}

class Covid19RepositoryImpl: Covid19Repository {
    func getCountriesList() -> AnyPublisher<Result<[Country], NetworkError>, Never> {
        return RestManager.requestObservable(url: RestEndpoints.countriesList.endpoint())
    }
}

