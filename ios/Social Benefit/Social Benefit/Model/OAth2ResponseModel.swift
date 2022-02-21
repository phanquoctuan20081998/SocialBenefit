//
//  OAth2ResponseModel.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 18/01/2022.
//

import Foundation

struct OAth2Response {
    
    private var accessToken: String
    private var expiresIn: Int
    private var refreshExpiresIn: Int
    private var refreshToken: String
    private var tokenType: String
    private var notBeforePolicy: Int
    private var sessionState: String
    private var scope: String
    
    public init() {
        accessToken = ""
        expiresIn = 0
        refreshExpiresIn = 0
        refreshToken = ""
        tokenType = ""
        notBeforePolicy = 0
        sessionState = ""
        scope = ""
    }

    public func getAccessToken() -> String {
        return accessToken
    }
    
    public mutating func setAccessToken(accessToken: String) {
        self.accessToken = accessToken
    }
    
    public func getExpiresIn() -> Int {
        return expiresIn
    }
    
    public mutating func setExpiresIn(expiresIn: Int) {
        self.expiresIn = expiresIn
    }
    
    public func getRefreshExpiresIn() -> Int {
        return refreshExpiresIn
    }
    
    public mutating func setRefreshExpiresIn(refreshExpiresIn: Int) {
        self.refreshExpiresIn = refreshExpiresIn
    }
    
    public func getRefreshToken() -> String {
        return refreshToken
    }
    
    public mutating func setRefreshToken(refreshToken: String) {
        self.refreshToken = refreshToken
    }
    
    public func getTokenType() -> String {
        return tokenType
    }
    
    public mutating func setTokenType(tokenType: String) {
        self.tokenType = tokenType
    }
    
    public func getNotBeforePolicy() -> Int {
        return notBeforePolicy
    }
    
    public mutating func setNotBeforePolicy(notBeforePolicy: Int) {
        self.notBeforePolicy = notBeforePolicy
    }
    
    public func getSessionState() -> String {
        return sessionState
    }
    
    public mutating func setSessionState(sessionState: String) {
        self.sessionState = sessionState
    }
    
    public func getScope() -> String {
        return scope
    }
    
    public mutating func setScope(scope: String) {
        self.scope = scope
    }
}

