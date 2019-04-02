// Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
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

http:AuthProvider basicAuthProvider = {
    scheme: http:BASIC_AUTH,
    authStoreProvider: http:CONFIG_AUTH_STORE
};

listener http:Listener listener01 = new(9090, config = {
        authProviders: [basicAuthProvider],
        secureSocket: {
            keyStore: {
                path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
                password: "ballerina"
            }
        }
    });

@http:ServiceConfig {
    basePath: "/echo",
    authConfig: {
        scopes: ["scope1", "scope2"]
    }
}
service echo01 on listener01 {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/test",
        authConfig: {
            scopes: ["scope3"]
        }
    }
    resource function echo(http:Caller caller, http:Request req) {
        checkpanic caller->respond(());
    }
}