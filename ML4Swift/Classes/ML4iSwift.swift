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

public class ML4Swift
{
    // MARK: - Properties
    
    private lazy var dataSource = DataSource()
    private lazy var dataSet = DataSet()
    private lazy var model = Model()
    private lazy var prediction = Prediction()
    private lazy var cluster = Cluster()
    
    /*!
     * Async Operations Queue
     */
    private let operationQueue = OperationQueue()
    
    /*!
     * Async Operations callback events
     */
    public weak var delegate: ML4SwiftDelegate?
    
    //******************************************************************************************
    //*************************** INITIALIZERS AND PUBLIC METHODS ******************************
    //******************************************************************************************
    
    // MARK: - Initializers and public methods
    
    public init(apiUsername: String, apiKey: String, developmentMode: Bool, delegate: ML4SwiftDelegate?) {
        DataManager.sharedInstance.initializeWith(apiUsername: apiUsername, apiKey: apiKey, developmentMode: developmentMode);
        
        self.delegate = delegate;
    }
    
    deinit {
        self.operationQueue.cancelAllOperations()
    }
    
    public func cancellAllAsyncOperations() {
        self.operationQueue.cancelAllOperations();
    }
    
    public func printFrameworkData(){
        print("")
        
        DataManager.sharedInstance.printCredentials()
    }
    
    //******************************************************************************************
    //************************************ DATASOURCES *****************************************
    //************************ https://bigml.com/developers/sources ****************************
    //******************************************************************************************
    
    // MARK: - DataSources
    
    /**
     * SYNCHRONOUS DATASOURCE OPERATIONS
     */
    
    public func createDataSourceWith(name: String, filePath: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, dataSourceData: NSDictionary?) {
        return self.dataSource.createDataSourceWith(name: name, filePath: filePath)
    }
    
    public func updateDataSourceNameWith(dataSourceId: String, name: String?) -> HTTPStatusCode? {
        return self.dataSource.updateDataSourceNameWith(dataSourceId: dataSourceId, name: name)
    }
    
    public func deleteDataSourceWith(dataSourceId: String) -> HTTPStatusCode? {
        return self.dataSource.deleteDataSourceWith(dataSourceId: dataSourceId)
    }
    
    public func dataSourceWith(dataSourceId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, dataSourceData: NSDictionary?) {
        return self.dataSource.dataSourceWith(dataSourceId: dataSourceId)
    }
    
    public func searchDataSourcesBy(name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, dataSourceListData: NSDictionary?) {
        return self.dataSource.searchDataSourcesBy(name: name, offset: offset, limit: limit)
    }
    
    public func dataSourceIsReadyWith(dataSourceId: String) -> Bool {
        return self.dataSource.dataSourceIsReadyWith(dataSourceId: dataSourceId)
    }
    
    /**
     * ASYNCHRONOUS DATASOURCE OPERATIONS
     */
    
    public func asyncCreateDataSourceWith(name: String, filePath: String) {
        self.operationQueue.addOperation({
            let result = self.dataSource.createDataSourceWith(name: name, filePath: filePath)
            
            self.delegate?.dataSourceCreatedWith(statusCode: result.statusCode, resourceId: result.resourceId, dataSourceData: result.dataSourceData)
        })
    }
    
    public func asyncUpdateDataSourceNameWith(dataSourceId: String, name: String?) {
        self.operationQueue.addOperation({
            let result = self.dataSource.updateDataSourceNameWith(dataSourceId: dataSourceId, name: name)
            
            self.delegate?.dataSourceUpdatedWith(statusCode: result)
        })
    }
    
    public func asyncDeleteDataSourceWith(dataSourceId: String) {
        self.operationQueue.addOperation({
            let result = self.dataSource.deleteDataSourceWith(dataSourceId: dataSourceId)
            
            self.delegate?.dataSourceDeletedWith(statusCode: result)
        })
    }
    
    public func asyncDataSourceWith(dataSourceId: String) {
        self.operationQueue.addOperation({
            let result = self.dataSource.dataSourceWith(dataSourceId: dataSourceId)
            
            self.delegate?.dataSourceRetrievedWith(statusCode: result.statusCode, resourceId: result.resourceId, dataSourceData: result.dataSourceData)
        })
    }
    
    public func asyncSearchDataSourcesBy(name: String?, offset: Int, limit: Int) {
        self.operationQueue.addOperation({
            let result = self.dataSource.searchDataSourcesBy(name: name, offset: offset, limit: limit)
            
            self.delegate?.dataSourcesRetrievedWith(statusCode: result.statusCode, dataSourceListData: result.dataSourceListData)
        })
    }
    
