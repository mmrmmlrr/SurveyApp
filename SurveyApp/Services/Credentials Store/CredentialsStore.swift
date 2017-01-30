//
//  CredentialsStore.swift
//  SurveyApp
//
//  Created by Aleksey on 26.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

protocol APICredentialsProviding {
  
  var basePath: String { get }
  var accessToken: String { get }

  func assignNewToken(_ token: String) -> Void
  
}

class CredentialsStore: APICredentialsProviding {
  
  let basePath = "https://nimbl3-survey-api.herokuapp.com/"
  private(set) var accessToken: String = ""
  
  init() {
    accessToken = UserDefaults.standard.string(forKey: "Token") ?? ""
  }
  
  func assignNewToken(_ token: String) {
    accessToken = token
    UserDefaults.standard.set(token, forKey: "Token")
  }
  
}
