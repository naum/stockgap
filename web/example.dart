#!/usr/local/bin/dart

import 'package:stockgap/stockgap.dart' as cgi;

var pageTemplate = '''
<!DOCTYPE html>
<head>
  <title>stockgap</title>
  <style>
    body { max-width:40em; }
    input[type="submit"] { font-size:1.77em; }
  </style>
</head>
<body>
  <h1>stockgap</h1>
  <h2>env</h2>
  <div>{{ENV}}</div>
  <h2>param</h2>
  <div>{{PARAM}}</div>
  <h2>post test</h2>
  <form method="post" action="/example.dart">
    <label>title</title> <input type="text" name="subject"><br>
    <label>message</label><br>
    <textarea name="message" rows="6" cols="60"></textarea><br>
    <input type="submit" name="op" value="go">
  </form>
</body>
</html>
''';

main() {
  cgi.kickoff();
  Map vb = {
    'ENV': cgi.env,
    'PARAM': cgi.param 
  };
  var hout = cgi.template(pageTemplate, vb);
  print(cgi.render(hout));
}

