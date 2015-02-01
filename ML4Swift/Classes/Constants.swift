/**
 *
 * Constants.swift
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

/**
 * HTTP Status Codes
 */
public enum HTTPStatusCode : Int {
    case HTTP_OK = 200
    case HTTP_CREATED = 201
    case HTTP_ACCEPTED = 202
    case HTTP_NO_CONTENT = 204
    case HTTP_BAD_REQUEST = 400
    case HTTP_UNAUTHORIZED = 401
    case HTTP_PAYMENT_REQUIRED = 402
    case HTTP_FORBIDDEN = 403
    case HTTP_NOT_FOUND = 404
    case HTTP_METHOD_NOT_ALLOWED = 405
    case HTTP_LENGTH_REQUIRED = 411
    case HTTP_INTERNAL_SERVER_ERROR = 500
}

/**
 * Resource Status Codes (A resource can be a data source, dataset, model or prediction)
 */
public enum ResourceStatusCode : Int {
    case WAITING = 0
    case QUEUED = 1
    case STARTED = 2
    case IN_PROGRESS = 3
    case SUMMARIZED = 4
    case FINISHED = 5
    case FAULTY = -1
    case UNKNOWN = -2
    case RUNNABLE = -3
}