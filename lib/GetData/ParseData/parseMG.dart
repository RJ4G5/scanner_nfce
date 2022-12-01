
// ignore_for_file: library_prefixes, file_names, camel_case_types

import 'package:html/dom.dart'as DOM;
import 'package:logger/logger.dart' ;
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:localstore/localstore.dart';
import 'package:easy_mask/easy_mask.dart';
final log = Logger();
final db = Localstore.instance;

class ParseMG{
  

    ParseMG(Uri uri){

        http.get(uri).then((html){
                
                DOM.Document body = parse(html.body);
                var dataTable = body.querySelectorAll("#myTable tr");
                var key  = body.querySelector("#collapseTwo table tr > td")?.text;
                 log.d(key.toString().replaceAll(RegExp(r"[^0-9]"),""));
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

                

             /*   db.collection('NFCEs').doc("id").set({
                  'title': 'Todo title',
                  'done': false
                });*/
              

               
              //  Navigator.pop(context);
             });  

    }
}