    public func asyncDataSourceIsReadyWith(dataSourceId: String) {
        self.operationQueue.addOperation({
            let result = self.dataSource.dataSourceIsReadyWith(dataSourceId: dataSourceId)
            
            self.delegate?.dataSourceIsReadyWith(status: result)
        })
        
        return
    }
    
    //******************************************************************************************
    //************************************** DATASETS ******************************************
    //************************ https://bigml.com/developers/datasets ***************************
    //******************************************************************************************
    
    // MARK: - DataSets
    
    /**
     * SYNCHRONOUS DATASET OPERATIONS
     */
    
    public func createDataSetWith(dataSourceId: String, name: String?) -> (statusCode: HTTPStatusCode?, resourceId: String?, dataSetData: NSDictionary?) {
        return self.dataSet.createDataSetWith(dataSourceId: dataSourceId, name: name)
    }
    
    public func updateDataSetNameWith(dataSetId: String, name: String?) -> HTTPStatusCode? {
        return self.dataSet.updateDataSetNameWith(dataSetId: dataSetId, name: name)
    }

    public func deleteDataSetWith(dataSetId: String) -> HTTPStatusCode? {
        return self.dataSet.deleteDataSetWith(dataSetId: dataSetId)
    }
    
    public func dataSetWith(dataSetId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, dataSetData: NSDictionary?) {
        return self.dataSet.dataSetWith(dataSetId: dataSetId)
    }
    
    public func searchDataSetsBy(name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, dataSetListData: NSDictionary?) {
        return self.dataSet.searchDataSetsBy(name: name, offset: offset, limit: limit)
    }
    
    public func dataSetIsReadyWith(dataSetId: String) -> Bool {
        return self.dataSet.dataSetIsReadyWith(dataSetId: dataSetId)
    }
    
    /**
     * ASYNCHRONOUS DATASET OPERATIONS
     */
    
    public func asyncCreateDataSetWith(dataSourceId: String, name: String?) {
        self.operationQueue.addOperation({
            let result = self.dataSet.createDataSetWith(dataSourceId: dataSourceId, name: name)
            
            self.delegate?.dataSetCreatedWith(statusCode: result.statusCode, resourceId: result.resourceId, dataSetData: result.dataSetData)
        })
    }
    
    public func asyncUpdateDataSetNameWith(dataSetId: String, name: String?) {
        self.operationQueue.addOperation({
            let result = self.dataSet.updateDataSetNameWith(dataSetId: dataSetId, name: name)
            
            self.delegate?.dataSetUpdatedWith(statusCode: result)
        })
    }
    
    public func asyncDeleteDataSetWith(dataSetId: String) {
        self.operationQueue.addOperation({
            let result = self.dataSet.deleteDataSetWith(dataSetId: dataSetId)
            
            self.delegate?.dataSetDeletedWith(statusCode: result)
        })
    }
    
    public func asyncDataSetWith(dataSetId: String) {
        self.operationQueue.addOperation({
            let result = self.dataSet.dataSetWith(dataSetId: dataSetId)
            
            self.delegate?.dataSetRetrievedWith(statusCode: result.statusCode, resourceId: result.resourceId, dataSetData: result.dataSetData)
        })
    }
    
    public func asyncSearchDataSetsBy(name: String?, offset: Int, limit: Int) {
        self.operationQueue.addOperation({
            let result = self.dataSet.searchDataSetsBy(name: name, offset: offset, limit: limit)
            
            self.delegate?.dataSetsRetrievedWith(statusCode: result.statusCode, dataSetListData: result.dataSetListData)
        
        })
    }
    
    public func asyncDataSetIsReadyWith(dataSetId: String) {
        self.operationQueue.addOperation({
            let result = self.dataSet.dataSetIsReadyWith(dataSetId: dataSetId)
            
            self.delegate?.dataSetIsReadyWith(status: result)
        })
    }
    
    //******************************************************************************************
    //*************************************** MODELS *******************************************
    //************************* https://bigml.com/developers/models ****************************
    //******************************************************************************************
    
    // MARK: - Models
    
    /**
     * SYNCHRONOUS MODEL OPERATIONS
     */
    
    public func createModelWith(dataSetId: String, name: String?) -> (statusCode: HTTPStatusCode?, resourceId: String?, modelData: NSDictionary?) {
        return self.model.createModelWith(dataSetId: dataSetId, name: name)
    }
    
    public func updateModelNameWith(modelId: String, name: String?) -> HTTPStatusCode? {
        return self.model.updateModelNameWith(modelId: modelId, name: name)
    }
    
    public func deleteModelWith(modelId: String) -> HTTPStatusCode? {
        return self.model.deleteModelWith(modelId: modelId)
    }
    
