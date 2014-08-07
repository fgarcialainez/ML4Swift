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

protocol ML4SwiftDelegate
{
    //******************************************************************************************
    //************************************ DATASOURCES *****************************************
    //******************************************************************************************
    
    func dataSourceCreatedWith(#statusCode: HTTPStatusCode?, resourceId: String?, dataSourceData: NSDictionary?)
    
    func dataSourceUpdatedWith(#statusCode: HTTPStatusCode?)
    
    func dataSourceDeletedWith(#statusCode: HTTPStatusCode?)
    
    func dataSourceRetrievedWith(#statusCode: HTTPStatusCode?, resourceId: String?, dataSourceData: NSDictionary?)
    
    func dataSourcesRetrievedWith(#statusCode: HTTPStatusCode?, dataSourceListData: NSDictionary?)
    
    func dataSourceIsReadyWith(#status: Bool)
    
    //******************************************************************************************
    //************************************** DATASETS ******************************************
    //******************************************************************************************
    
    func dataSetCreatedWith(#statusCode: HTTPStatusCode?, resourceId: String?, dataSetData: NSDictionary?)
    
    func dataSetUpdatedWith(#statusCode: HTTPStatusCode?)
    
    func dataSetDeletedWith(#statusCode: HTTPStatusCode?)
    
    func dataSetRetrievedWith(#statusCode: HTTPStatusCode?, resourceId: String?, dataSetData: NSDictionary?)
    
    func dataSetsRetrievedWith(#statusCode: HTTPStatusCode?, dataSetListData: NSDictionary?)
    
    func dataSetIsReadyWith(#status: Bool)
    
    //******************************************************************************************
    //*************************************** MODELS *******************************************
    //******************************************************************************************
    
    func modelCreatedWith(#statusCode: HTTPStatusCode?, resourceId: String?, modelData: NSDictionary?)
    
    func modelUpdatedWith(#statusCode: HTTPStatusCode?)
    
    func modelDeletedWith(#statusCode: HTTPStatusCode?)
    
    func modelRetrievedWith(#statusCode: HTTPStatusCode?, resourceId: String?, modelData: NSDictionary?)
    
    func modelsRetrievedWith(#statusCode: HTTPStatusCode?, modelListData: NSDictionary?)
    
    func modelIsReadyWith(#status: Bool)
    
    //******************************************************************************************
    //************************************* PREDICTIONS ****************************************
    //******************************************************************************************
    
    func predictionCreatedWith(#statusCode: HTTPStatusCode?, resourceId: String?, predictionData: NSDictionary?)
    
    func predictionUpdatedWith(#statusCode: HTTPStatusCode?)
    
    func predictionDeletedWith(#statusCode: HTTPStatusCode?)
    
    func predictionRetrievedWith(#statusCode: HTTPStatusCode?, resourceId: String?, predictionData: NSDictionary?)
    
    func predictionsRetrievedWith(#statusCode: HTTPStatusCode?, predictionListData: NSDictionary?)
    
    func predictionIsReadyWith(#status: Bool)
    
    //******************************************************************************************
    //************************************** CLUSTERS ******************************************
    //******************************************************************************************
    
    func clusterCreatedWith(#statusCode: HTTPStatusCode?, resourceId: String?, clusterData: NSDictionary?)
    
    func clusterUpdatedWith(#statusCode: HTTPStatusCode?)
    
    func clusterDeletedWith(#statusCode: HTTPStatusCode?)
    
    func clusterRetrievedWith(#statusCode: HTTPStatusCode?, resourceId: String?, clusterData: NSDictionary?)
    
    func clustersRetrievedWith(#statusCode: HTTPStatusCode?, clusterListData: NSDictionary?)
    
    func clusterIsReadyWith(#status: Bool)
}