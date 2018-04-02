import 'dart:async';
import 'dart:convert';
import 'dart:io';

final httpClient = new HttpClient();

typedef HttpResponseBodyParser<T> = Future<T> Function(HttpResponseResult httpResponseResult);

class HttpRequestResult {

  HttpRequestResult({ this.request });

  HttpClientRequest request;

  Uri get requestUri => request.uri;

  Future<HttpClientResponse> get responseFuture => request.close();

  Future<HttpResponseResult> get future {
    var completer = new Completer<HttpResponseResult>();
    responseFuture.then((HttpClientResponse response) {
      completer.complete(new HttpResponseResult(requestResult: this, response: response));
    });
    return completer.future;
  }

}

class HttpResponseResult {

  HttpResponseResult.from({ HttpClientRequest request, this.response }) : requestUri = request.uri;

  HttpResponseResult({ HttpRequestResult requestResult, HttpClientResponse response })
      : this.from(request: requestResult.request, response: response);

  final Uri requestUri;

  final HttpClientResponse response;

  Future<HttpResponseBody<T>> responseBody<T>(HttpResponseBodyParser<T> parser) {
    return parser(this);
  }

}

class HttpResponseBody<T> {

  HttpResponseBody.from({ HttpResponseBody responseBody, this.body }) :
      requestUri = responseBody.requestUri,
        statusCode = responseBody.statusCode,
        reason = responseBody.reason,
        contentLength = responseBody.contentLength;

  HttpResponseBody({
    this.body,
    this.requestUri,
    HttpClientResponse response,
  }) : statusCode = response.statusCode,
        reason = response.reasonPhrase,
        contentLength = response.contentLength;

  final T body;

  final Uri requestUri;

  final int statusCode;

  final String reason;

  final int contentLength;

}

class HttpHelper {

  static Future<HttpRequestResult> makeRequest({ Uri uri, String method: "GET" }) {
    if (uri == null) {
      throw new ArgumentError.notNull("uri");
    }

    if (method == null) {
      throw new ArgumentError.notNull("method");
    }

    var completer = new Completer<HttpRequestResult>();
    httpClient.openUrl(method, uri)
        .then((HttpClientRequest request) => completer.complete(new HttpRequestResult(request: request)))
        .catchError((dynamic error, StackTrace stackTrace) => completer.completeError(error, stackTrace));
    return completer.future;
  }

  static Future<HttpResponseBody<String>> fetchText({ Uri uri, String method: "GET" }) {
    var completer = new Completer<HttpResponseBody<String>>();

    var errorHandler = (dynamic error, StackTrace stackTrace) {
      completer.completeError(error, stackTrace);
    };

    var requestFuture = makeRequest(uri: uri, method: method);
    requestFuture.then((HttpRequestResult requestResult) {
      requestResult.future.then((HttpResponseResult responseResult) {
        responseResult.responseBody((HttpResponseResult httpResponseResult) {
          var responseBodyCompleter = new Completer<HttpResponseBody<String>>();
          var contents = new StringBuffer();
          httpResponseResult.response
              .transform(UTF8.decoder)
              .listen((String data) => contents.write(data),
                onDone: () {
                  var responseBody = new HttpResponseBody(
                    body: contents.toString(),
                    requestUri: httpResponseResult.requestUri,
                    response: httpResponseResult.response,
                  );
                  responseBodyCompleter.complete(responseBody);
                }
          );
          return responseBodyCompleter.future;
        }).then((HttpResponseBody<String> responseBody) => completer.complete(responseBody)).catchError(errorHandler);
      }).catchError(errorHandler);
    }).catchError(errorHandler);

    return completer.future;
  }

  static Future<HttpResponseBody<Map>> fetchJson({ Uri uri, String method: "GET" }) {
    var completer = new Completer<HttpResponseBody<Map>>();
    fetchText(uri: uri, method: method).then((HttpResponseBody<String> responseBody) {
      var decodedBody = JSON.decode(responseBody.body);
      var decodedResponseBody = new HttpResponseBody<Map>.from(responseBody: responseBody, body: decodedBody);
      completer.complete(decodedResponseBody);
    }).catchError((dynamic error, StackTrace stackTrace) => completer.completeError(error, stackTrace));
    return completer.future;
  }

}