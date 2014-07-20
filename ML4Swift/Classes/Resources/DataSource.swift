/**
 *
 * DataSource.swift
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

class DataSource : BaseResource
{
    //******************************************************************************************
    //**************************** OVERRIDEN METHODS AND PROPERTIES ****************************
    //******************************************************************************************
    
    /*override*/ var resourceBaseURL:String
    {
        var baseURL: String
            
        if let baseAPIURLValue = DataManager.sharedInstance.baseAPIURL {
            baseURL = baseAPIURLValue + "/source"
        }
        else {
            baseURL = ""
        }
        
        return baseURL
    }
    
    //******************************************************************************************
    //************************************ PUBLIC METHODS **************************************
    //******************************************************************************************
    
    func createDataSourceWith(name: String, filePath: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?)
    {
        var returnData: (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?)!
        
        if let contentsOfFileValue = String.stringWithContentsOfFile(filePath, encoding: NSUTF8StringEncoding, error: nil) {
            let urlString: String = self.resourceBaseURL + DataManager.sharedInstance.authToken!
            var bodyString: String = ""
        
            var boundary = "---------------------------14737809831466499882746641449"
            var contentType = "multipart/form-data; boundary=" + boundary
        
            var postbody = "\r\n--" + boundary + "\r\n"
            postbody += "Content-Disposition: form-data; name=\"userfile\"; filename=\"" + name + "\"\r\n"
            postbody += "Content-Type: application/octet-stream\r\n\r\n"
            postbody += contentsOfFileValue
            postbody += "\r\n--" + boundary + "--\r\n"
            
            //Create request
            var resourceId: String?
            var resourceData: NSDictionary?
            
            let result = self.doHttpRequestWith(url: urlString, method: "POST", body: postbody, contentType: contentType)
            
            if result.statusCode != nil && result.data != nil && result.statusCode == HTTPStatusCode.HTTP_CREATED {
                resourceData = NSJSONSerialization.JSONObjectWithData(result.data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
                
                resourceId = self.extractResourceIdFrom(resourceData)
            }
            
            returnData = (result.statusCode, resourceId, resourceData)
        }
        else {
            returnData = (HTTPStatusCode.HTTP_BAD_REQUEST, nil, nil)
        }
        
        return returnData
    }
    
    func updateDataSourceNameWith(#dataSourceId: String, name: String?) -> HTTPStatusCode?
    {
        let urlString: String = self.resourceBaseURL + "/" + dataSourceId + DataManager.sharedInstance.authToken!
        var bodyString: String!
        
        if let nameValue = name {
            bodyString = "{\"name\":\"" + nameValue + "\"}"
        }
        else {
            bodyString = ""
        }
        
        return self.updateResourceWith(url: urlString, body: bodyString)
    }
    
    func deleteDataSourceWith(#dataSourceId: String) -> HTTPStatusCode?
    {
        let urlString: String = self.resourceBaseURL + "/" + dataSourceId + DataManager.sharedInstance.authToken!
        
        return self.deleteResourceWith(url: urlString)
    }
    
    func dataSourceWith(#dataSourceId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?)
    {
        let urlString: String = self.resourceBaseURL + "/" + dataSourceId + DataManager.sharedInstance.authToken!
        
        return self.resourceWith(url: urlString)
    }
    
    func dataSourceIsReadyWith(#dataSourceId: String) -> Bool
    {
        var ready: Bool = false
        
        let urlString: String = self.resourceBaseURL + "/" + dataSourceId + DataManager.sharedInstance.authToken!
        let result = self.resourceWith(url: urlString)
        
        return self.resourceIsReadyWith(result: result)
    }
}