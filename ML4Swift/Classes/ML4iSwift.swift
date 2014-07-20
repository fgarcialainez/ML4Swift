/**
 *
 * ML4iOS.swift
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

class ML4Swift
{
    @lazy var dataSource = DataSource()
    @lazy var dataSet = DataSet()
    @lazy var model = Model()
    @lazy var prediction = Prediction()
    
    init(apiUsername: String, apiKey: String, developmentMode: Bool) {
        DataManager.sharedInstance.initializeWith(apiUsername: apiUsername, apiKey: apiKey, developmentMode: developmentMode);
    }
    
    func printFrameworkData(){
        println()
        
        DataManager.sharedInstance.printCredentials()
        
        println("DataSource Base URL: " + self.dataSource.resourceBaseURL)
        println("DataSet Base URL: " + self.dataSet.resourceBaseURL)
        println("Model Base URL: " + self.model.resourceBaseURL)
        println("Prediction Base URL: " + self.prediction.resourceBaseURL)
    }
    
    //******************************************************************************************
    //************************************** SOURCES *******************************************
    //************************ https://bigml.com/developers/sources ****************************
    //******************************************************************************************
    
    func createDataSourceWith(name: String, filePath: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return dataSource.createDataSourceWith(name, filePath: filePath)
    }
    
    func updateDataSourceNameWith(#dataSourceId: String, name: String?) -> HTTPStatusCode? {
        return dataSource.updateDataSourceNameWith(dataSourceId: dataSourceId, name: name)
    }
    
    func deleteDataSourceWith(#dataSourceId: String) -> HTTPStatusCode? {
        return dataSource.deleteDataSourceWith(dataSourceId: dataSourceId)
    }
    
    func dataSourceWith(#dataSourceId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return dataSource.dataSourceWith(dataSourceId: dataSourceId)
    }
    
    func searchDataSourcesBy(#name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, resourcesData: NSDictionary?) {
        return dataSource.searchDataSourcesBy(name: name, offset: offset, limit: limit)
    }
    
    func dataSourceIsReadyWith(#dataSourceId: String) -> Bool {
        return dataSource.dataSourceIsReadyWith(dataSourceId: dataSourceId)
    }
    
    //******************************************************************************************
    //************************************** DATASETS ******************************************
    //************************ https://bigml.com/developers/datasets ***************************
    //******************************************************************************************
    
    func createDataSetWith(#dataSourceId: String, name: String?) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return dataSet.createDataSetWith(dataSourceId: dataSourceId, name: name)
    }
    
    func updateDataSetNameWith(#dataSetId: String, name: String?) -> HTTPStatusCode? {
        return dataSet.updateDataSetNameWith(dataSetId: dataSetId, name: name)
    }

    func deleteDataSetWith(#dataSetId: String) -> HTTPStatusCode? {
        return dataSet.deleteDataSetWith(dataSetId: dataSetId)
    }
    
    func dataSetWith(#dataSetId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return dataSet.dataSetWith(dataSetId: dataSetId)
    }
    
    func searchDataSetsBy(#name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, resourcesData: NSDictionary?) {
        return dataSet.searchDataSetsBy(name: name, offset: offset, limit: limit)
    }
    
    func dataSetIsReadyWith(#dataSetId: String) -> Bool {
        return dataSet.dataSetIsReadyWith(dataSetId: dataSetId)
    }
    
    //******************************************************************************************
    //*************************************** MODELS *******************************************
    //************************* https://bigml.com/developers/models ****************************
    //******************************************************************************************
    
    func createModelWith(#dataSetId: String, name: String?) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return model.createModelWith(dataSetId: dataSetId, name: name)
    }
    
    func updateModelNameWith(#modelId: String, name: String?) -> HTTPStatusCode? {
        return model.updateModelNameWith(modelId: modelId, name: name)
    }
    
    func deleteModelWith(#modelId: String) -> HTTPStatusCode? {
        return model.deleteModelWith(modelId: modelId)
    }
    
    func modelWith(#modelId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return model.modelWith(modelId: modelId)
    }
    
    func searchModelsBy(#name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, resourcesData: NSDictionary?) {
        return model.searchModelsBy(name: name, offset: offset, limit: limit)
    }
    
    func modelIsReadyWith(#modelId: String) -> Bool {
        return model.modelIsReadyWith(modelId: modelId)
    }
    
    //******************************************************************************************
    //************************************* PREDICTIONS ****************************************
    //*********************** https://bigml.com/developers/predictions *************************
    //******************************************************************************************
    
    func createPredictionWith(#modelId: String, name: String?, inputData: String?) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return prediction.createPredictionWith(modelId: modelId, name: name, inputData: inputData)
    }
    
    func updatePredictionNameWith(#predictionId: String, name: String?) -> HTTPStatusCode? {
        return prediction.updatePredictionNameWith(predictionId: predictionId, name: name)
    }
    
    func deletePredictionWith(#predictionId: String) -> HTTPStatusCode? {
        return prediction.deletePredictionWith(predictionId: predictionId)
    }
    
    func predictionWith(#predictionId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return prediction.predictionWith(predictionId: predictionId)
    }
    
    func searchPredictionsBy(#name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, resourcesData: NSDictionary?) {
        return prediction.searchPredictionsBy(name: name, offset: offset, limit: limit)
    }
    
    func predictionIsReadyWith(#predictionId: String) -> Bool {
        return prediction.predictionIsReadyWith(predictionId: predictionId)
    }
}