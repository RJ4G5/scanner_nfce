
import 'dart:math';

import 'package:localstore/localstore.dart';
import 'package:logger/logger.dart' ;

class DB_NFCEs{
  final db = Localstore.instance;
  var logger = Logger();


int SimilaridadePorcent(String text1, String text2){
      
      int length1 = text1.length;
      int length2 = text2.length;
      int maxLength = max(length1, length2);
      int count = 0;
      for (int i = 0; i < maxLength; i++) {
        if (i < length1 && i < length2 && text1[i] == text2[i]) {
          count++;
        }
      }
      //return (count / maxLength * 100).round();
      double a = (100 * log(count) / log(maxLength));
      if(a.isInfinite)
        return 0;
      else
       return a.round();
  }



 Future<Map<String, dynamic>?> getNFCEs(){  
    return db.collection('NFCEs').get();
  }

 Future<List<dynamic>> getAllItens() async{
      List<dynamic> todosProdutos = [ ]; 

      Map<String, dynamic>? NFCEs = await getNFCEs();
      NFCEs?.forEach((key, nfce) {

          List<dynamic> nfce_itens  = nfce['ListaProdutos'];
          nfce_itens.forEach((item) {
                item['Chave'] =  nfce['Chave'];
                item["NomeEmpresarial"] = nfce['NomeEmpresarial'];
                item['hora'] = nfce['hora'];
                item['data'] = nfce['data'];
                todosProdutos.add(item);
              // print("${element["Descricao"]} --> ${_nfce['NomeEmpresarial']}");
                
          });
            
      });

    return todosProdutos  ;
    
  }


  Future<List<dynamic>> maisFrequentes() async{  // FUNÇÃO UTILIZA A FUNÇÃO SimilaridadePorcent PARA AGRUPAR TODOS OS PRODUTOS COM SIMILARIDADE IGUAIS
      
    List grupos = [];

    List<dynamic> NFCEs_itens = await getAllItens();

    
    List<String> verificados = [];

    for (int i = 0; i < NFCEs_itens.length - 1; i++) {
      List<dynamic> groupTemp = [];

      for (int j = i + 1; j < NFCEs_itens.length; j++) {
        if (SimilaridadePorcent(NFCEs_itens[i]["Descricao"], NFCEs_itens[j]["Descricao"]) > 70) { 
          if(!verificados.contains(NFCEs_itens[j]["ID"])){
            verificados.add(NFCEs_itens[j]["ID"]);
            groupTemp.add(NFCEs_itens[j]);
          }      
          
        }
      }

      if(groupTemp.length > 0){
          if(!verificados.contains(NFCEs_itens[i]["ID"])){
            verificados.add(NFCEs_itens[i]["ID"]);
            groupTemp.add(NFCEs_itens[i]);
          }
          grupos.add(groupTemp); 
      }
       
        //logger.d(groupTemp);
    }


    return grupos;

  }



  Future<List<dynamic>> FrequentesPorEmpresa() async{ // retorna uma lista de grupos reoganizados por empresa
      List<dynamic> grupos_frequentes = await maisFrequentes();

      List<dynamic> frequentesPorEmpresa = [];
      //logger.d(grupos_frequentes);
       grupos_frequentes.forEach((grupo) async {

          
        List<dynamic> a =  await reorganizarPorEmpresa(grupo);
      
        frequentesPorEmpresa.add(a);

         

      
     });
     


      return frequentesPorEmpresa;
  }




  reorganizarPorEmpresa(List<dynamic> grupo){ //FUNÇÃO REORGANIZA CADA GRUPO DE PRODUTOS IGUAIS POR EMPRESA 
      List<dynamic> list = [];
     List<String> verificados = [];


     grupo.sort((a, b) => a["data"].compareTo(b["data"])); // organiza os itens por data

     for(int i = 0; i < grupo.length ; i++){

                if(!verificados.contains(grupo[i]["NomeEmpresarial"])){
                  
                      List<Map<String, dynamic>> temp =[];
                          
                      for (int j = i + 1; j < grupo.length; j++) {
                            
                            if(grupo[i]["NomeEmpresarial"] == grupo[j]["NomeEmpresarial"]){
                              
                              Map<String, dynamic> item = Map.from(grupo[j]) ;
                              
                              item.remove("NomeEmpresarial");

                              

                              temp.add(item);


                            }
                          
                      }
                      verificados.add(grupo[i]["NomeEmpresarial"]);

                      String nomeEmpresarial = grupo[i]["NomeEmpresarial"]; // armazena o nome empresarial do item de referencia
                      Map<String, dynamic> item = Map.from(grupo[i]) ;
                      item.remove("NomeEmpresarial");  // remove o nome empresarial do item de referencia
                      temp.add(item);




                      Map<String, dynamic> Empresa_temp = {
                        "NomeEmpresarial": nomeEmpresarial,
                        "Itens":temp
                      };
                      list.add(Empresa_temp);
                      
                }
                

                
              
          }
        

          return list;

          /*  
          *** SAIDA DE DADOS JA ORGANIZADOS
                  [
                    {
                      "NomeEmpresarial": "SUPERMERCADOS BH COM. DE ALIMENTOS S.A",
                      "Itens": [
                        {
                          "ID": "6859380c-7498-4937-9bbd-c62a6e639519",
                          "Descricao": "FILEZ FGO SAD CON 1K",
                          "Quantidade": "1.000",
                          "Unidade": "PT",
                          "Valor": "19.98",
                          "Chave": "31221204641376004980650630001499421364873300",
                          "hora": "12:18:43",
                          "data": "08/12/2022"
                        },
                        {
                          "ID": "50db6bd3-adbc-4083-a360-e5d0b870d9cd",
                          "Descricao": "FILEZ FGO SAD CON 1K",
                          "Quantidade": "1.000",
                          "Unidade": "PT",
                          "Valor": "16.80",
                          "Chave": "31221104641376004980650650001407169231394560",
                          "hora": "14:08:05",
                          "data": "16/11/2022"
                        }
                      ]
                    }
                  ]
          
          */
  }



}