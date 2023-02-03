import 'package:flutter/material.dart';
import 'package:meu_mercado/Model/NFCE.dart';
import 'package:ticketview/ticketview.dart';


class Ticket extends StatelessWidget{


  late Map<String, dynamic> nfce;
  

  Ticket(this.nfce,  {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color:  Color.fromARGB(0, 255, 255, 255),
      //padding: EdgeInsets.all(10),
      child: TicketView(
                  
                backgroundPadding: EdgeInsets.only(top: 0, left: 50,right: 50),
                backgroundColor: Color(0xFF512DA8),
                contentPadding:  EdgeInsets.only(top: 20,bottom: 20,left: 0,right: 0), 
                drawArc: false,
                triangleAxis: Axis.vertical,

                borderRadius: 6,
                drawDivider: true,
                trianglePos: .6,
                child: Padding(
                  padding: EdgeInsets.only(top: 15,left: 10,right: 10,bottom: 10),
                  child: Column(
                    children: [
                      // ! cabeçalho
                      Container(
                        child: Column(
                          children: [
                            Text(nfce['NomeEmpresarial'],textAlign:TextAlign.center ,style: TextStyle(fontFamily:"CourieNew", fontSize: 15,fontWeight: FontWeight.bold ),),
                            Text(nfce['Endereco'],textAlign:TextAlign.center ,style: TextStyle(fontFamily:"CourieNew", fontSize: 13 ),),
                            Text("CNPJ: ${nfce['Cnpj']}  IE: ${nfce['InscricaoEstadual']}",textAlign:TextAlign.start ,style: TextStyle(fontFamily:"CourieNew", fontSize: 12 ),)
                          ]
                        ),

                      ),
                      Container(
                        width: double.infinity,
                        child:DataTable(
                          border: TableBorder.all(width: 1),
                          columnSpacing: 5,


                          headingRowHeight: 20,
                          dataRowHeight: 20,
                          columns: [
                            DataColumn(label: Text("Desc.",style: TextStyle(fontSize: 11),)),
                            DataColumn(label: Text("Quant.",style: TextStyle(fontSize: 11),)),
                            DataColumn(label: Text("Unid.",style: TextStyle(fontSize: 11),)),
                            DataColumn(label: Text("Valor",style: TextStyle(fontSize: 11)))
                              
                          ],
                          rows: [
                            DataRow(cells:[
                              DataCell(
                                Container(
                             
                                  child: Text("refrig coca cola",style: TextStyle(fontSize: 11))
                                ),
                              ),
                              DataCell(  Text("02",style: TextStyle(fontSize: 11))
                               
                              ),
                              DataCell( Text("un",style: TextStyle(fontSize: 11))
                                ),
                             
                              DataCell(
                                Text("00:00",style: TextStyle(fontSize: 11))
                              )
              
                           
                            ])
                            
                          ],
                        ) ,
                      )
                      


                    ]
                ),

                  
                ),
            ),
    );
  }
}