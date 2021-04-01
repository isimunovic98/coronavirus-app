//
//  CountrySelectionRepository.swift
//  CoronaVirusApp
//
//  Created by Ivan Simunovic on 01.04.2021..
//

import Foundation
import Combine

protocol CountrySelectionRepository {
    func getCountriesList(using endpoint: RestEndpoints) -> AnyPublisher<Result<Country, NetworkError>, Never>
}

class CountrySelectionRepositoryImpl: CountrySelectionRepository {
    func getCountriesList(using endpoint: RestEndpoints) -> AnyPublisher<Result<Country, NetworkError>, Never> {
        return RestManager.requestObservable(url: endpoint.endpoint())
    }
}
