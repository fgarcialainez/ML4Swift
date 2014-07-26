/**
 *
 * ML4SwiftTestAsync.swift
 * ML4SwiftTests
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

import XCTest

class ML4SwiftTestAsync : XCTestCase, ML4SwiftDelegate
{
    var library: ML4Swift!
    
    // Used to implement a Semaphore
    var expectation: XCTestExpectation?

    var resultDataSourceId: NSString?
    var resultDataSetId: NSString?
    var resultModelId: NSString?
    var resultPredictionId: NSString?
    
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
    
    //******************************************************************************************
    //*************************************** TEST CASES ***************************************
    //******************************************************************************************
    
    func testML4SwiftAsyncOperations() {
        //******************************************************************************************
        //*********************************** CREATION OPERATIONS **********************************
        //******************************************************************************************
        
        // Create DataSource Async from iris.csv
        let path = NSBundle(forClass: ML4SwiftTestAsync.self).pathForResource("iris", ofType: "csv")
        self.library.asyncCreateDataSourceWith(name: "My DataSource", filePath: path)
        self.waitForAsyncOperation()
        
        // Optional Binding
        if let dataSourceIdValue = self.resultDataSourceId {
            // Wait while DataSource is ready
            while !self.library.dataSourceIsReadyWith(dataSourceId: dataSourceIdValue) {
                sleep(3)
            }
            
            // Create DataSet Async from DataSource Identifier
            self.library.asyncCreateDataSetWith(dataSourceId: dataSourceIdValue, name: "My DataSet")
            self.waitForAsyncOperation()
            
            // Optional Binding
            if let dataSetIdValue = self.resultDataSetId {
                // Wait while DataSet is ready
                while !self.library.dataSetIsReadyWith(dataSetId: dataSetIdValue) {
                    sleep(3)
                }
                
                // Create Model Async from DataSet Identifier
                self.library.asyncCreateModelWith(dataSetId: dataSetIdValue, name: "My Model")
                self.waitForAsyncOperation()
                
                // Optional Binding
                if let modelIdValue = self.resultModelId {
                    // Wait while Model is ready
                    while !self.library.modelIsReadyWith(modelId: modelIdValue) {
                        sleep(3)
                    }
                    
                    // Create Prediction Async from Model Identifier
                    let inputDataForPrediction = "{\"000000\": 3, \"000001\": 2, \"000002\": 1, \"000003\": 1}"
                    self.library.asyncCreatePredictionWith(modelId: modelIdValue, name: "My Prediction", inputData: inputDataForPrediction)
                    self.waitForAsyncOperation()
                    
                    // Optional Binding
                    if let predictionIdValue = self.resultPredictionId {
                        // Wait while Prediction is ready
                        while !self.library.predictionIsReadyWith(predictionId: predictionIdValue) {
                            sleep(3)
                        }
                        
                        //******************************************************************************************
                        //********************************** PREDICTION OPERATIONS *********************************
                        //******************************************************************************************
                        
                        // Retrieve created Prediction
                        self.library.asyncPredictionWith(predictionId: predictionIdValue)
                        self.waitForAsyncOperation()
                        
                        // Search for Predictions
                        self.library.asyncSearchPredictionsBy(name: "My Prediction", offset: 0, limit: 15)
                        self.waitForAsyncOperation()
                        
                        // Update Prediction name
                        self.library.asyncUpdatePredictionNameWith(predictionId: predictionIdValue, name: "My Prediction Updated")
                        self.waitForAsyncOperation()
                        
                        // Delete Created Prediction
                        self.library.asyncDeletePredictionWith(predictionId: predictionIdValue)
                        self.waitForAsyncOperation()
                    }
                    
                    //******************************************************************************************
                    //************************************* MODEL OPERATIONS ***********************************
                    //******************************************************************************************
                    
                    // Retrieve created Model
                    self.library.asyncModelWith(modelId: modelIdValue)
                    self.waitForAsyncOperation()
                    
                    // Search for Models
                    self.library.asyncSearchModelsBy(name: "My Model", offset: 0, limit: 15)
                    self.waitForAsyncOperation()
                    
                    // Update Model name
                    self.library.asyncUpdateModelNameWith(modelId: modelIdValue, name: "My Model Updated")
                    self.waitForAsyncOperation()
                    
                    // Delete Created Model
                    self.library.asyncDeleteModelWith(modelId: modelIdValue)
                    self.waitForAsyncOperation()
                }
                
                //******************************************************************************************
                //************************************ DATASET OPERATIONS **********************************
                //******************************************************************************************
                
                // Retrieve created DataSet
                self.library.asyncDataSetWith(dataSetId: dataSetIdValue)
                self.waitForAsyncOperation()
                
                // Search for DataSets
                self.library.asyncSearchDataSetsBy(name: "My DataSet", offset: 0, limit: 15)
                self.waitForAsyncOperation()
                
                // Update DataSet name
                self.library.asyncUpdateDataSetNameWith(dataSetId: dataSetIdValue, name: "My DataSet Updated")
                self.waitForAsyncOperation()
                
                // Delete Created DataSet
                self.library.asyncDeleteDataSetWith(dataSetId: dataSetIdValue)
                self.waitForAsyncOperation()
            }
            
            //******************************************************************************************
            //*********************************** DATASOURCE OPERATIONS ********************************
            //******************************************************************************************
            
            // Retrieve created DataSource
            self.library.asyncDataSourceWith(dataSourceId: dataSourceIdValue)
            self.waitForAsyncOperation()
            
            // Search for DataSources
            self.library.asyncSearchDataSourcesBy(name: "My DataSource", offset: 0, limit: 15)
            self.waitForAsyncOperation()
            
            // Update DataSource name
            self.library.asyncUpdateDataSourceNameWith(dataSourceId: dataSourceIdValue, name: "My DataSource Updated")
            self.waitForAsyncOperation()
            
            // Delete Created DataSource
            self.library.asyncDeleteDataSourceWith(dataSourceId: dataSourceIdValue)
            self.waitForAsyncOperation()
        }
    }
    
    //******************************************************************************************
    //************************************* ML4SwiftDelegate ***********************************
    //******************************************************************************************
    
    /**
     * DATASOURCE CALLBACKS
     */
    
    func dataSourceCreatedWith(#statusCode: HTTPStatusCode?, resourceId: String?, dataSourceData: NSDictionary?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating DataSource - Invalid status code returned")
        XCTAssertTrue(resourceId != nil, "Error creating DataSource - Invalid resourceId returned")
        XCTAssertTrue(dataSourceData != nil, "Error creating DataSource - Invalid resourceData returned")
        
        self.resultDataSourceId = resourceId
        
        self.signalForAsyncOperation()
    }
    
    func dataSourceUpdatedWith(#statusCode: HTTPStatusCode?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_ACCEPTED, "Error updating DataSource")
        
        self.signalForAsyncOperation()
    }
    
    func dataSourceDeletedWith(#statusCode: HTTPStatusCode?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_NO_CONTENT, "Error deleting DataSource")
        
        self.signalForAsyncOperation()
    }
    
    func dataSourceRetrievedWith(#statusCode: HTTPStatusCode?, resourceId: String?, dataSourceData: NSDictionary?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_OK, "Error retrieving DataSource - Invalid status code returned")
        XCTAssertTrue(resourceId != nil, "Error retrieving DataSource - Invalid resourceId returned")
        XCTAssertTrue(dataSourceData != nil, "Error retrieving DataSource - Invalid resourceData returned")
        
        self.resultDataSourceId = resourceId
        
        self.signalForAsyncOperation()
    }
    
    func dataSourcesRetrievedWith(#statusCode: HTTPStatusCode?, dataSourceListData: NSDictionary?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_OK, "Error searching for DataSources - Invalid status code returned")
        XCTAssertTrue(dataSourceListData != nil, "Error searching for DataSources - Invalid resourceData returned")
        
        self.signalForAsyncOperation()
    }
    
    func dataSourceIsReadyWith(#status: Bool) {
    }
    
    /**
     * DATASET CALLBACKS
     */
    
    func dataSetCreatedWith(#statusCode: HTTPStatusCode?, resourceId: String?, dataSetData: NSDictionary?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating DataSet - Invalid status code returned")
        XCTAssertTrue(resourceId != nil, "Error creating DataSet - Invalid resourceId returned")
        XCTAssertTrue(dataSetData != nil, "Error creating DataSet - Invalid resourceData returned")
        
        self.resultDataSetId = resourceId
        
        self.signalForAsyncOperation()
    }
    
    func dataSetUpdatedWith(#statusCode: HTTPStatusCode?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_ACCEPTED, "Error updating DataSet")
        
        self.signalForAsyncOperation()
    }
    
    func dataSetDeletedWith(#statusCode: HTTPStatusCode?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_NO_CONTENT, "Error deleting DataSet")
        
        self.signalForAsyncOperation()
    }
    
    func dataSetRetrievedWith(#statusCode: HTTPStatusCode?, resourceId: String?, dataSetData: NSDictionary?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_OK, "Error retrieving DataSet - Invalid status code returned")
        XCTAssertTrue(resourceId != nil, "Error retrieving DataSet - Invalid resourceId returned")
        XCTAssertTrue(dataSetData != nil, "Error retrieving DataSet - Invalid resourceData returned")
        
        self.resultPredictionId = resourceId
        
        self.signalForAsyncOperation()
    }
    
    func dataSetsRetrievedWith(#statusCode: HTTPStatusCode?, dataSetListData: NSDictionary?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_OK, "Error searching for DataSets - Invalid status code returned")
        XCTAssertTrue(dataSetListData != nil, "Error searching for DataSets - Invalid resourceData returned")
        
        self.signalForAsyncOperation()
    }
    
    func dataSetIsReadyWith(#status: Bool) {
    }
    
    /**
     * MODEL CALLBACKS
     */
    
    func modelCreatedWith(#statusCode: HTTPStatusCode?, resourceId: String?, modelData: NSDictionary?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating Model - Invalid status code returned")
        XCTAssertTrue(resourceId != nil, "Error creating Model - Invalid resourceId returned")
        XCTAssertTrue(modelData != nil, "Error creating Model - Invalid resourceData returned")
        
        self.resultModelId = resourceId
        
        self.signalForAsyncOperation()
    }
    
    func modelUpdatedWith(#statusCode: HTTPStatusCode?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_ACCEPTED, "Error updating Model")
        
        self.signalForAsyncOperation()
    }
    
    func modelDeletedWith(#statusCode: HTTPStatusCode?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_NO_CONTENT, "Error deleting Model")
        
        self.signalForAsyncOperation()
    }
    
    func modelRetrievedWith(#statusCode: HTTPStatusCode?, resourceId: String?, modelData: NSDictionary?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_OK, "Error retrieving Model - Invalid status code returned")
        XCTAssertTrue(resourceId != nil, "Error retrieving Model - Invalid resourceId returned")
        XCTAssertTrue(modelData != nil, "Error retrieving Model - Invalid resourceData returned")
        
        self.resultModelId = resourceId
        
        self.signalForAsyncOperation()
    }
    
    func modelsRetrievedWith(#statusCode: HTTPStatusCode?, modelListData: NSDictionary?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_OK, "Error searching for Models - Invalid status code returned")
        XCTAssertTrue(modelListData != nil, "Error searching for Models - Invalid resourceData returned")
        
        self.signalForAsyncOperation()
    }
    
    func modelIsReadyWith(#status: Bool) {
    }
    
    /**
     * PREDICTION CALLBACKS
     */
    
    func predictionCreatedWith(#statusCode: HTTPStatusCode?, resourceId: String?, predictionData: NSDictionary?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating Prediction - Invalid status code returned")
        XCTAssertTrue(resourceId != nil, "Error creating Prediction - Invalid resourceId returned")
        XCTAssertTrue(predictionData != nil, "Error creating Prediction - Invalid resourceData returned")
        
        self.resultPredictionId = resourceId
        
        self.signalForAsyncOperation()
    }
    
    func predictionUpdatedWith(#statusCode: HTTPStatusCode?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_ACCEPTED, "Error updating Prediction")
        
        self.signalForAsyncOperation()
    }
    
    func predictionDeletedWith(#statusCode: HTTPStatusCode?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_NO_CONTENT, "Error deleting Prediction")
        
        self.signalForAsyncOperation()
    }
    
    func predictionRetrievedWith(#statusCode: HTTPStatusCode?, resourceId: String?, predictionData: NSDictionary?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_OK, "Error retrieving Prediction - Invalid status code returned")
        XCTAssertTrue(resourceId != nil, "Error retrieving Prediction - Invalid resourceId returned")
        XCTAssertTrue(predictionData != nil, "Error retrieving Prediction - Invalid resourceData returned")
        
        self.resultPredictionId = resourceId
        
        self.signalForAsyncOperation()
    }
    
    func predictionsRetrievedWith(#statusCode: HTTPStatusCode?, predictionListData: NSDictionary?) {
        XCTAssertTrue(statusCode != nil && statusCode == HTTPStatusCode.HTTP_OK, "Error searching for Predictions - Invalid status code returned")
        XCTAssertTrue(predictionListData != nil, "Error searching for Predictions - Invalid resourceData returned")
        
        self.signalForAsyncOperation()
    }
    
    func predictionIsReadyWith(#status: Bool) {
    }
}