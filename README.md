# Scanner NFC-e

Esse aplicativo é um exemplo de como seria legal se pudéssemos usar dados escaneados da NFC-e de produtos que compramos em supermercado, gerando por exemplo, relatórios com sugestões e estatística organizados de forma cronológica por datas.

Mas o grande obstáculo ao desenvolver esse tipo de projeto é a falta de padronização da NFC-e online, percebido durante os testes, cada supermercado cria sua própria descrição abreviada como, DET LIQ YPE 500ML (Código: 114240), se referindo ao detergente líquido Ypê, sendo opcional, o código do item depende do supermercado ou sistema para ser o código de barra, com isso, há uma dificuldade de desenvolver um aplicativo para a análise de itens usando NFC-e, já que não é fácil identificar o produto pelo seu código ou descrição.

O método mais eficiente, no limite do meu conhecimento, foi usar uma forma de similarizar o máximo possível um item com outro para obter grupos de produtos iguais e gerar uma análise a partir daquele grupo, com isso foi criado uma função que me entregasse em porcentagem o quanto um produto é similar ao outro, que em testes, apenas um valor a cima de 70% me entrega produtos iguais ou com diferenças de marcas, ou pesos, com isso muitos dados ficam de fora sendo classificados como lixo devido às diferentes formas de abreviação como, CH, para se referir a chocolate, tornando o projeto inviável.!



<div > 
<img src="https://user-images.githubusercontent.com/9409514/223276666-f63cbfd9-5210-4088-ab6b-71aa8119733a.png" width="500"  > 


</div>



<div > 
<img src="https://user-images.githubusercontent.com/9409514/223279834-c1fdae3f-02a1-471f-8a52-d9c01ac88010.gif" height="500"  > 
<img src="https://user-images.githubusercontent.com/9409514/223279871-98182fe3-f9e1-4fea-8ce8-cdf43fa35bce.gif" height="500"  > 

</div>

## Deixo algumas NFC-e de Minas Gerais como exemplo
<br>

<div>
<img src="https://user-images.githubusercontent.com/9409514/223842933-f5784a16-d35a-4676-9445-8461413246a4.png" width="200" height="200" align="left" > 
<img src="https://user-images.githubusercontent.com/9409514/223846153-3fbf9cae-b0da-4336-90e5-e27910cf9822.png" width="200" height="200" align="left">
<img src="https://user-images.githubusercontent.com/9409514/223847238-84a53b3e-c39c-4bbe-b231-564d59da5b55.png" width="200" height="200" align="left">
<img src="https://user-images.githubusercontent.com/9409514/223847241-01e02ba6-4b81-47e6-a2ef-9f7afe750411.png" width="200" height="200" align="left">

<img src="https://user-images.githubusercontent.com/9409514/223847242-1562b989-b2cc-4e40-94dc-0992e9392f72.png" width="200" height="200" align="left">
<img src="https://user-images.githubusercontent.com/9409514/223847245-b1465552-bd9f-4e31-af7e-937f2a27db7c.png" width="200" height="200" align="left">
<img src="https://user-images.githubusercontent.com/9409514/223847249-ff161a4e-b579-4cc7-98fb-794112b4faf3.png" width="200" height="200" align="left">
<img src="https://user-images.githubusercontent.com/9409514/223847252-9f7e2ad6-b664-4f35-8948-69eea4d93f59.png" width="200" height="200" align="left">
<img src="https://user-images.githubusercontent.com/9409514/223847258-1b327ff9-54ca-4814-b80d-558d27d0ab06.png" width="200" height="200" align="left">
<img src="https://user-images.githubusercontent.com/9409514/223847263-209495fe-6ca1-444d-9b12-450e6db00064.png" width="200" height="200" align="left">
<img src="https://user-images.githubusercontent.com/9409514/223847264-f24a37bd-9a84-4439-8156-b7d9d951ec52.png" width="200" height="200" align="left">
<img src="https://user-images.githubusercontent.com/9409514/223847266-177fe92a-61b7-4a44-aa1b-147567435bb5.png" width="200" height="200" align="left">
<img src="https://user-images.githubusercontent.com/9409514/223847269-b7f68b10-0c5e-4c30-b6ae-810492850189.png" width="200" height="200" align="left">
  
  </div>

