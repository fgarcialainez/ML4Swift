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

class ML4SwiftTests: XCTestCase
{
    var library = ML4Swift(apiUsername: "felixksp", apiKey: "9236b5c57063074edadc7baa25602a6360fc3872", developmentMode: false)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testML4Swift()
    {
        //******************************************************************************************
        //************************************** CREATE METHODS ************************************
        //******************************************************************************************
        
        // Create DataSource from iris.csv
        let path = NSBundle(forClass: ML4SwiftTests.self).pathForResource("iris", ofType: "csv")
        let resultDataSource = library.createDataSourceWith("My DataSource", filePath: path)
        
        XCTAssertTrue(resultDataSource.statusCode != nil && resultDataSource.statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating DataSource - Invalid status code returned")
        XCTAssertTrue(resultDataSource.resourceId != nil, "Error creating DataSource - Invalid resourceId returned")
        XCTAssertTrue(resultDataSource.resourceData != nil, "Error creating DataSource - Invalid resourceData returned")
        
        // Wait while DataSource is ready
        while !library.dataSourceIsReadyWith(dataSourceId: resultDataSource.resourceId!) {
            sleep(3)
        }
        
        // Create DataSet from DataSource Identifier
        let resultDataSet = library.createDataSetWith(dataSourceId: resultDataSource.resourceId!, name: "My DataSet")
        
        XCTAssertTrue(resultDataSet.statusCode != nil && resultDataSet.statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating DataSet - Invalid status code returned")
        XCTAssertTrue(resultDataSet.resourceId != nil, "Error creating DataSet - Invalid resourceId returned")
        XCTAssertTrue(resultDataSet.resourceData != nil, "Error creating DataSet - Invalid resourceData returned")
        
        // Wait while DataSet is ready
        while !library.dataSetIsReadyWith(dataSetId: resultDataSet.resourceId!) {
            sleep(3)
        }
        
        // Create Model from DataSet Identifier
        let resultModel = library.createModelWith(dataSetId: resultDataSet.resourceId!, name: "My Model")
        
        XCTAssertTrue(resultModel.statusCode != nil && resultModel.statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating Model - Invalid status code returned")
        XCTAssertTrue(resultModel.resourceId != nil, "Error creating Model - Invalid resourceId returned")
        XCTAssertTrue(resultModel.resourceData != nil, "Error creating Model - Invalid resourceData returned")
        
        // Wait while Model is ready
        while !library.modelIsReadyWith(modelId: resultModel.resourceId!) {
            sleep(3)
        }
        
        // Create Prediction from Model Identifier
        let inputDataForPrediction = "{\"000000\": 3, \"000001\": 2, \"000002\": 1, \"000003\": 1}"
        let resultPrediction = library.createPredictionWith(modelId: resultModel.resourceId!, name: "My Prediction", inputData: inputDataForPrediction)
        
        XCTAssertTrue(resultPrediction.statusCode != nil && resultPrediction.statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating Prediction - Invalid status code returned")
        XCTAssertTrue(resultPrediction.resourceId != nil, "Error creating Prediction - Invalid resourceId returned")
        XCTAssertTrue(resultPrediction.resourceData != nil, "Error creating Prediction - Invalid resourceData returned")
        
        // Wait while Prediction is ready
        while !library.predictionIsReadyWith(predictionId: resultPrediction.resourceId!) {
            sleep(3)
        }
        
        //******************************************************************************************
        //************************************ GET RESOURCE METHODS ********************************
        //******************************************************************************************
        
        // Retrieve created DataSource
        let retrievedDataSource = library.dataSourceWith(dataSourceId: resultDataSource.resourceId!)
        
        XCTAssertTrue(retrievedDataSource.statusCode != nil && retrievedDataSource.statusCode == HTTPStatusCode.HTTP_OK, "Error retrieving DataSource - Invalid status code returned")
        XCTAssertTrue(retrievedDataSource.resourceId != nil, "Error retrieving DataSource - Invalid resourceId returned")
        XCTAssertTrue(retrievedDataSource.resourceData != nil, "Error retrieving DataSource - Invalid resourceData returned")
        
        // Retrieve created DataSet
        let retrievedDataSet = library.dataSetWith(dataSetId: resultDataSet.resourceId!)
        
        XCTAssertTrue(retrievedDataSet.statusCode != nil && retrievedDataSet.statusCode == HTTPStatusCode.HTTP_OK, "Error retrieving DataSet - Invalid status code returned")
        XCTAssertTrue(retrievedDataSet.resourceId != nil, "Error retrieving DataSet - Invalid resourceId returned")
        XCTAssertTrue(retrievedDataSet.resourceData != nil, "Error retrieving DataSet - Invalid resourceData returned")
        
        // Retrieve created Model
        let retrievedModel = library.modelWith(modelId: resultModel.resourceId!)
        
        XCTAssertTrue(retrievedModel.statusCode != nil && retrievedModel.statusCode == HTTPStatusCode.HTTP_OK, "Error retrieving Model - Invalid status code returned")
        XCTAssertTrue(retrievedModel.resourceId != nil, "Error retrieving Model - Invalid resourceId returned")
        XCTAssertTrue(retrievedModel.resourceData != nil, "Error retrieving Model - Invalid resourceData returned")
        
        // Retrieve created Prediction
        let retrievedPrediction = library.predictionWith(predictionId: resultPrediction.resourceId!)
        
        XCTAssertTrue(retrievedPrediction.statusCode != nil && retrievedPrediction.statusCode == HTTPStatusCode.HTTP_OK, "Error retrieving Prediction - Invalid status code returned")
        XCTAssertTrue(retrievedPrediction.resourceId != nil, "Error retrieving Prediction - Invalid resourceId returned")
        XCTAssertTrue(retrievedPrediction.resourceData != nil, "Error retrieving Prediction - Invalid resourceData returned")
        
        //******************************************************************************************
        //*************************************** UPDATE METHODS ***********************************
        //******************************************************************************************
        
        // Update DataSource name
        let statusUpdateDataSource = library.updateDataSourceNameWith(dataSourceId: resultDataSource.resourceId!, name: "My DataSource Updated")
        XCTAssertTrue(statusUpdateDataSource != nil && statusUpdateDataSource == HTTPStatusCode.HTTP_ACCEPTED, "Error updating DataSource")
        
        // Update DataSet name
        let statusUpdateDataSet = library.updateDataSetNameWith(dataSetId: resultDataSet.resourceId!, name: "My DataSet Updated")
        XCTAssertTrue(statusUpdateDataSet != nil && statusUpdateDataSet == HTTPStatusCode.HTTP_ACCEPTED, "Error updating DataSet")
        
        // Update Model name
        let statusUpdateModel = library.updateModelNameWith(modelId: resultModel.resourceId!, name: "My Model Updated")
        XCTAssertTrue(statusUpdateModel != nil && statusUpdateModel == HTTPStatusCode.HTTP_ACCEPTED, "Error updating Model")
        
        // Update Prediction name
        let statusUpdatePrediction = library.updatePredictionNameWith(predictionId: resultPrediction.resourceId!, name: "My Prediction Updated")
        XCTAssertTrue(statusUpdatePrediction != nil && statusUpdatePrediction == HTTPStatusCode.HTTP_ACCEPTED, "Error updating Prediction")
        
        //******************************************************************************************
        //*************************************** DELETE METHODS ***********************************
        //******************************************************************************************
        
        // Delete Created Prediction
        let statusDeletePrediction = library.deletePredictionWith(predictionId: resultPrediction.resourceId!)
        XCTAssertTrue(statusDeletePrediction != nil && statusDeletePrediction == HTTPStatusCode.HTTP_NO_CONTENT, "Error deleting Prediction")
        
        // Delete Created Model
        let statusDeleteModel = library.deleteModelWith(modelId: resultModel.resourceId!)
        XCTAssertTrue(statusDeleteModel != nil && statusDeleteModel == HTTPStatusCode.HTTP_NO_CONTENT, "Error deleting Model")
        
        // Delete Created DataSet
        let statusDeleteDataSet = library.deleteDataSetWith(dataSetId: resultDataSet.resourceId!)
        XCTAssertTrue(statusDeleteDataSet != nil && statusDeleteDataSet == HTTPStatusCode.HTTP_NO_CONTENT, "Error deleting DataSource")
        
        // Delete Created DataSource
        let statusDeleteDataSource = library.deleteDataSourceWith(dataSourceId: resultDataSource.resourceId!)
        XCTAssertTrue(statusDeleteDataSource != nil && statusDeleteDataSource == HTTPStatusCode.HTTP_NO_CONTENT, "Error deleting DataSource")
    }
}