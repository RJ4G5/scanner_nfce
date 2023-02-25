

import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';


import '../../global.dart';


class CardItensMaisComprados extends StatelessWidget{
  
  List<dynamic> grupo;
  CardItensMaisComprados(this.grupo, {super.key});

  @override
  Widget build(BuildContext context) {
    
    return Container(
                margin: EdgeInsets.only(bottom: 10),
                width: double.infinity,
                padding:EdgeInsets.all(5) ,
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      boxShadow: const [
                            BoxShadow(
                                  color: Color.fromARGB(33, 0, 0, 0),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                // changes position of shadow
                            ),
                        
                      ],
                ),
                child: FixedTimeline.tileBuilder(
                    theme: TimelineThemeData(
                          nodePosition: 0,
                          color: Color(0xFF1976D2),
                          indicatorTheme: IndicatorThemeData(
                              position:0,
                              size: 18.0,
                          ),
                          connectorTheme: ConnectorThemeData(
                              thickness: 2.5,
                          ),
                    ),

                    builder: TimelineTileBuilder.fromStyle(
                        contentsBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(grupo[index]["NomeEmpresarial"],style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff546E7A))),
                                 Itens(grupo[index]["Itens"])
                              ],
                            ),
                          ),
                        ),
                        itemCount: grupo.length,
                    )
                ),
    );
  }

}


class Itens extends StatelessWidget{
  
  List<dynamic> itens;
  Itens(this.itens, {super.key});

  @override
  Widget build(BuildContext context) {
    
    return Container(
                margin: EdgeInsets.only(bottom: 10),
                width: double.infinity,
                padding:EdgeInsets.all(5) ,
                // ignore: prefer_const_constructors
                
                child: FixedTimeline.tileBuilder(

                    theme: TimelineThemeData(

                          nodePosition: 0,
                          color: Color.fromARGB(144, 84, 110, 122),
                          indicatorTheme: IndicatorThemeData(
                              position: 0.5,
                              size: 15.0,
                          ),
                          connectorTheme: ConnectorThemeData(
                              thickness: 2.5,

                          ),
                          

                    ),

                    builder: TimelineTileBuilder.fromStyle(
                        connectorStyle: ConnectorStyle.dashedLine,
                        indicatorStyle: IndicatorStyle.outlined,
                        contentsBuilder: (context, index) => 
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                      Text(itens[index]["Descricao"],style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff78909C))),
                                     
                                      Container(
                                        padding:  EdgeInsets.only(left: 5,right: 5,bottom: 1,top: 1),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Color(0xff607D8B)
                                        ),
                                        child: Text("R\$: ${itens[index]["Valor"]}",style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 236, 236, 236))),
                                      )

                                  ],
                                 ),
                                 Container(
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(width: 1,color: Color.fromARGB(193, 192, 192, 192)))
                                  ),
                                  width: double.infinity,
                                  margin: EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                          Text("${itens[index]["data"]}  - ${itens[index]["hora"]}",style: TextStyle(fontSize: 12),),
                                          Text("Quant: ${ double.parse(itens[index]["Quantidade"]).toStringAsPrecision(2) }"),
                                      ],
                                    ),
                                 ),
                                
                                 
                              ],
                            ),
                          ),
                      
                        itemCount: itens.length,
                    )
                ),
    );
  }

}

