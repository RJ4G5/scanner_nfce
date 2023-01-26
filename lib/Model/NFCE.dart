// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:ffi';

class NFCE{
  String ?NomeFantasia;
  String ?NomeEmpresarial;
  String ?CNPJ;
  String ?InscricaoEstadual;
  String ?Endereco;
  String ?Chave;
  String ?ValorTotal;
  String ?Hora;
  String ?Data;
  List<Itens> ? ListProdutos;

  
  NFCE({ this.NomeFantasia, });
}

class Itens{  
  String ?Descricao;
  double ?Quantidade;
  String ?Unidade;
  double ?Valor;

}