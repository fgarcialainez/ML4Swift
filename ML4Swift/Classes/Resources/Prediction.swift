/**
 *
 * Prediction.swift
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

class Prediction : BaseResource
{
    /*override*/ var resourceBaseURL:String
    {
        var baseURL: String
            
        if let baseAPIURLValue = DataManager.sharedInstance.baseAPIURL {
            baseURL = baseAPIURLValue + "/prediction"
        }
        else {
            baseURL = ""
        }
        
        return baseURL
    }
    
    func createPredictionWith(#modelId: String, name: String?, inputData: String?) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?)
    {
        let urlString: String = self.resourceBaseURL + DataManager.sharedInstance.authToken!
        var bodyString: String = "{\"model\":\"model/" + modelId + "\""
        
        if let nameValue = name {
            bodyString += ", \"name\":\"" + nameValue + "\""
        }
        
        if let inputDataValue = inputData {
            bodyString += ", \"input_data\":" + inputDataValue
        }
        else {
            bodyString += ", \"input_data\":{}"
        }
        
        bodyString += "}"
        
        return self.createResourceWith(url: urlString, body: bodyString)
    }
    
    func deletePredictionWith(#predictionId: String) -> HTTPStatusCode?
    {
        let urlString: String = self.resourceBaseURL + "/" + predictionId + DataManager.sharedInstance.authToken!
        
        return self.deleteResourceWith(url: urlString)
    }
    
    func predictionIsReadyWith(#predictionId: String) -> Bool
    {
        var ready: Bool = false
        
        let urlString: String = self.resourceBaseURL + "/" + predictionId + DataManager.sharedInstance.authToken!
        let result = self.resourceWith(url: urlString)
        
        return self.resourceIsReadyWith(result: result)
    }
}
