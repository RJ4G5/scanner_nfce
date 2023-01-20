
// ignore_for_file: camel_case_types
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart' ;

import 'ParseData/parseMG.dart';
var log = Logger();
class getDataNFCE{
  String url;
  BuildContext context;
  getDataNFCE({ required this.url, required this.context, }){  
      
        Uri uri =   Uri.parse(url);
        var uf = uri.host.split(".");
       

        switch(uf[uf.length-3]){
          case "mg":

            log.d("Minas Gerais");
            ParseMG(uri,context);
          break;
          case "es":

            log.d("Epirito Santo");
            ParseMG(uri,context);
          break;
        }

  }
  
}