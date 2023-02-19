
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

  getAllProd(){
   /* List<dynamic> todosProdutos = [ ]; 
                  List<dynamic> prod  = _nfce['ListaProdutos'];
                  prod.forEach((element) {
                    element['Chave'] =  _nfce['Chave'];
                    todosProdutos.add(element);
                  // print("${element["Descricao"]} --> ${_nfce['NomeEmpresarial']}");
                    
                  });*/
  }


  void maisFrequentes(List<dynamic> list){
      print("maisFrequentes");
      List grupos = [];

    List<String> verificados = [];

    for (int i = 0; i < list.length - 1; i++) {
      List<dynamic> groupTemp = [];   
      for (int j = i + 1; j < list.length; j++) {
        if (SimilaridadePorcent(list[i]["Descricao"], list[j]["Descricao"]) > 70) { 
          if(!verificados.contains(list[j]["ID"])){
            verificados.add(list[j]["ID"]);
            groupTemp.add(list[j]);
          }      
          
        }
      }
      if(groupTemp.length > 0){
          if(!verificados.contains(list[i]["ID"])){
            verificados.add(list[i]["ID"]);
            groupTemp.add(list[i]);
          }
          grupos.add(groupTemp);
      }
       
       // logger.d(groupTemp);
    }


    logger.d(grupos);    
      

  }
}