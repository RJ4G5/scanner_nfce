
// ignore_for_file: camel_case_types
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart' ;
import 'package:http/http.dart' as http;
import 'ParseUF/parseMG.dart';

var log = Logger();

class FechNFCE{
  String url;
  BuildContext context;
  FechNFCE({ required this.url, required this.context, }){  
      
        Uri uri =   Uri.parse(url);
        var uf = uri.host.split(".");
       

        switch(uf[uf.length-3]){
          case "mg":

            log.d("Minas Gerais");
            http.get(uri).then((html){
              ParseMG(html,context);
            });  
            
          break;
          case "es":

            log.d("Epirito Santo");
           // ParseMG(uri,context);
          break;
        }

  }
  
}