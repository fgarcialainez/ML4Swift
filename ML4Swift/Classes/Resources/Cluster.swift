/**
 *
 * Cluster.swift
 * ML4Swift
 *
 * Created by Felix Garcia Lainez on 13/07/14
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

class Cluster : BaseResource
{
    //******************************************************************************************
    //**************************** OVERRIDEN METHODS AND PROPERTIES ****************************
    //******************************************************************************************
    
    override var resourceBaseURL:String {
        var baseURL: String
            
        if let baseAPIURLValue = DataManager.sharedInstance.baseAPIURL {
            baseURL = baseAPIURLValue + "/cluster"
        }
        else {
            baseURL = ""
        }
        
        return baseURL
    }
    
    //******************************************************************************************
    //************************************ PUBLIC METHODS **************************************
    //******************************************************************************************
    
    func createClusterWith(#dataSetId: String, name: String?, numberOfClusters: Int?) -> (statusCode: HTTPStatusCode?, resourceId: String?, clusterData: NSDictionary?) {
        let urlString: String = self.resourceBaseURL + DataManager.sharedInstance.authToken!
        var bodyString: String = "{\"dataset\":\"dataset/" + dataSetId + "\""
        
        if let nameValue = name {
            bodyString += ", \"name\":\"" + nameValue + "\""
        }
        
        if let numberOfClustersValue = numberOfClusters {
            bodyString += ", \"k\":" + numberOfClustersValue.description
        }
        
         bodyString += "}"
        
        return self.createResourceWith(url: urlString, body: bodyString)
    }
    
    func updateClusterNameWith(#clusterId: String, name: String?) -> HTTPStatusCode? {
        let urlString: String = self.resourceBaseURL + "/" + clusterId + DataManager.sharedInstance.authToken!
        var bodyString: String!
        
        if let nameValue = name {
            bodyString = "{\"name\":\"" + nameValue + "\"}"
        }
        else {
            bodyString = ""
        }
        
        return self.updateResourceWith(url: urlString, body: bodyString)
    }
    
    func deleteClusterWith(#clusterId: String) -> HTTPStatusCode? {
        let urlString: String = self.resourceBaseURL + "/" + clusterId + DataManager.sharedInstance.authToken!
        
        return self.deleteResourceWith(url: urlString)
    }
    
    func clusterWith(#clusterId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, clusterData: NSDictionary?) {
        let urlString: String = self.resourceBaseURL + "/" + clusterId + DataManager.sharedInstance.authToken!
        
        return self.resourceWith(url: urlString)
    }
    
    func searchClustersBy(#name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, clusterListData: NSDictionary?) {
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
    
    func clusterIsReadyWith(#clusterId: String) -> Bool {
        var ready: Bool = false
        
        let urlString: String = self.resourceBaseURL + "/" + clusterId + DataManager.sharedInstance.authToken!
        let result = self.resourceWith(url: urlString)
        
        return self.resourceIsReadyWith(result: result)
    }
}