    public func modelWith(modelId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, modelData: NSDictionary?) {
        return self.model.modelWith(modelId: modelId)
    }
    
    public func searchModelsBy(name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, modelListData: NSDictionary?) {
        return self.model.searchModelsBy(name: name, offset: offset, limit: limit)
    }
    
    public func modelIsReadyWith(modelId: String) -> Bool {
        return self.model.modelIsReadyWith(modelId: modelId)
    }
    
    /**
     * ASYNCHRONOUS MODEL OPERATIONS
     */
    
    public func asyncCreateModelWith(dataSetId: String, name: String?) {
        self.operationQueue.addOperation({
            let result = self.model.createModelWith(dataSetId: dataSetId, name: name)
            
            self.delegate?.modelCreatedWith(statusCode: result.statusCode, resourceId: result.resourceId, modelData: result.modelData)
        })
    }
    
    public func asyncUpdateModelNameWith(modelId: String, name: String?) {
        self.operationQueue.addOperation({
            let result = self.model.updateModelNameWith(modelId: modelId, name: name)
            
            self.delegate?.modelUpdatedWith(statusCode: result)
        })
    }
    
    public func asyncDeleteModelWith(modelId: String) {
        self.operationQueue.addOperation({
            let result = self.model.deleteModelWith(modelId: modelId)
            
            self.delegate?.modelDeletedWith(statusCode: result)
        })
    }
    
    public func asyncModelWith(modelId: String) {
        self.operationQueue.addOperation({
            let result = self.model.modelWith(modelId: modelId)
            
            self.delegate?.modelRetrievedWith(statusCode: result.statusCode, resourceId: result.resourceId, modelData: result.modelData)
        })
    }
    
    public func asyncSearchModelsBy(name: String?, offset: Int, limit: Int) {
        self.operationQueue.addOperation({
            let result = self.model.searchModelsBy(name: name, offset: offset, limit: limit)
            
            self.delegate?.modelsRetrievedWith(statusCode: result.statusCode, modelListData: result.modelListData)
        })
    }
    
    public func asyncModelIsReadyWith(modelId: String) {
        self.operationQueue.addOperation({
            let result = self.model.modelIsReadyWith(modelId: modelId)
            
            self.delegate?.modelIsReadyWith(status: result)
        })
    }
    
    //******************************************************************************************
    //************************************* PREDICTIONS ****************************************
    //*********************** https://bigml.com/developers/predictions *************************
    //******************************************************************************************
    
    // MARK: - Predictions
    
    /**
     * SYNCHRONOUS PREDICTION OPERATIONS
     */
    
    public func createPredictionWith(modelId: String, name: String?, inputData: String?) -> (statusCode: HTTPStatusCode?, resourceId: String?, predictionData: NSDictionary?) {
        return self.prediction.createPredictionWith(modelId: modelId, name: name, inputData: inputData)
    }
    
    public func updatePredictionNameWith(predictionId: String, name: String?) -> HTTPStatusCode? {
        return self.prediction.updatePredictionNameWith(predictionId: predictionId, name: name)
    }
    
    public func deletePredictionWith(predictionId: String) -> HTTPStatusCode? {
        return self.prediction.deletePredictionWith(predictionId: predictionId)
    }
    
    public func predictionWith(predictionId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, predictionData: NSDictionary?) {
        return self.prediction.predictionWith(predictionId: predictionId)
    }
    
    public func searchPredictionsBy(name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, predictionListData: NSDictionary?) {
        return self.prediction.searchPredictionsBy(name: name, offset: offset, limit: limit)
    }
    
    public func predictionIsReadyWith(predictionId: String) -> Bool {
        return self.prediction.predictionIsReadyWith(predictionId: predictionId)
    }
    
    /**
     * ASYNCHRONOUS PREDICTION OPERATIONS
     */
    
    public func asyncCreatePredictionWith(modelId: String, name: String?, inputData: String?) {
        self.operationQueue.addOperation({
            let result = self.prediction.createPredictionWith(modelId: modelId, name: name, inputData: inputData)
            
            self.delegate?.predictionCreatedWith(statusCode: result.statusCode, resourceId: result.resourceId, predictionData: result.predictionData)
        })
    }
    
    public func asyncUpdatePredictionNameWith(predictionId: String, name: String?) {
        self.operationQueue.addOperation({
            let result = self.prediction.updatePredictionNameWith(predictionId: predictionId, name: name)
            
            self.delegate?.predictionUpdatedWith(statusCode: result)
        })
    }
    
    public func asyncDeletePredictionWith(predictionId: String) {
        self.operationQueue.addOperation({
            let result = self.prediction.deletePredictionWith(predictionId: predictionId)
            
            self.delegate?.predictionDeletedWith(statusCode: result)
        })
    }
    
