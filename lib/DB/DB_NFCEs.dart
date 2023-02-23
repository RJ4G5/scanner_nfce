
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


  Future<List<dynamic>> maisFrequentes() async{
      
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



}