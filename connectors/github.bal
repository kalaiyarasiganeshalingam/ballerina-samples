import ballerina/config;
import ballerina/http;
import ballerina/io;
import ballerina/log;
import wso2/github4;

github4:Client githubClient = new({
    clientConfig: {
        auth: {
            scheme: http:OAUTH2,
            config: {
                grantType: http:DIRECT_TOKEN,
                config: {
                    accessToken: config:getAsString("GITHUB_TOKEN")
                }
            }
        }
    }
});

public function main() {
    github4:Repository repository = {};
    var response = githubClient->getRepository("wso2-ballerina/module-github");
    if (response is github4:Repository) {
        io:println(response);
    } else {
        log:printError(<string>response.detail().message);
    }
}
