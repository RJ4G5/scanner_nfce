
// ignore_for_file: camel_case_types
import 'package:logger/logger.dart' ;
var log = Logger();
class getDataNFCE{
  String url;
  getDataNFCE({ required this.url, }){  
      
        Uri uri =   Uri.parse(url);
        var uf = uri.host.split(".");
       

        switch(uf[uf.length-3]){
          case "mg":
            log.d("Minas Gerais");
          break;
        }

  }
  
}