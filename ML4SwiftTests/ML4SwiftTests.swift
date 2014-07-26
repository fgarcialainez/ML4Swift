/**
 *
 * ML4SwiftTests.swift
 * ML4SwiftTests
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

import XCTest

class ML4SwiftTests: XCTestCase, ML4SwiftDelegate
{
    var library: ML4Swift!
    
    // Used to implement a Semaphore
    var expectation: XCTestExpectation?

    var resultDataSourceIdAsync: NSString?
    var resultDataSetIdAsync: NSString?
    var resultModelIdAsync: NSString?
    var resultPredictionIdAsync: NSString?
    
    //******************************************************************************************
    //*********************************** OVERRIDEN METHODS ************************************
    //******************************************************************************************
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.library = ML4Swift(apiUsername: "felixksp", apiKey: "9236b5c57063074edadc7baa25602a6360fc3872", developmentMode: false, delegate: self)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //******************************************************************************************
    //*************************** UTILITY METHODS FOR ASYNC OPERATIONS *************************
    //******************************************************************************************
    
    func waitForAsyncOperation(timeout: NSTimeInterval = 30) {
        
        if !self.expectation {
            self.expectation = self.expectationWithDescription("ASYNCHRONOUS_OPERATION")
            self.waitForExpectationsWithTimeout(timeout, nil)
        }
    }
    
    func signalForAsyncOperation() {
        if self.expectation {
            self.expectation!.fulfill()
            self.expectation = nil
        }
    }
    
    func testML4SwiftSyncOperations() {
        //******************************************************************************************
        //************************************** CREATE METHODS ************************************
        //******************************************************************************************
        
        // Create DataSource from iris.csv
        let path = NSBundle(forClass: ML4SwiftTests.self).pathForResource("iris", ofType: "csv")
        let resultDataSource = self.library.createDataSourceWith(name: "My DataSource", filePath: path)
        
        XCTAssertTrue(resultDataSource.statusCode != nil && resultDataSource.statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating DataSource - Invalid status code returned")
        XCTAssertTrue(resultDataSource.resourceId != nil, "Error creating DataSource - Invalid resourceId returned")
        XCTAssertTrue(resultDataSource.resourceData != nil, "Error creating DataSource - Invalid resourceData returned")
        
        // Optional Binding
        if let dataSourceIdValue = resultDataSource.resourceId {
            // Wait while DataSource is ready
            while !self.library.dataSourceIsReadyWith(dataSourceId: dataSourceIdValue) {
                sleep(3)
            }
        
            // Create DataSet from DataSource Identifier
            let resultDataSet = self.library.createDataSetWith(dataSourceId: dataSourceIdValue, name: "My DataSet")
        
            XCTAssertTrue(resultDataSet.statusCode != nil && resultDataSet.statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating DataSet - Invalid status code returned")
            XCTAssertTrue(resultDataSet.resourceId != nil, "Error creating DataSet - Invalid resourceId returned")
            XCTAssertTrue(resultDataSet.resourceData != nil, "Error creating DataSet - Invalid resourceData returned")
            
            // Optional Binding
            if let dataSetIdValue = resultDataSet.resourceId {
                // Wait while DataSet is ready
                while !self.library.dataSetIsReadyWith(dataSetId: dataSetIdValue) {
                    sleep(3)
                }
        
                // Create Model from DataSet Identifier
                let resultModel = self.library.createModelWith(dataSetId: dataSetIdValue, name: "My Model")
        
                XCTAssertTrue(resultModel.statusCode != nil && resultModel.statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating Model - Invalid status code returned")
                XCTAssertTrue(resultModel.resourceId != nil, "Error creating Model - Invalid resourceId returned")
                XCTAssertTrue(resultModel.resourceData != nil, "Error creating Model - Invalid resourceData returned")
        
                // Optional Binding
                if let modelIdValue = resultModel.resourceId {
                    // Wait while Model is ready
                    while !self.library.modelIsReadyWith(modelId: modelIdValue) {
                        sleep(3)
                    }
        
                    // Create Prediction from Model Identifier
                    let inputDataForPrediction = "{\"000000\": 3, \"000001\": 2, \"000002\": 1, \"000003\": 1}"
                    let resultPrediction = self.library.createPredictionWith(modelId: modelIdValue, name: "My Prediction", inputData: inputDataForPrediction)
        
                    XCTAssertTrue(resultPrediction.statusCode != nil && resultPrediction.statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating Prediction - Invalid status code returned")
                    XCTAssertTrue(resultPrediction.resourceId != nil, "Error creating Prediction - Invalid resourceId returned")
                    XCTAssertTrue(resultPrediction.resourceData != nil, "Error creating Prediction - Invalid resourceData returned")
        
                    // Optional Binding
                    if let predictionIdValue = resultPrediction.resourceId {
                        // Wait while Prediction is ready
                        while !self.library.predictionIsReadyWith(predictionId: predictionIdValue) {
                            sleep(3)
                        }
        
                        //******************************************************************************************
                        //********************************** PREDICTION OPERATIONS *********************************
                        //******************************************************************************************
        
                        // Retrieve created Prediction
                        let retrievedPrediction = self.library.predictionWith(predictionId: predictionIdValue)
        
                        XCTAssertTrue(retrievedPrediction.statusCode != nil && retrievedPrediction.statusCode == HTTPStatusCode.HTTP_OK, "Error retrieving Prediction - Invalid status code returned")
                        XCTAssertTrue(retrievedPrediction.resourceId != nil, "Error retrieving Prediction - Invalid resourceId returned")
                        XCTAssertTrue(retrievedPrediction.resourceData != nil, "Error retrieving Prediction - Invalid resourceData returned")
        
                        // Search for Predictions
                        let predictions = self.library.searchDataSourcesBy(name: "My Prediction", offset: 0, limit: 15)
        
                        XCTAssertTrue(predictions.statusCode != nil && predictions.statusCode == HTTPStatusCode.HTTP_OK, "Error searching for Predictions - Invalid status code returned")
                        XCTAssertTrue(predictions.resourcesData != nil, "Error searching for Predictions - Invalid resourceData returned")
        
                        // Update Prediction name
                        let statusUpdatePrediction = self.library.updatePredictionNameWith(predictionId: predictionIdValue, name: "My Prediction Updated")
                        XCTAssertTrue(statusUpdatePrediction != nil && statusUpdatePrediction == HTTPStatusCode.HTTP_ACCEPTED, "Error updating Prediction")
        
                        // Delete Created Prediction
                        let statusDeletePrediction = self.library.deletePredictionWith(predictionId: predictionIdValue)
                        XCTAssertTrue(statusDeletePrediction != nil && statusDeletePrediction == HTTPStatusCode.HTTP_NO_CONTENT, "Error deleting Prediction")
                    }
                    
                    //******************************************************************************************
                    //************************************* MODEL OPERATIONS ***********************************
                    //******************************************************************************************
                    
                    // Retrieve created Model
                    let retrievedModel = self.library.modelWith(modelId: modelIdValue)
                    
                    XCTAssertTrue(retrievedModel.statusCode != nil && retrievedModel.statusCode == HTTPStatusCode.HTTP_OK, "Error retrieving Model - Invalid status code returned")
                    XCTAssertTrue(retrievedModel.resourceId != nil, "Error retrieving Model - Invalid resourceId returned")
                    XCTAssertTrue(retrievedModel.resourceData != nil, "Error retrieving Model - Invalid resourceData returned")
                    
                    // Search for Models
                    let models = self.library.searchDataSourcesBy(name: "My Model", offset: 0, limit: 15)
                    
                    XCTAssertTrue(models.statusCode != nil && models.statusCode == HTTPStatusCode.HTTP_OK, "Error searching for Models - Invalid status code returned")
                    XCTAssertTrue(models.resourcesData != nil, "Error searching for Models - Invalid resourceData returned")
                    
                    // Update Model name
                    let statusUpdateModel = self.library.updateModelNameWith(modelId: modelIdValue, name: "My Model Updated")
                    XCTAssertTrue(statusUpdateModel != nil && statusUpdateModel == HTTPStatusCode.HTTP_ACCEPTED, "Error updating Model")
                    
                    // Delete Created Model
                    let statusDeleteModel = self.library.deleteModelWith(modelId: modelIdValue)
                    XCTAssertTrue(statusDeleteModel != nil && statusDeleteModel == HTTPStatusCode.HTTP_NO_CONTENT, "Error deleting Model")
                }
                
                //******************************************************************************************
                //************************************ DATASET OPERATIONS **********************************
                //******************************************************************************************
                
                // Retrieve created DataSet
                let retrievedDataSet = self.library.dataSetWith(dataSetId: dataSetIdValue)
                
                XCTAssertTrue(retrievedDataSet.statusCode != nil && retrievedDataSet.statusCode == HTTPStatusCode.HTTP_OK, "Error retrieving DataSet - Invalid status code returned")
                XCTAssertTrue(retrievedDataSet.resourceId != nil, "Error retrieving DataSet - Invalid resourceId returned")
                XCTAssertTrue(retrievedDataSet.resourceData != nil, "Error retrieving DataSet - Invalid resourceData returned")
                
                // Search for DataSets
                let dataSets = self.library.searchDataSourcesBy(name: "My DataSet", offset: 0, limit: 15)
                
                XCTAssertTrue(dataSets.statusCode != nil && dataSets.statusCode == HTTPStatusCode.HTTP_OK, "Error searching for DataSets - Invalid status code returned")
                XCTAssertTrue(dataSets.resourcesData != nil, "Error searching for DataSets - Invalid resourceData returned")
                
                // Update DataSet name
                let statusUpdateDataSet = self.library.updateDataSetNameWith(dataSetId: dataSetIdValue, name: "My DataSet Updated")
                XCTAssertTrue(statusUpdateDataSet != nil && statusUpdateDataSet == HTTPStatusCode.HTTP_ACCEPTED, "Error updating DataSet")
                
                // Delete Created DataSet
                let statusDeleteDataSet = self.library.deleteDataSetWith(dataSetId: dataSetIdValue)
                XCTAssertTrue(statusDeleteDataSet != nil && statusDeleteDataSet == HTTPStatusCode.HTTP_NO_CONTENT, "Error deleting DataSource")
            }
            
            //******************************************************************************************
            //*********************************** DATASOURCE OPERATIONS ********************************
            //******************************************************************************************
            
            // Retrieve created DataSource
            let retrievedDataSource = self.library.dataSourceWith(dataSourceId: dataSourceIdValue)
            
            XCTAssertTrue(retrievedDataSource.statusCode != nil && retrievedDataSource.statusCode == HTTPStatusCode.HTTP_OK, "Error retrieving DataSource - Invalid status code returned")
            XCTAssertTrue(retrievedDataSource.resourceId != nil, "Error retrieving DataSource - Invalid resourceId returned")
            XCTAssertTrue(retrievedDataSource.resourceData != nil, "Error retrieving DataSource - Invalid resourceData returned")
            
            // Search for DataSources
            let dataSources = self.library.searchDataSourcesBy(name: "My DataSource", offset: 0, limit: 15)
            
            XCTAssertTrue(dataSources.statusCode != nil && dataSources.statusCode == HTTPStatusCode.HTTP_OK, "Error searching for DataSources - Invalid status code returned")
            XCTAssertTrue(dataSources.resourcesData != nil, "Error searching for DataSources - Invalid resourceData returned")
            
            // Update DataSource name
            let statusUpdateDataSource = self.library.updateDataSourceNameWith(dataSourceId: dataSourceIdValue, name: "My DataSource Updated")
            XCTAssertTrue(statusUpdateDataSource != nil && statusUpdateDataSource == HTTPStatusCode.HTTP_ACCEPTED, "Error updating DataSource")
            
            // Delete Created DataSource
            let statusDeleteDataSource = self.library.deleteDataSourceWith(dataSourceId: dataSourceIdValue)
            XCTAssertTrue(statusDeleteDataSource != nil && statusDeleteDataSource == HTTPStatusCode.HTTP_NO_CONTENT, "Error deleting DataSource")
        }
    }
    
    func testML4SwiftAsyncOperations() {
        // Create DataSource from iris.csv
        let path = NSBundle(forClass: ML4SwiftTests.self).pathForResource("iris", ofType: "csv")
        self.library.createDataSourceAsyncWith(name: "My DataSource", filePath: path)
        
        self.waitForAsyncOperation()
        
        // Optional Binding
        if let dataSourceIdValue = self.resultDataSourceIdAsync {
            // Wait while DataSource is ready
            while !self.library.dataSourceIsReadyWith(dataSourceId: dataSourceIdValue) {
                sleep(3)
            }
            
            // Create DataSet from DataSource Identifier
            self.library.createDataSetAsyncWith(dataSourceId: dataSourceIdValue, name: "My DataSet")
            
            self.waitForAsyncOperation()
        }
    }
    
    //******************************************************************************************
    //************************************* ML4SwiftDelegate ***********************************
    //******************************************************************************************
    
    func dataSourceCreatedWith(#statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating DataSource - Invalid status code returned")
        XCTAssertTrue(resourceId != nil, "Error creating DataSource - Invalid resourceId returned")
        XCTAssertTrue(resourceData != nil, "Error creating DataSource - Invalid resourceData returned")
        
        self.resultDataSourceIdAsync = resourceId
        
        self.signalForAsyncOperation()
    }
    
    func dataSourceUpdateWith(#statusCode: HTTPStatusCode?) {
        
    }
    
    func dataSourceDeletedWith(#statusCode: HTTPStatusCode?) {
        
    }
    
    func dataSourceRetrievedWith(#statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        
    }
    
    func dataSourcesRetrievedWith(#statusCode: HTTPStatusCode?, resourcesData: NSDictionary?) {
        
    }
    
    func dataSourceIsReadyWith(#status: Bool) {
        
    }
    
    func dataSetCreatedWith(#statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating DataSet - Invalid status code returned")
        XCTAssertTrue(resourceId != nil, "Error creating DataSet - Invalid resourceId returned")
        XCTAssertTrue(resourceData != nil, "Error creating DataSet - Invalid resourceData returned")
        
        self.resultDataSetIdAsync = resourceId
        
        self.signalForAsyncOperation()
    }
    
    func dataSetUpdateWith(#statusCode: HTTPStatusCode?) {
        
    }
    
    func dataSetDeletedWith(#statusCode: HTTPStatusCode?) {
        
    }
    
    func dataSetRetrievedWith(#statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        
    }
    
    func dataSetRetrievedWith(#statusCode: HTTPStatusCode?, resourcesData: NSDictionary?) {
        
    }
    
    func dataSetIsReadyWith(#status: Bool) {
        
    }
}