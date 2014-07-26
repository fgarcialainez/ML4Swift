/**
 *
 * DataSet.swift
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

class DataSet : BaseResource
{
    //******************************************************************************************
    //**************************** OVERRIDEN METHODS AND PROPERTIES ****************************
    //******************************************************************************************
    override var resourceBaseURL:String {
        var baseURL: String
            
        if let baseAPIURLValue = DataManager.sharedInstance.baseAPIURL {
            baseURL = baseAPIURLValue + "/dataset"
        }
        else {
            baseURL = ""
        }
        
        return baseURL
    }
    
    //******************************************************************************************
    //************************************ PUBLIC METHODS **************************************
    //******************************************************************************************
    
    func createDataSetWith(#dataSourceId: String, name: String?) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        let urlString: String = self.resourceBaseURL + DataManager.sharedInstance.authToken!
        var bodyString: String = "{\"source\":\"source/" + dataSourceId + "\""
        
        if let nameValue = name {
            bodyString += ", \"name\":\"" + nameValue + "\"}"
        }
        else {
            bodyString += "}"
        }
        
        return self.createResourceWith(url: urlString, body: bodyString)
    }
    
    func updateDataSetNameWith(#dataSetId: String, name: String?) -> HTTPStatusCode? {
        let urlString: String = self.resourceBaseURL + "/" + dataSetId + DataManager.sharedInstance.authToken!
        var bodyString: String!
        
        if let nameValue = name {
            bodyString = "{\"name\":\"" + nameValue + "\"}"
        }
        else {
            bodyString = ""
        }
        
        return self.updateResourceWith(url: urlString, body: bodyString)
    }
    
    func deleteDataSetWith(#dataSetId: String) -> HTTPStatusCode? {
        let urlString: String = self.resourceBaseURL + "/" + dataSetId + DataManager.sharedInstance.authToken!
        
        return self.deleteResourceWith(url: urlString)
    }
    
    func dataSetWith(#dataSetId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        let urlString: String = self.resourceBaseURL + "/" + dataSetId + DataManager.sharedInstance.authToken!
        
        return self.resourceWith(url: urlString)
    }
    
    func searchDataSetsBy(#name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, resourcesData: NSDictionary?) {
        var urlString: String = self.resourceBaseURL + DataManager.sharedInstance.authToken!
        
        if let nameValue = name {
            urlString += "name=" + nameValue.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) + ";"
        }
        
        if offset > 0 {
            urlString += "offset=" + String(offset) + ";"
        }
        
        if limit > 0 {
            urlString += "limit=" + String(limit) + ";"
        }
        
        return self.listResourcesWith(url: urlString)
    }
    
    func dataSetIsReadyWith(#dataSetId: String) -> Bool {
        var ready: Bool = false
        
        let urlString: String = self.resourceBaseURL + "/" + dataSetId + DataManager.sharedInstance.authToken!
        let result = self.resourceWith(url: urlString)
        
        return self.resourceIsReadyWith(result: result)
    }
}
