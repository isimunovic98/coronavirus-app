
import Foundation

struct HomeScreenDomainItem {
    
    var title: String = ""
    var confirmedTotalCount: Int = 0, confirmedDifferenceCount: Int = 0
    var activeTotalCount: Int = 0, activeDifferenceCount: Int = 0
    var recoveredTotalCount: Int = 0, recoveredDifferenceCount: Int = 0
    var deathsTotalCount: Int = 0, deathsDifferenceCount: Int = 0
    var details: [HomeScreenDomainItemDetail] = [HomeScreenDomainItemDetail]()
    var lastUpdateDate: Date = .init()
    
    init(title: String = "", topConfirmed: Int = 0, differenceConfirmed: Int = 0, topActive: Int = 0, differenceActive: Int = 0, topRecovered: Int = 0, differenceRecovered: Int = 0, topDeaths: Int = 0, differenceDeaths: Int = 0, details: [HomeScreenDomainItemDetail] = [HomeScreenDomainItemDetail](), lastUpdateDate: Date = Date()) {
        self.title = title
        self.confirmedTotalCount = topConfirmed
        self.confirmedDifferenceCount = differenceConfirmed
        self.activeTotalCount = topActive
        self.activeDifferenceCount = differenceActive
        self.recoveredTotalCount = topRecovered
        self.recoveredDifferenceCount = differenceRecovered
        self.deathsTotalCount = topDeaths
        self.deathsDifferenceCount = differenceDeaths
        self.details = details
        self.lastUpdateDate = lastUpdateDate
    }
}
