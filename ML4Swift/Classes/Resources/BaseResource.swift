/**
 *
 * BaseResource.swift
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

class BaseResource
{
    //******************************************************************************************
    //************************* METHODS AND PROPERTIES TO BE OVERRIDEN *************************
    //******************************************************************************************
    
    // MARK: - Properties
    
    var resourceBaseURL:String {
        return ""
    }
    
    //******************************************************************************************
    //************************************* UTILITY METHODS ************************************
    //******************************************************************************************
    
    // MARK: - Utility methods
    
    /*!
     * Do generic HTTP request
     */
    func doHttpRequestWith(url: String, method: String, body: String?, contentType: String = "application/json") -> (statusCode: HTTPStatusCode?, data: NSData?) {
        var statusCode: HTTPStatusCode?
        
        var response: URLResponse?
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = method
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpBody = body?.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        let responseData: Data?
        do {
            responseData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response)
        } catch {
            responseData = nil
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            // Work with HTTP response
            statusCode = HTTPStatusCode(rawValue: httpResponse.statusCode)
        }
        
        return (statusCode, responseData as NSData?)
    }
    
    func extractResourceIdFrom(data: NSDictionary?) -> String? {
        var resourceId: String?
        
        if let dataValue = data {
            if let resourceIdValue = dataValue.object(forKey: "resource") as? String {
                resourceId = String(resourceIdValue.split(separator: "/")[1]) as String
            }
        }
        
        return resourceId
    }
    
    //******************************************************************************************
    //****************************** GENERIC HTTP REQUEST METHODS ******************************
    //******************************************************************************************
    
    // MARK: - Generic HTTP request methods
    
    func createResourceWith(url: String, body: String?) -> (HTTPStatusCode?, String?, NSDictionary?) {
        var resourceId: String?
        var resourceData: NSDictionary?
        
        let result = self.doHttpRequestWith(url: url, method: "POST", body: body)
        
        if result.statusCode != nil && result.data != nil && result.statusCode == HTTPStatusCode.HTTP_CREATED {
            resourceData = (try? JSONSerialization.jsonObject(with: result.data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary
            
            resourceId = self.extractResourceIdFrom(data: resourceData)
        }
        
        return (result.statusCode, resourceId, resourceData)
    }
    
    func updateResourceWith(url: String, body: String?) -> HTTPStatusCode? {
        let result = self.doHttpRequestWith(url: url, method: "PUT", body: body)
        
        return result.statusCode
    }
    
    func deleteResourceWith(url: String) -> HTTPStatusCode? {
        let result = self.doHttpRequestWith(url: url, method: "DELETE", body: nil)
        
        return result.statusCode
    }
    
    func resourceWith(url: String) -> (HTTPStatusCode?, String?, NSDictionary?) {
        var resourceId: String?
        var resourceData: NSDictionary?
        
        let result = self.doHttpRequestWith(url: url, method: "GET", body: nil)
        
        if result.statusCode != nil && result.data != nil && result.statusCode == HTTPStatusCode.HTTP_OK {
            resourceData = (try? JSONSerialization.jsonObject(with: result.data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary
            
            resourceId = self.extractResourceIdFrom(data: resourceData)
        }
        
        return (result.statusCode, resourceId, resourceData)
    }
    
    func listResourcesWith(url: String) -> (HTTPStatusCode?, NSDictionary?) {
        var resourcesData: NSDictionary?
        
        let result = self.doHttpRequestWith(url: url, method: "GET", body: nil)
        
        if result.statusCode != nil && result.data != nil && result.statusCode == HTTPStatusCode.HTTP_OK {
            resourcesData = (try? JSONSerialization.jsonObject(with: result.data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary
        }
        
        return (result.statusCode, resourcesData)
    }
    
    func resourceIsReadyWith(result: (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?)) -> Bool {
        var ready: Bool = false;
        
        if let statusCodeValue = result.statusCode {
            if statusCodeValue == HTTPStatusCode.HTTP_OK {
                if let resourceDataValue = result.resourceData {
                    let resourceStatus: AnyObject? = (resourceDataValue.object(forKey: "status") as AnyObject).object(forKey: "code") as AnyObject?
                    
                    if let resourceStatusValue = resourceStatus?.integerValue {
                        ready = (resourceStatusValue == ResourceStatusCode.FINISHED.rawValue)
                    }
                }
            }
        }
        
        return ready
    }
}
