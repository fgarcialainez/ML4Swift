/**
 *
 * ML4SwiftDelegate.swift
 * ML4Swift
 *
 * Created by Felix Garcia Lainez on 26/07/14
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

public protocol ML4SwiftDelegate : class
{
    //******************************************************************************************
    //************************************ DATASOURCES *****************************************
    //******************************************************************************************
    
    // MARK: - DataSources
    
    func dataSourceCreatedWith(statusCode statusCode: HTTPStatusCode?, resourceId: String?, dataSourceData: NSDictionary?)
    
    func dataSourceUpdatedWith(statusCode statusCode: HTTPStatusCode?)
    
    func dataSourceDeletedWith(statusCode statusCode: HTTPStatusCode?)
    
    func dataSourceRetrievedWith(statusCode statusCode: HTTPStatusCode?, resourceId: String?, dataSourceData: NSDictionary?)
    
    func dataSourcesRetrievedWith(statusCode statusCode: HTTPStatusCode?, dataSourceListData: NSDictionary?)
    
    func dataSourceIsReadyWith(status status: Bool)
    
    //******************************************************************************************
    //************************************** DATASETS ******************************************
    //******************************************************************************************
    
    // MARK: - DataSets
    
    func dataSetCreatedWith(statusCode statusCode: HTTPStatusCode?, resourceId: String?, dataSetData: NSDictionary?)
    
    func dataSetUpdatedWith(statusCode statusCode: HTTPStatusCode?)
    
    func dataSetDeletedWith(statusCode statusCode: HTTPStatusCode?)
    
    func dataSetRetrievedWith(statusCode statusCode: HTTPStatusCode?, resourceId: String?, dataSetData: NSDictionary?)
    
    func dataSetsRetrievedWith(statusCode statusCode: HTTPStatusCode?, dataSetListData: NSDictionary?)
    
    func dataSetIsReadyWith(status status: Bool)
    
    //******************************************************************************************
    //*************************************** MODELS *******************************************
    //******************************************************************************************
    
    // MARK: - Models
    
    func modelCreatedWith(statusCode statusCode: HTTPStatusCode?, resourceId: String?, modelData: NSDictionary?)
    
    func modelUpdatedWith(statusCode statusCode: HTTPStatusCode?)
    
    func modelDeletedWith(statusCode statusCode: HTTPStatusCode?)
    
    func modelRetrievedWith(statusCode statusCode: HTTPStatusCode?, resourceId: String?, modelData: NSDictionary?)
    
    func modelsRetrievedWith(statusCode statusCode: HTTPStatusCode?, modelListData: NSDictionary?)
    
    func modelIsReadyWith(status status: Bool)
    
    //******************************************************************************************
    //************************************* PREDICTIONS ****************************************
    //******************************************************************************************
    
    // MARK: - Predictions
    
    func predictionCreatedWith(statusCode statusCode: HTTPStatusCode?, resourceId: String?, predictionData: NSDictionary?)
    
    func predictionUpdatedWith(statusCode statusCode: HTTPStatusCode?)
    
    func predictionDeletedWith(statusCode statusCode: HTTPStatusCode?)
    
    func predictionRetrievedWith(statusCode statusCode: HTTPStatusCode?, resourceId: String?, predictionData: NSDictionary?)
    
    func predictionsRetrievedWith(statusCode statusCode: HTTPStatusCode?, predictionListData: NSDictionary?)
    
    func predictionIsReadyWith(status status: Bool)
    
    //******************************************************************************************
    //************************************** CLUSTERS ******************************************
    //******************************************************************************************
    
    // MARK: - Clusters
    
    func clusterCreatedWith(statusCode statusCode: HTTPStatusCode?, resourceId: String?, clusterData: NSDictionary?)
    
    func clusterUpdatedWith(statusCode statusCode: HTTPStatusCode?)
    
    func clusterDeletedWith(statusCode statusCode: HTTPStatusCode?)
    
    func clusterRetrievedWith(statusCode statusCode: HTTPStatusCode?, resourceId: String?, clusterData: NSDictionary?)
    
    func clustersRetrievedWith(statusCode statusCode: HTTPStatusCode?, clusterListData: NSDictionary?)
    
    func clusterIsReadyWith(status status: Bool)
}