import Foundation


/// Credentials struct to store user credentials
struct Credentials{
    var username : String
    var password : String
}


/// KeychainError enum to handle keychain errors
enum KeychainError : Error{
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}


class KeychainManager{

    
    func addCredential(credential: Credentials) throws {
        
        let accountUsername = credential.username
        let accountPassword = credential.password.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: accountUsername,

            kSecValueData as String: accountPassword
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else{throw KeychainError.unhandledError(status: status)}
    }
    
    func retrieveCredentials(accountName: String) throws -> Credentials {
        
        let query : [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: accountName,

            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String : true,
            kSecReturnData as String : true
        ]
        
        var item: CFTypeRef?
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status != errSecItemNotFound else {throw KeychainError.noPassword}
        
        guard status == errSecSuccess else {throw KeychainError.unhandledError(status: status)}
        
        guard let existingItem = item as? [String: Any],
              let passwordData = existingItem[kSecValueData as String] as? Data,
              let password =  String(data: passwordData, encoding: .utf8),
              let accountUsername = existingItem[kSecAttrAccount as String] as? String
        else{
            throw KeychainError.unexpectedPasswordData
        }
        
        let credentials = Credentials(username: accountUsername, password: password)
        return credentials
    }
}
