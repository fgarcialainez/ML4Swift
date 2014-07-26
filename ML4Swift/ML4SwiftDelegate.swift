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
    
    func dataSourceCreatedWith(#statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?)
    
    func dataSourceUpdateWith(#statusCode: HTTPStatusCode?)
    
    func dataSourceDeletedWith(#statusCode: HTTPStatusCode?)
    
    func dataSourceRetrievedWith(#statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?)
    
    func dataSourcesRetrievedWith(#statusCode: HTTPStatusCode?, resourcesData: NSDictionary?)
    
    func dataSourceIsReadyWith(#status: Bool)
    
    //******************************************************************************************
    //************************************** DATASETS ******************************************
    //******************************************************************************************
    
    func dataSetCreatedWith(#statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?)
    
    func dataSetUpdateWith(#statusCode: HTTPStatusCode?)
    
    func dataSetDeletedWith(#statusCode: HTTPStatusCode?)
    
    func dataSetRetrievedWith(#statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?)
    
    func dataSetRetrievedWith(#statusCode: HTTPStatusCode?, resourcesData: NSDictionary?)
    
    func dataSetIsReadyWith(#status: Bool)
}