    public func asyncPredictionWith(predictionId: String) {
        self.operationQueue.addOperation({
            let result = self.prediction.predictionWith(predictionId: predictionId)
            
            self.delegate?.predictionRetrievedWith(statusCode: result.statusCode, resourceId: result.resourceId, predictionData: result.predictionData)
        })
    }
    
    public func asyncSearchPredictionsBy(name: String?, offset: Int, limit: Int) {
        self.operationQueue.addOperation({
            let result = self.prediction.searchPredictionsBy(name: name, offset: offset, limit: limit)
            
            self.delegate?.predictionsRetrievedWith(statusCode: result.statusCode, predictionListData: result.predictionListData)
        })
    }
    
    public func asyncPredictionIsReadyWith(predictionId: String) {
        self.operationQueue.addOperation({
            let result = self.prediction.predictionIsReadyWith(predictionId: predictionId)
            
            self.delegate?.predictionIsReadyWith(status: result)
        })
    }
    
    //******************************************************************************************
    //************************************** CLUSTERS ******************************************
    //************************ https://bigml.com/developers/clusters ***************************
    //******************************************************************************************
    
    // MARK: - Clusters
    
    /**
     * SYNCHRONOUS CLUSTER OPERATIONS
     */
    
    public func createClusterWith(dataSetId: String, name: String?, numberOfClusters: Int? = 8) -> (statusCode: HTTPStatusCode?, resourceId: String?, clusterData: NSDictionary?) {
        return self.cluster.createClusterWith(dataSetId: dataSetId, name: name, numberOfClusters: numberOfClusters)
    }
    
    public func updateClusterNameWith(clusterId: String, name: String?) -> HTTPStatusCode? {
        return self.cluster.updateClusterNameWith(clusterId: clusterId, name: name)
    }
    
    public func deleteClusterWith(clusterId: String) -> HTTPStatusCode? {
        return self.cluster.deleteClusterWith(clusterId: clusterId)
    }
    
    public func clusterWith(clusterId: String) -> (statusCode: HTTPStatusCode?, resourceId: String?, clusterData: NSDictionary?) {
        return self.cluster.clusterWith(clusterId: clusterId)
    }
    
    public func searchClustersBy(name: String?, offset: Int, limit: Int) -> (statusCode: HTTPStatusCode?, clusterListData: NSDictionary?) {
        return self.cluster.searchClustersBy(name: name, offset: offset, limit: limit)
    }
    
    public func clusterIsReadyWith(clusterId: String) -> Bool {
        return self.cluster.clusterIsReadyWith(clusterId: clusterId)
    }
    
    /**
     * ASYNCHRONOUS CLUSTER OPERATIONS
     */
    
    public func asyncCreateClusterWith(dataSetId: String, name: String?, numberOfClusters: Int? = 8) {
        self.operationQueue.addOperation({
            let result = self.cluster.createClusterWith(dataSetId: dataSetId, name: name, numberOfClusters: numberOfClusters)
            
            self.delegate?.clusterCreatedWith(statusCode: result.statusCode, resourceId: result.resourceId, clusterData: result.clusterData)
            })
    }
    
    public func asyncUpdateClusterNameWith(clusterId: String, name: String?) {
        self.operationQueue.addOperation({
            let result = self.cluster.updateClusterNameWith(clusterId: clusterId, name: name)
            
            self.delegate?.modelUpdatedWith(statusCode: result)
            })
    }
    
    public func asyncDeleteClusterWith(clusterId: String) {
        self.operationQueue.addOperation({
            let result = self.cluster.deleteClusterWith(clusterId: clusterId)
            
            self.delegate?.modelDeletedWith(statusCode: result)
            })
    }
    
    public func asyncClusterWith(clusterId: String) {
        self.operationQueue.addOperation({
            let result = self.cluster.clusterWith(clusterId: clusterId)
            
            self.delegate?.modelRetrievedWith(statusCode: result.statusCode, resourceId: result.resourceId, modelData: result.clusterData)
            })
    }
    
    public func asyncSearchClustersBy(name: String?, offset: Int, limit: Int) {
        self.operationQueue.addOperation({
            let result = self.cluster.searchClustersBy(name: name, offset: offset, limit: limit)
            
            self.delegate?.clustersRetrievedWith(statusCode: result.statusCode, clusterListData: result.clusterListData)
            })
    }
    
    public func asyncClusterIsReadyWith(clusterId: String) {
        self.operationQueue.addOperation({
            let result = self.cluster.clusterIsReadyWith(clusterId: clusterId)
            
            self.delegate?.modelIsReadyWith(status: result)
            })
    }
}
