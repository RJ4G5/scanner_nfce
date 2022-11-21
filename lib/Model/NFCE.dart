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
  List<Itens> ? ListProdutos;

  
  NFCE({ this.NomeFantasia, });
}

class Itens{
  int ?id;
  String ?Descricao;
  double ?Quantidade;
  String ?Unidade;
  double ?Valor;

}