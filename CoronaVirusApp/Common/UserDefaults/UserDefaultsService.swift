
import Foundation

struct UserDefaultsService {
    
    private static let userDefaults = UserDefaults.standard
    

    static func update(_ item: UserDefaultsDomainItem) {
        userDefaults.setValue(item.usecase, forKey: "usecase")
    }
    
    static func getSavedData() -> UserDefaultsDomainItem {
        var result = UserDefaultsDomainItem()
        let savedUsecase = userDefaults.string(forKey: "usecase") ?? "croatia"
        result.usecase = savedUsecase
        return result
    }
    
    static func getUsecase() -> UseCaseSelection {
        let savedData = UserDefaultsService.getSavedData()
        switch savedData.usecase {
        case "worldwide": return .worldwide
        default: return .country(savedData.usecase)
        }
    }
}
