library stockgap;

import 'dart:io';

var cookies = {};
var env = {};
var param = {};
var queryStr;
var reqMeth;

String _grabStdin() {
  var iline;
  var sb = new StringBuffer();
  while (true) {
    iline = stdin.readLineSync(retainNewlines: true);
    if (iline == null) break;
    sb.write(iline);
  }
  return sb.toString();
}

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
  if (reqMeth == 'POST') {
    _parseParams(_grabStdin());
  }
}

String render(String p) {
  var tout = 'Content-type:text/html\n\n${p}';
  return tout;
}

String template(String tstr, Map vbind) {
  var reTS = new RegExp(r'\{\{(\w+)\}\}');
  var strOut = tstr.replaceAllMapped(reTS, (m) {
    var tv = m.group(1);
    return vbind.containsKey(tv) ? vbind[tv] : '';
  });
  return strOut;
}