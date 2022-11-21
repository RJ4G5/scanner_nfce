
// ignore_for_file: library_prefixes, file_names, camel_case_types

import 'package:html/dom.dart'as DOM;
import 'package:logger/logger.dart' ;
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

var log = Logger();
class ParseMG{
    ParseMG(Uri uri){

        http.get(uri).then((html){
               
                DOM.Document body = parse(html.body);
                var dataTable = body.querySelectorAll("#myTable tr");
                dataTable.forEach((tr) {
                    //print(element.runtimeType);
                    var value = tr.getElementsByTagName("td");
                    
                      print(value[0].getElementsByTagName("h7")[0].text); // produto
                      print(value[1].text); //quantidade
                      print(value[2].text); // unidade
                      var dinheiro = value[3].text.split(r": R$ "); // preço
                      print(double.parse(dinheiro[dinheiro.length-1].replaceAll(",", ".")) );
                      print("--------------------");
                });
              

               
              //  Navigator.pop(context);
             });  

    }
}