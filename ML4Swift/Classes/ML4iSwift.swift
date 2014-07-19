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
    
    func createDataSetWith(#dataSourceId: String, name: String?) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return dataSet.createDataSetWith(dataSourceId: dataSourceId, name: name)
    }

    func deleteDataSetWith(#dataSetId: String) -> HTTPStatusCode? {
        return dataSet.deleteDataSetWith(dataSetId: dataSetId)
    }
    
    func createModelWith(#dataSetId: String, name: String?) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return model.createModelWith(dataSetId: dataSetId, name: name)
    }
    
    func deleteModelWith(#modelId: String) -> HTTPStatusCode? {
        return model.deleteModelWith(modelId: modelId)
    }
    
    func modelIsReadyWith(#modelId: String) -> Bool {
        return model.modelIsReadyWith(modelId: modelId)
    }
    
    func createPredictionWith(#modelId: String, name: String?, inputData: String?) -> (statusCode: HTTPStatusCode?, resourceId: String?, resourceData: NSDictionary?) {
        return prediction.createPredictionWith(modelId: modelId, name: name, inputData: inputData)
    }
    
    func deletePredictionWith(#predictionId: String) -> HTTPStatusCode? {
        return prediction.deletePredictionWith(predictionId: predictionId)
    }
    
    func predictionIsReadyWith(#predictionId: String) -> Bool {
        return prediction.predictionIsReadyWith(predictionId: predictionId)
    }
    
    func printFrameworkData(){
        println()
        
        DataManager.sharedInstance.printCredentials()
        
        println("DataSource Base URL: " + self.dataSource.resourceBaseURL)
        println("DataSet Base URL: " + self.dataSet.resourceBaseURL)
        println("Model Base URL: " + self.model.resourceBaseURL)
        println("Prediction Base URL: " + self.prediction.resourceBaseURL)
    }
}