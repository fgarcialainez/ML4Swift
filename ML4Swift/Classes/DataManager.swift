/**
 *
 * Constants.swift
 * ML4Swift
 *
 * Created by Felix Garcia Lainez on 12/07/14
 * Copyright 2014 Felix Garcia Lainez
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation

class DataManager
{
    // MARK: - Properties
    
    /**
     * Struct to hold BigML account data
     */
    struct BigMLAccountData {
        var apiUsername: String?
        var apiKey: String?
        
        /**
         * BigML.io Development Mode
         * @see http://blog.bigml.com/2012/07/04/introducing-bigmls-free-machine-learning-sandbox/
         */
        var developmentMode: Bool?
        
        init(apiUsername: String, apiKey: String, developmentMode: Bool) {
            self.apiUsername = apiUsername;
            self.apiKey = apiKey;
            self.developmentMode = developmentMode;
        }
    }
    
    /**
     * Hold BigML account data
     */
    var accountData :BigMLAccountData?
    
    /**
     * Auth Token for API requests
     */
    var authToken: String?

    /**
     * BigML base API url
     */
    var baseAPIURL:String?
    
    // MARK: - Accessors and initializers
    
    /**
     * Singleton accessor
     */
    class var sharedInstance: DataManager {
        struct Singleton {
            static let instance = DataManager()
        }
        return Singleton.instance
    }
    
    func initializeWith(apiUsername: String, apiKey: String, developmentMode: Bool) {
        self.accountData = BigMLAccountData(apiUsername: apiUsername, apiKey: apiKey, developmentMode: developmentMode)
        
        self.authToken = "?username=" + apiUsername + ";api_key=" + apiKey + ";"
        
        if developmentMode {
            self.baseAPIURL = "https://bigml.io/dev/andromeda"
        }
        else {
            self.baseAPIURL = "https://bigml.io/andromeda";
        }
    }
    
    // MARK: - Public Methods
    
    func printCredentials() {
        if let apiUsernameValue = self.accountData?.apiUsername {
            print("API Username: " + apiUsernameValue)
        }
        else {
            print("No API Username Available")
        }
        
        if let apiKeyValue = self.accountData?.apiKey {
            print("API Key: " + apiKeyValue)
        }
        else {
            print("No API Key Available")
        }
        
        if let developmentModeValue = self.accountData?.developmentMode {
            print("Development Mode: \(developmentModeValue)")
        }
        else {
            print("No Development Mode Available")
        }
        
        if let authTokenValue = self.authToken {
            print("Auth Token: " + authTokenValue)
        }
        else {
            print("No Auth Token Available")
        }
        
        if let baseAPIURLValue = self.baseAPIURL {
            print("Base API URL: " + baseAPIURLValue)
        }
        else {
            print("No Base API URL Available")
        }
    }
}
