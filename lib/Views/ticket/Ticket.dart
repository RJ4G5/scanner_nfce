import 'package:flutter/material.dart';
import 'package:meu_mercado/Model/NFCE.dart';
import 'package:ticketview/ticketview.dart';
import 'package:data_table_2/data_table_2.dart';

class Ticket extends StatelessWidget{


  late Map<String, dynamic> nfce;
  

  Ticket(this.nfce,  {Key? key}) : super(key: key);

  List<DataRow> getProdutos(List<dynamic> d){
   List<DataRow> list = [];
   
   d.forEach((item) {
      list.add(DataRow(
        cells:[
                DataCell(Text(item['Descricao'],style: TextStyle(fontFamily:"CourieNew",fontSize: 11))),
                DataCell( Align(alignment: Alignment.center ,child:Text(double.parse(item['Quantidade']).toStringAsPrecision(3),style: TextStyle(fontFamily:"CourieNew",fontSize: 11))) ),
                DataCell( Align(alignment: Alignment.center ,child:Text(item['Unidade'],style: TextStyle(fontFamily:"CourieNew",fontSize: 11)))),                
                DataCell(Align(alignment: Alignment.centerLeft ,child:Text("R\$ ${item['Valor']}",style: TextStyle(fontFamily:"CourieNew",fontSize: 11))))
              
              ]
        )
      );
      
   });
    
    


    return list;
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      color:  Color.fromARGB(0, 255, 255, 255),
      height: 600,
      //padding: EdgeInsets.all(10),
      child: TicketView(
                  
                backgroundPadding: EdgeInsets.only(top: 0, left: 50,right: 50),
                backgroundColor: Color(0xFF512DA8),
                contentPadding:  EdgeInsets.only(top: 20,bottom: 20,left: 0,right: 0), 
                drawArc: false,
                triangleAxis: Axis.vertical,

                borderRadius: 6,
                drawDivider: true,
                trianglePos: .8,
                child: Padding(
                  padding: EdgeInsets.only(top: 15,left: 10,right: 10,bottom: 10),
                  child: Column(
                    children: [
                      // ! cabeçalho
                      Container(
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                              child: Text(nfce['NomeEmpresarial'],textAlign:TextAlign.center ,style: TextStyle(fontFamily:"CourieNew", fontSize: 15,fontWeight: FontWeight.bold ),),

                            ),
                            
                            Text(nfce['Endereco'],textAlign:TextAlign.center ,style: TextStyle(fontFamily:"CourieNew", fontSize: 13 ),),
                            Text("CNPJ: ${nfce['Cnpj']}  IE: ${nfce['InscricaoEstadual']}",textAlign:TextAlign.start ,style: TextStyle(fontFamily:"CourieNew", fontSize: 12 ),)
                          ]
                        ),

                      ),
                      // ! produtos
                      Container(
                        width: double.infinity,
                        height: 325,
                        margin: EdgeInsets.only(bottom: 25),
                        decoration: BoxDecoration(
                          //border: Border.all(width: 1)
                        ),
                        child: DataTable2(
                            columnSpacing: 5,
                            horizontalMargin: 0,
                            headingRowHeight: 20,
                            dataRowHeight: 20,
                          

                            
                            //border: TableBorder.all(width: 1),
                            
                         

                          
                            columns: [
                              DataColumn2(size: ColumnSize.L,label:Text("Desc.",textAlign: TextAlign.center,style: TextStyle(fontFamily:"CourieNew",fontSize: 11,fontWeight: FontWeight.bold),)),
                              DataColumn2(fixedWidth: 50,label: Align(alignment: Alignment.center,child: Text("Quant.",style: TextStyle(fontFamily:"CourieNew",fontSize: 11,fontWeight: FontWeight.bold),),)),
                              DataColumn2(fixedWidth: 40,label: Align(alignment: Alignment.center,child: Text("Unid.",style: TextStyle(fontFamily:"CourieNew",fontSize: 11,fontWeight: FontWeight.bold),),)),
                              DataColumn2(fixedWidth: 70,label: Align(alignment: Alignment.center,child: Text("Valor",style: TextStyle(fontFamily:"CourieNew",fontSize: 11,fontWeight: FontWeight.bold)),))
                            ],
                            rows:getProdutos(nfce['ListaProdutos']) ,
                        )                       
                      ),
                       // ! rodapé
                      Container(
                        child: Column(
                          
                          children: [
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment. spaceBetween,
                              children: [
                                
                                Text("Quant. total: ${nfce['ListaProdutos'].length} ",style: TextStyle(fontFamily:"CourieNew",fontSize: 11,fontWeight: FontWeight.bold),),
                                Text("Total: R\$ ${nfce['ValorTotal']}",style: TextStyle(fontFamily:"CourieNew",fontSize: 11,fontWeight: FontWeight.bold),),
                                
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Emisão: ${nfce['data']} ${nfce['hora']}",style: TextStyle(fontFamily:"CourieNew",fontSize: 11,fontWeight: FontWeight.bold),),
                              ],
                            ),
                           Container(
                                  width: double.infinity,
                                  child:Text("Chave: ${nfce['Chave']}",softWrap: true,style: TextStyle(fontFamily:"CourieNew",fontSize: 11,),),
                                )
                          ],
                        ),
                      )
                      


                    ]
                ),

                  
                ),
            ),
    );
  }
}