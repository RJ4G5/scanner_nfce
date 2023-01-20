
// ignore_for_file: library_prefixes, file_names, camel_case_types

import 'dart:ffi';

import 'package:html/dom.dart'as DOM;

import 'package:logger/logger.dart' ;
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:localstore/localstore.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
final log = Logger();
final db = Localstore.instance;

class ParseMG{
  

    ParseMG(Uri uri, BuildContext context){

        http.get(uri).then((html){
                
                DOM.Document body = parse(html.body);

                // header do documento
                var header = body.querySelectorAll(".ui-outputpanel table")[0].querySelectorAll("tr");
                String NomeEmpresarial = header[1].text.trim(); //tr[1]
                String CNPJ = header[2].text.trim().split(" ")[1]; // mesma linha tr[2]
                String InscricaoEstadual = header[2].text.trim().split(" ")[5]; // mesma linhatr[2]
                String Endereco = header[3].text.trim(); //tr[3]                ;
                // fim do header 
               
               //produtos
                List ListProdutos = []; 
                double ValorTotal = 0.0;              
                var a = body.querySelectorAll("#myTable tr");
                a.forEach((b) {
                    //print(element.runtimeType);
                      
                      var value = b.getElementsByTagName("td");
                      String valor = value[3].text.toString().split(" ")[4].replaceAll(",", ".");
                      ValorTotal +=  double.parse(valor);
                      ListProdutos.add({
                        "Descricao": value[0].getElementsByTagName("h7")[0].text.trim(),
                        "Quantidade": value[1].text.split(" ")[4],
                        "Unidade": value[2].text.split(" ")[1],
                        "Valor": valor,

                      });
                     // produto
                     
                     

                      
                });
                log.d(ListProdutos);

                //fim produtos


                // Outras informações 
                 String? chave  = body.querySelector("#collapseTwo table tr > td")?.text.toString().replaceAll(RegExp(r"[^0-9]"),""); // chave
                



                

                db.collection('NFCEs').doc(chave).set({
                  'Chave':chave,
                  'NomeFantasia': '',
                  'NomeEmpresarial': NomeEmpresarial,
                  'Cnpj': CNPJ,
                  'InscricaoEstadual': InscricaoEstadual,
                  'Endereco': Endereco,                 
                  'ValorTotal': ValorTotal,
                  'ListaProdutos': ListProdutos,
                 
                });
           
               

               Navigator.pop(context);
             });  

    }
}