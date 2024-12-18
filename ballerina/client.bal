// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is auto-generated by the Ballerina OpenAPI tool.

// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

# Reads and writes Google Docs documents.
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://docs.googleapis.com/") returns error? {
        http:ClientConfiguration httpClientConfig = {auth: config.auth, httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }

    # Applies one or more updates to the document. Each request is validated before being applied. If any request is not valid, then the entire request will fail and nothing will be applied. Some requests have replies to give you some information about how they are applied. Other requests do not need to return information; these each return an empty reply. The order of replies matches that of the requests. For example, suppose you call batchUpdate with four updates, and only the third one returns information. The response would have two empty replies, the reply to the third request, and another empty reply, in that order. Because other users may be editing the document, the document might not exactly reflect your changes: your changes may be altered with respect to collaborator changes. If there are no collaborators, the document should reflect your changes. In any case, the updates in your request are guaranteed to be applied together atomically.
    #
    # + documentId - The ID of the document to update.
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - A JSON payload containing a list of updates to apply to the document. Each update is an individual request specifying modifications such as text insertion, deletion, or styling changes. The updates are applied in the order provided, and all changes are atomic: if any update fails, none are applied. 
    # + return - Successful response 
    remote isolated function docsDocumentsBatchupdate(string documentId, BatchUpdateDocumentRequest payload, map<string|string[]> headers = {}, *DocsDocumentsBatchupdateQueries queries) returns BatchUpdateDocumentResponse|error {
        string resourcePath = string `/v1/documents/${getEncodedUri(documentId)}:batchUpdate`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Creates a blank document using the title given in the request. Other fields in the request, including any provided content, are ignored. Returns the created document.
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - The JSON payload containing document details to be created. Only the `title` field is required and used in this request. Any other fields, including content, are ignored. 
    # + return - Successful response 
    remote isolated function docsDocumentsCreate(Document payload, map<string|string[]> headers = {}, *DocsDocumentsCreateQueries queries) returns Document|error {
        string resourcePath = string `/v1/documents`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Gets the latest version of the specified document.
    #
    # + documentId - The ID of the document to retrieve.
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Successful response 
    remote isolated function docsDocumentsGet(string documentId, map<string|string[]> headers = {}, *DocsDocumentsGetQueries queries) returns Document|error {
        string resourcePath = string `/v1/documents/${getEncodedUri(documentId)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }
}
