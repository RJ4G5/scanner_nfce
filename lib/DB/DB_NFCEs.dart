
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
    
    /*

      ESTA FUNÇÃO CRIA UMA CRIA UMA LISTA DE GRUPOS, CADA GRUPO É UMA LISTA DE PRODUTOS SIMILARES
      LISTA[
        [
          BANANA 2K
          BANANA PRATA 1K
        ],
        [
          FEIJAO CARIOCA 1K
          FEIJAO VERMELHO 1K
        ]
      ]

    */

    List grupos = [];

    List<dynamic> NFCEs_itens = await getAllItens();

    
    List<String> verificados = [];

    for (int i = 0; i < NFCEs_itens.length - 1 ; i++) {
      List<dynamic> groupTemp = [];

      for (int j = i + 1; j < NFCEs_itens.length; j++) {
        if (SimilaridadePorcent(NFCEs_itens[i]["Descricao"], NFCEs_itens[j]["Descricao"]) >= 70) {  // compara a porcentagem de similaridade, se [i]["Descricao"] for mais que 70% de j, ele agrupa
          if(!verificados.contains(NFCEs_itens[j]["ID"])){
            verificados.add(NFCEs_itens[j]["ID"]);
            groupTemp.add(NFCEs_itens[j]);
          }      
          
        }
      }

      if(groupTemp.length > 0){ // aqui verifica se houve produtos similares do [i]["Descricao"]
          if(!verificados.contains(NFCEs_itens[i]["ID"])){
            verificados.add(NFCEs_itens[i]["ID"]);
            groupTemp.add(NFCEs_itens[i]); // se houve adiciona o [i]["Descricao"] junto com os outre similares
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
       grupos_frequentes.forEach((grupo) async { // NESTA PARTE, UTILIZA A FUNÇÃO reorganizarPorEmpresa PARA REORGANIZAR POR EMPRESA CADA GRUPO
       // COM PRODUTOS SIMILARES E EMPRESAS DIFERENTES
       /*        
          SUPERMERCADO A
            BANANA PRATA 1K
          SUPERMERCADO B
            BANANA CATURRA 1K      

       */
          
        List<dynamic> a =  await reorganizarPorEmpresa(grupo);
         a[0]["Itens"] = await sortPorData(a[0]["Itens"]);
        frequentesPorEmpresa.add(a);

         

      
     });
     


      return frequentesPorEmpresa;
  }


  sortPorData(List<dynamic> grupo){
        List<dynamic> list = List.from(grupo);
        list.sort((a, b) {

            var split_a = a['data'].split("/");
            var split_b = b['data'].split("/");
            // o formato dever ser  ano-mes-dia "${split_a[2]} - ${split_a[1]} - ${split_a[0]}"
            var dataA = DateTime.parse("${split_a[2]}-${split_a[1]}-${split_a[0]}").millisecondsSinceEpoch;  //FormatException: Invalid date format
            var dataB = DateTime.parse("${split_b[2]}-${split_b[1]}-${split_b[0]}").millisecondsSinceEpoch;
            return dataA.compareTo(dataB);
        }); // organiza os itens por data

        return list;

  }


  reorganizarPorEmpresa(List<dynamic> grupo) { //FUNÇÃO REORGANIZA CADA GRUPO DE PRODUTOS IGUAIS POR EMPRESA 
    
    
    List<dynamic> list = [];
    List<String> verificados = [];
     

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