import ballerina/http;

listener http:Listener helloWorldEP = new(9191, config = {
    httpVersion: "2.0",
    secureSocket: {
        keyStore: {
            path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});

service hello on helloWorldEP {

    resource function sayHello(http:Caller caller, http:Request req) {
        _ = caller->respond("Hello " + untaint req.method + " Request !");
    }
}
