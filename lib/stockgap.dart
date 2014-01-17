library stockgap;

import 'dart:io';

var cookies = {};
var cookieOut = [];
var env = {};
var headers = [];
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
  cookieOut.add({
    'name': 'the_answer',
    'value': 'forty two'
  });
  cookieOut.add({
    'name': 'secret identity',
    'value': 'WTF'
  });
}

String prepareCookieDelivery() {
  var cookieParts = [];
  for (var c in cookieOut) {
    var cn = Uri.encodeComponent(c['name']);
    var cv = Uri.encodeComponent(c['value']);
    cookieParts.add('${cn}=${cv}');
  }
  var cookieStr = cookieParts.join('&');
  return('Set-Cookie: ${cookieStr};');
}

String render(String p) {
  setHeaders();
  return '${headers.join("\n")}\n\n${p}';
}

String setHeaders() {
  headers.add('Content-type:text/html');
  if (cookieOut.isNotEmpty){
    headers.add(prepareCookieDelivery());
  }
}

String template(String tstr, Map vbind) {
  var reTS = new RegExp(r'\{\{(\w+)\}\}');
  var strOut = tstr.replaceAllMapped(reTS, (m) {
    var tv = m.group(1);
    return vbind.containsKey(tv) ? vbind[tv] : '';
  });
  return strOut;
}