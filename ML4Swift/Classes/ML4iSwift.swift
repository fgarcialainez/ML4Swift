/**
 *
 * ML4Swift.swift
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
    
    /*!
     * Async Operations Queue
     */
    let operationQueue = NSOperationQueue()
    
    /*!
     * Async Operations callback events
     */
    var delegate: ML4SwiftDelegate?
    
    //******************************************************************************************
    //*************************** INITIALIZERS AND PUBLIC METHODS ******************************
    //******************************************************************************************
    
    init(apiUsername: String, apiKey: String, developmentMode: Bool, delegate: ML4SwiftDelegate?) {
        DataManager.sharedInstance.initializeWith(apiUsername: apiUsername, apiKey: apiKey, developmentMode: developmentMode);
        
        self.delegate = delegate;
    }
    
    deinit {
        self.operationQueue.cancelAllOperations()
    }
    
    func cancellAllAsyncOperations() {
        self.operationQueue.cancelAllOperations();
    }
    
    func printFrameworkData(){
        println()
        
        DataManager.sharedInstance.printCredentials()
        
        //KNOW ISSUE WITH OVERRIDEN PROPERTIES IN SWIFT COMPILER
        /*
        println("DataSource Base URL: " + self.dataSource.resourceBaseURL)
        println("DataSet Base URL: " + self.dataSet.resourceBaseURL)
        println("Model Base URL: " + self.model.resourceBaseURL)
        println("Prediction Base URL: " + self.prediction.resourceBaseURL)
        */
    }
    
    //******************************************************************************************
    //************************************ DATASOURCES *****************************************
    //************************ https://bigml.com/developers/sources ****************************
    //******************************************************************************************
    
    /**
     * SYNCHRONOUS OPERATIONS
     */
    
    func createDataSourceWith(#name: String, filePath: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return self.dataSource.createDataSourceWith(name: name, filePath: filePath)
    }
    
    func updateDataSourceNameWith(#dataSourceId: String, name: String?) -> HTTPStatusCode? {
        return self.dataSource.updateDataSourceNameWith(dataSourceId: dataSourceId, name: name)
    }
    
    func deleteDataSourceWith(#dataSourceId: String) -> HTTPStatusCode? {
        return self.dataSource.deleteDataSourceWith(dataSourceId: dataSourceId)
    }
    
    func dataSourceWith(#dataSourceId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return self.dataSource.dataSourceWith(dataSourceId: dataSourceId)
    }
    
    func searchDataSourcesBy(#name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, resourcesData: NSDictionary?) {
        return self.dataSource.searchDataSourcesBy(name: name, offset: offset, limit: limit)
    }
    
    func dataSourceIsReadyWith(#dataSourceId: String) -> Bool {
        return self.dataSource.dataSourceIsReadyWith(dataSourceId: dataSourceId)
    }
    
    /**
     * ASYNCHRONOUS OPERATIONS
     */
    
    func asyncCreateDataSourceWith(#name: String, filePath: String) {
        self.operationQueue.addOperationWithBlock({
            let result = self.dataSource.createDataSourceWith(name: name, filePath: filePath)
            
            self.delegate?.dataSourceCreatedWith(statusCode: result.statusCode, resourceId: result.resourceId, dataSourceData: result.resourceData)
        })
    }
    
    func asyncUpdateDataSourceNameWith(#dataSourceId: String, name: String?) {
        self.operationQueue.addOperationWithBlock({
            let result = self.dataSource.updateDataSourceNameWith(dataSourceId: dataSourceId, name: name)
            
            self.delegate?.dataSourceUpdatedWith(statusCode: result)
        })
    }
    
    func asyncDeleteDataSourceWith(#dataSourceId: String) {
        self.operationQueue.addOperationWithBlock({
            let result = self.dataSource.deleteDataSourceWith(dataSourceId: dataSourceId)
            
            self.delegate?.dataSourceDeletedWith(statusCode: result)
        })
    }
    
    func asyncDataSourceWith(#dataSourceId: String) {
        self.operationQueue.addOperationWithBlock({
            let result = self.dataSource.dataSourceWith(dataSourceId: dataSourceId)
            
            self.delegate?.dataSourceRetrievedWith(statusCode: result.statusCode, resourceId: result.resourceId, dataSourceData: result.resourceData)
        })
    }
    
    func asyncDataSourcesBy(#name: String?, offset: Int, limit: Int) {
        self.operationQueue.addOperationWithBlock({
            let result = self.dataSource.searchDataSourcesBy(name: name, offset: offset, limit: limit)
            
            self.delegate?.dataSourcesRetrievedWith(statusCode: result.statusCode, dataSourcesData: result.resourcesData)
        })
    }
    
    func asyncDataSourceIsReadyWith(#dataSourceId: String) {
        self.operationQueue.addOperationWithBlock({
            let result = self.dataSource.dataSourceIsReadyWith(dataSourceId: dataSourceId)
            
            self.delegate?.dataSourceIsReadyWith(status: result)
        })
        
        return
    }
    
    //******************************************************************************************
    //************************************** DATASETS ******************************************
    //************************ https://bigml.com/developers/datasets ***************************
    //******************************************************************************************
    
    /**
     * SYNCHRONOUS OPERATIONS
     */
    
    func createDataSetWith(#dataSourceId: String, name: String?) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return self.dataSet.createDataSetWith(dataSourceId: dataSourceId, name: name)
    }
    
    func updateDataSetNameWith(#dataSetId: String, name: String?) -> HTTPStatusCode? {
        return self.dataSet.updateDataSetNameWith(dataSetId: dataSetId, name: name)
    }

    func deleteDataSetWith(#dataSetId: String) -> HTTPStatusCode? {
        return self.dataSet.deleteDataSetWith(dataSetId: dataSetId)
    }
    
    func dataSetWith(#dataSetId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return self.dataSet.dataSetWith(dataSetId: dataSetId)
    }
    
    func searchDataSetsBy(#name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, resourcesData: NSDictionary?) {
        return self.dataSet.searchDataSetsBy(name: name, offset: offset, limit: limit)
    }
    
    func dataSetIsReadyWith(#dataSetId: String) -> Bool {
        return self.dataSet.dataSetIsReadyWith(dataSetId: dataSetId)
    }
    
    /**
     * ASYNCHRONOUS OPERATIONS
     */
    
    func asyncCreateDataSetWith(#dataSourceId: String, name: String?) {
        self.operationQueue.addOperationWithBlock({
            let result = self.dataSet.createDataSetWith(dataSourceId: dataSourceId, name: name)
            
            self.delegate?.dataSetCreatedWith(statusCode: result.statusCode, resourceId: result.resourceId, dataSetData: result.resourceData)
        })
    }
    
    func asyncUpdateDataSetNameWith(#dataSetId: String, name: String?) {
        self.operationQueue.addOperationWithBlock({
            let result = self.dataSet.updateDataSetNameWith(dataSetId: dataSetId, name: name)
            
            self.delegate?.dataSetUpdatedWith(statusCode: result)
        })
    }
    
    func asyncDeleteDataSetWith(#dataSetId: String) {
        self.operationQueue.addOperationWithBlock({
            let result = self.dataSet.deleteDataSetWith(dataSetId: dataSetId)
            
            self.delegate?.dataSetDeletedWith(statusCode: result)
        })
    }
    
    func asyncDataSetAsyncWith(#dataSetId: String) {
        self.operationQueue.addOperationWithBlock({
            let result = self.dataSet.dataSetWith(dataSetId: dataSetId)
            
            self.delegate?.dataSetRetrievedWith(statusCode: result.statusCode, resourceId: result.resourceId, dataSetData: result.resourceData)
        })
    }
    
    func asyncSearchDataSetsBy(#name: String?, offset: Int, limit: Int) {
        self.operationQueue.addOperationWithBlock({
            let result = self.dataSet.searchDataSetsBy(name: name, offset: offset, limit: limit)
            
            self.delegate?.dataSetsRetrievedWith(statusCode: result.statusCode, dataSetsData: result.resourcesData)
        
        })
    }
    
    func asyncDataSetIsReadyWith(#dataSetId: String) {
        self.operationQueue.addOperationWithBlock({
            let result = self.dataSet.dataSetIsReadyWith(dataSetId: dataSetId)
            
            self.delegate?.dataSetIsReadyWith(status: result)
        })
    }
    
    //******************************************************************************************
    //*************************************** MODELS *******************************************
    //************************* https://bigml.com/developers/models ****************************
    //******************************************************************************************
    
    /**
     * SYNCHRONOUS OPERATIONS
     */
    
    func createModelWith(#dataSetId: String, name: String?) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return self.model.createModelWith(dataSetId: dataSetId, name: name)
    }
    
    func updateModelNameWith(#modelId: String, name: String?) -> HTTPStatusCode? {
        return self.model.updateModelNameWith(modelId: modelId, name: name)
    }
    
    func deleteModelWith(#modelId: String) -> HTTPStatusCode? {
        return self.model.deleteModelWith(modelId: modelId)
    }
    
    func modelWith(#modelId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return self.model.modelWith(modelId: modelId)
    }
    
    func searchModelsBy(#name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, resourcesData: NSDictionary?) {
        return self.model.searchModelsBy(name: name, offset: offset, limit: limit)
    }
    
    func modelIsReadyWith(#modelId: String) -> Bool {
        return self.model.modelIsReadyWith(modelId: modelId)
    }
    
    /**
     * ASYNCHRONOUS OPERATIONS
     */
    
    func asyncCreateModelWith(#dataSetId: String, name: String?) {
        self.operationQueue.addOperationWithBlock({
            let result = self.model.createModelWith(dataSetId: dataSetId, name: name)
            
            self.delegate?.modelCreatedWith(statusCode: result.statusCode, resourceId: result.resourceId, modelData: result.resourceData)
        })
    }
    
    func asyncUpdateModelNameWith(#modelId: String, name: String?) {
        self.operationQueue.addOperationWithBlock({
            let result = self.model.updateModelNameWith(modelId: modelId, name: name)
            
            self.delegate?.modelUpdatedWith(statusCode: result)
        })
    }
    
    func asyncDeleteModelWith(#modelId: String) {
        self.operationQueue.addOperationWithBlock({
            let result = self.model.deleteModelWith(modelId: modelId)
            
            self.delegate?.modelDeletedWith(statusCode: result)
        })
    }
    
    func asyncModelWith(#modelId: String) {
        self.operationQueue.addOperationWithBlock({
            let result = self.model.modelWith(modelId: modelId)
            
            self.delegate?.modelRetrievedWith(statusCode: result.statusCode, resourceId: result.resourceId, modelData: result.resourceData)
        })
    }
    
    func asyncSearchModelsBy(#name: String?, offset: Int, limit: Int) {
        self.operationQueue.addOperationWithBlock({
            let result = self.model.searchModelsBy(name: name, offset: offset, limit: limit)
            
            self.delegate?.modelsRetrievedWith(statusCode: result.statusCode, modelsData: result.resourcesData)
        })
    }
    
    func asyncModelIsReadyWith(#modelId: String) {
        self.operationQueue.addOperationWithBlock({
            let result = self.model.modelIsReadyWith(modelId: modelId)
            
            self.delegate?.modelIsReadyWith(status: result)
        })
    }
    
    //******************************************************************************************
    //************************************* PREDICTIONS ****************************************
    //*********************** https://bigml.com/developers/predictions *************************
    //******************************************************************************************
    
    /**
     * SYNCHRONOUS OPERATIONS
     */
    
    func createPredictionWith(#modelId: String, name: String?, inputData: String?) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return self.prediction.createPredictionWith(modelId: modelId, name: name, inputData: inputData)
    }
    
    func updatePredictionNameWith(#predictionId: String, name: String?) -> HTTPStatusCode? {
        return self.prediction.updatePredictionNameWith(predictionId: predictionId, name: name)
    }
    
    func deletePredictionWith(#predictionId: String) -> HTTPStatusCode? {
        return self.prediction.deletePredictionWith(predictionId: predictionId)
    }
    
    func predictionWith(#predictionId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return self.prediction.predictionWith(predictionId: predictionId)
    }
    
    func searchPredictionsBy(#name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, resourcesData: NSDictionary?) {
        return self.prediction.searchPredictionsBy(name: name, offset: offset, limit: limit)
    }
    
    func predictionIsReadyWith(#predictionId: String) -> Bool {
        return self.prediction.predictionIsReadyWith(predictionId: predictionId)
    }
    
    /**
     * ASYNCHRONOUS OPERATIONS
     */
    
    func asyncCreatePredictionWith(#modelId: String, name: String?, inputData: String?) {
        self.operationQueue.addOperationWithBlock({
            let result = self.prediction.createPredictionWith(modelId: modelId, name: name, inputData: inputData)
            
            self.delegate?.predictionCreatedWith(statusCode: result.statusCode, resourceId: result.resourceId, predictionData: result.resourceData)
        })
    }
    
    func asyncUpdatePredictionNameWith(#predictionId: String, name: String?) {
        self.operationQueue.addOperationWithBlock({
            let result = self.prediction.updatePredictionNameWith(predictionId: predictionId, name: name)
            
            self.delegate?.predictionUpdatedWith(statusCode: result)
        })
    }
    
    func asyncDeletePredictionWith(#predictionId: String) {
        self.operationQueue.addOperationWithBlock({
            let result = self.prediction.deletePredictionWith(predictionId: predictionId)
            
            self.delegate?.predictionDeletedWith(statusCode: result)
        })
    }
    
    func asyncPredictionWith(#predictionId: String) {
        self.operationQueue.addOperationWithBlock({
            let result = self.prediction.predictionWith(predictionId: predictionId)
            
            self.delegate?.predictionRetrievedWith(statusCode: result.statusCode, resourceId: result.resourceId, predictionData: result.resourceData)
        })
    }
    
    func asyncSearchPredictionsBy(#name: String?, offset: Int, limit: Int) {
        self.operationQueue.addOperationWithBlock({
            let result = self.prediction.searchPredictionsBy(name: name, offset: offset, limit: limit)
            
            self.delegate?.predictionsRetrievedWith(statusCode: result.statusCode, predictionsData: result.resourcesData)
        })
    }
    
    func asyncPredictionIsReadyWith(#predictionId: String) {
        self.operationQueue.addOperationWithBlock({
            let result = self.prediction.predictionIsReadyWith(predictionId: predictionId)
            
            self.delegate?.predictionIsReadyWith(status: result)
        })
    }
}