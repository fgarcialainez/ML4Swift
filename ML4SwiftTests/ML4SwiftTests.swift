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
        // Create DataSet from DataSource Identifier
        let resultDataSet = library.createDataSetWith(dataSourceId: "53c11f93ffa0442f660099f2", name: "My DataSet")
        
        XCTAssertTrue(resultDataSet.statusCode != nil && resultDataSet.statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating DataSet - Invalid status code returned")
        XCTAssertTrue(resultDataSet.resourceId != nil, "Error creating DataSet - Invalid resourceId returned")
        XCTAssertTrue(resultDataSet.resourceData != nil, "Error creating DataSet - Invalid resourceData returned")
        
        // Create Model from DataSet Identifier
        let resultModel = library.createModelWith(dataSetId: resultDataSet.resourceId!, name: "My Model")
        
        XCTAssertTrue(resultModel.statusCode != nil && resultModel.statusCode == HTTPStatusCode.HTTP_CREATED, "Error creating Model - Invalid status code returned")
        XCTAssertTrue(resultModel.resourceId != nil, "Error creating Model - Invalid resourceId returned")
        XCTAssertTrue(resultModel.resourceData != nil, "Error creating Model - Invalid resourceData returned")
        
        // Delete Created Model
        let statusDeleteModel = library.deleteModelWith(modelId: resultModel.resourceId!)
        
        XCTAssertTrue(statusDeleteModel != nil && statusDeleteModel == HTTPStatusCode.HTTP_NO_CONTENT, "Error deleting Model")
        
        // Delete Created DataSet
        let statusDeleteDataSet = library.deleteDataSetWith(dataSetId: resultDataSet.resourceId!)
        
        XCTAssertTrue(statusDeleteDataSet != nil && statusDeleteDataSet == HTTPStatusCode.HTTP_NO_CONTENT, "Error deleting DataSet")
    }
}