import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';
import './../../global.dart' as global;
class CardNFCE extends StatelessWidget {
  Map<String, dynamic> nfce;
  List<Color> list_color = [Color(0xFFE91E63),Color(0xFF512DA8),Color(0xFF558B2F),Color(0xFF1976D2),Color(0xFFF57C00)];
  CardNFCE(this.nfce, {Key? key}) : super(key: key);
  formatDate (String date){

    int ano = int.parse(date.split("/")[2]);
    int mes= int.parse(date.split("/")[1]);
    int dia= int.parse(date.split("/")[0]);
    return DateTime(ano,mes,dia).toMoment().format('DD MMM');
    
  }
  @override
  Widget build(BuildContext context) {
  
    return ZoomIn(
              key: nfce['chave'],  
              
              child:Container(
                          height: 90,
                          margin: EdgeInsets.only(left: 10, right: 10,top: 5),  
                          
                          child: Row(
                            children: [
                              // ! Data da nota
                              Container(
                                height: double.infinity,
                                width: 50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text(
                                      nfce['hora'].substring(0, nfce['hora'].length - 3),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF455A64),
                                        fontSize: 13
                                      ),
                                    ),
                                    Text(                                
                                      formatDate(nfce['data']),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF455A64),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ],
                                ),

                              ),
                              Expanded(
                                // ! preview da nota
                                child: Container(
                                  
                                  padding: EdgeInsets.only(left: 18,top: 5),
                                  // ignore: prefer_const_constructors
                                  decoration: BoxDecoration(
                                      
                                      gradient: LinearGradient(
                                          stops: const [0.02, 0.02],
                                          colors:  [list_color[global.random.nextInt(list_color.length)], Colors.white]
                                      ),

                                      borderRadius: BorderRadius.all( Radius.circular(5)),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(10, 0, 0, 0),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                        // changes position of shadow
                                        ),
                                        
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Nome Empresarial",
                                          style: TextStyle(
                                            color: Color.fromARGB(190, 69, 90, 100),
                                            fontSize: 12,
                                            
                                          ),
                                        ),
                                        
                                        Text(
                                          nfce['NomeEmpresarial'],
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,

                                          style: TextStyle(
                                            color: Color(0xFF455A64),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Row(
                                  
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  "Total",
                                                  style: TextStyle(
                                                    color: Color.fromARGB(190, 69, 90, 100),
                                                    fontSize: 12,
                                                    
                                                  ),
                                                ),
                                                Text(
                                                  "R\$ ${nfce['ValorTotal'].toStringAsFixed(2)}",
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.ellipsis,

                                                  style: TextStyle(
                                                    color: Color(0xFF455A64),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 30),
                                              child:Column(
                                                children: [
                                                  Text(
                                                    "Quant.",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(190, 69, 90, 100),
                                                      fontSize: 12,
                                                      
                                                    ),
                                                  ),
                                                  Text(
                                                    "${(nfce['ListaProdutos'].length).toString().padLeft(2, '0')}",
                                                    textAlign: TextAlign.start,
                                                    overflow: TextOverflow.ellipsis,

                                                    style: TextStyle(
                                                      color: Color(0xFF455A64),
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                  )
                                                ],
                                              )
                                            ),
                                              
                                            
                                            
                                          ],
                                        )
                                        
                                      ]
                                    ),

                                )
                              )
                              
                            ]
                          ),

                        ) 
              );
  }
}