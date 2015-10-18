/**
 *
 * Model.swift
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

class Model : BaseResource
{
    //******************************************************************************************
    //**************************** OVERRIDEN METHODS AND PROPERTIES ****************************
    //******************************************************************************************
    
    // MARK: - Properties
    
    override var resourceBaseURL:String {
        var baseURL: String
            
        if let baseAPIURLValue = DataManager.sharedInstance.baseAPIURL {
            baseURL = baseAPIURLValue + "/model"
        }
        else {
            baseURL = ""
        }
        
        return baseURL
    }
    
    //******************************************************************************************
    //************************************ PUBLIC METHODS **************************************
    //******************************************************************************************
    
    // MARK: - Public methods
    
    func createModelWith(dataSetId dataSetId: String, name: String?) -> (statusCode: HTTPStatusCode?, resourceId: String?, modelData: NSDictionary?) {
        let urlString: String = self.resourceBaseURL + DataManager.sharedInstance.authToken!
        var bodyString: String = "{\"dataset\":\"dataset/" + dataSetId + "\""
        
        if let nameValue = name {
            bodyString += ", \"name\":\"" + nameValue + "\"}"
        }
        else {
            bodyString += "}"
        }
        
        return self.createResourceWith(url: urlString, body: bodyString)
    }
    
    func updateModelNameWith(modelId modelId: String, name: String?) -> HTTPStatusCode? {
        let urlString: String = self.resourceBaseURL + "/" + modelId + DataManager.sharedInstance.authToken!
        var bodyString: String!
        
        if let nameValue = name {
            bodyString = "{\"name\":\"" + nameValue + "\"}"
        }
        else {
            bodyString = ""
        }
        
        return self.updateResourceWith(url: urlString, body: bodyString)
    }
    
    func deleteModelWith(modelId modelId: String) -> HTTPStatusCode? {
        let urlString: String = self.resourceBaseURL + "/" + modelId + DataManager.sharedInstance.authToken!
        
        return self.deleteResourceWith(url: urlString)
    }
    
    func modelWith(modelId modelId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, modelData: NSDictionary?) {
        let urlString: String = self.resourceBaseURL + "/" + modelId + DataManager.sharedInstance.authToken!
        
        return self.resourceWith(url: urlString)
    }
    
    func searchModelsBy(name name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, modelListData: NSDictionary?) {
        var urlString: String = self.resourceBaseURL + DataManager.sharedInstance.authToken!
        
        if let nameValue = name {
            urlString += "name=" + nameValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())! + ";"
        }
        
        if offset > 0 {
            urlString += "offset=" + String(offset) + ";"
        }
        
        if limit > 0 {
            urlString += "limit=" + String(limit) + ";"
        }
        
        return self.listResourcesWith(url: urlString)
    }
    
    func modelIsReadyWith(modelId modelId: String) -> Bool {
        let urlString: String = self.resourceBaseURL + "/" + modelId + DataManager.sharedInstance.authToken!
        let result = self.resourceWith(url: urlString)
        
        return self.resourceIsReadyWith(result: result)
    }
}
