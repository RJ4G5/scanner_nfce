
// ignore_for_file: camel_case_types
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart' ;
import 'package:http/http.dart' as http;
import 'ParseUF/parseMG.dart';
import '../../../global.dart' as global;


class FechNFCE{
  String url;

  FechNFCE({ required this.url, }){  
      
        Uri uri =   Uri.parse(url);
        var uf = uri.host.split(".");
       
        global.AlertFechNFCE();

        switch(uf[uf.length-3]){
          case "mg":

            global.logger.d("Minas Gerais");

            http.get(uri).then((html){
              ParseMG(html);
              global.CloseAlertFechNFCE();

            }).catchError((onError){
               global.CloseAlertFechNFCE();
               global.ShowSnackBar("Erro inesperado durante a consulta!");
            });  
            
          break;          

          default:
            global.ShowSnackBar("Ainda sem suporte para seu estado!");          
          break;


        }

  }
  
}