import JWTDecode

/// UserProfile struct is used to store the user information received from Auth0 Authentication.
struct UserProfile {
  
  let id: String
  let userId: String
  let name: String
  let email: String
  let emailVerified: String
  let picture: String
  let updatedAt: String

}


extension UserProfile {
  
  static var empty: Self {
    return UserProfile(
      id: "",
      userId: "",
      name: "",
      email: "",
      emailVerified: "",
      picture: "",
      updatedAt: ""
    )
  }
    
    /// Static function from() fetches results using JWTDecoder and sets values for each attriburw
    /// - Parameter idToken: idToken is received from Auth0 in the form of a string which when decoded, returns a JSON object with user info.
    /// - Returns: this method returns an empty UserProfile or a populated UserProfile depending on the outcome of the decoded idToken
    static func from(_ idToken: String) -> Self {
        guard
          let jwt = try? decode(jwt: idToken),
          let id = jwt.subject,
          let userId = jwt.claim(name: "sub").string,
          let name = jwt.claim(name: "name").string,
          let email = jwt.claim(name: "email").string,
          let emailVerified = jwt.claim(name: "email_verified").boolean,
          let picture = jwt.claim(name: "picture").string,
          let updatedAt = jwt.claim(name: "updated_at").string
        else {
          return .empty
        }

        return UserProfile(
          id: id,
          userId: userId,
          name: name,
          email: email,
          emailVerified: String(describing: emailVerified),
          picture: picture,
          updatedAt: updatedAt
        )
      }
  
}
