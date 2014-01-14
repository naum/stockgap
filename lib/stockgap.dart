library stockgap;

import 'dart:io';

var cookies = {};
var env = {};
var param = {};
var queryStr;
var reqMeth;

_parseParams(String s) {
 
}

kickoff() {
  env = Platform.environment;
  reqMeth = env['REQUEST_METHOD'];
  queryStr = env['QUERY_STRING'];
  _parseParams(queryStr);
}

String render(String p) {
  var tout = 'Content-type:text/html\n\n${p}';
  return tout;
}