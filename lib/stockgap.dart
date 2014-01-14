library stockgap;

import 'dart:io';

var cookies = {};
var env = {};
var param = {};
var queryStr;
var reqMeth;

_parseParams(String s) {
  for (var p in s.split('&')) {
    var exprParts = p.split('=');
    var k = Uri.decodeQueryComponent(exprParts[0]);
    var v = Uri.decodeQueryComponent(exprParts[1]);
    param[k] = v;
  }
}

kickoff() {
  env = Platform.environment;
  reqMeth = env['REQUEST_METHOD'];
  queryStr = env['QUERY_STRING'];
  if (queryStr.isNotEmpty) {
    _parseParams(queryStr);
  }
}

String render(String p) {
  var tout = 'Content-type:text/html\n\n${p}';
  return tout;
}