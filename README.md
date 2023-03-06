# Scanner NFC-e

Esse aplicativo é um exemplo de como seria legal se pudéssemos usar dados escaneados da NFC-e de produtos que compramos em supermercado, gerando por exemplo, relatórios com sugestões e estatística organizados de forma cronológica por datas.

Mas o grande obstáculo ao desenvolver esse tipo de projeto é a falta de padronização da NFC-e online, percebido durante os testes, cada supermercado cria sua própria descrição abreviada como, DET LIQ YPE 500ML (Código: 114240), se referindo ao detergente líquido Ypê, sendo opcional, o código do item depende do supermercado ou sistema para ser o código de barra, com isso, há uma dificuldade de desenvolver um aplicativo para a análise de itens usando NFC-e, já que não é fácil identificar o produto pelo seu código ou descrição.

O método mais eficiente, no limite do meu conhecimento, foi usar uma forma de similarizar o máximo possível um item com outro para obter grupos de produtos iguais e gerar uma análise a partir daquele grupo, com isso foi criado uma função que me entregasse em porcentagem o quanto um produto é similar ao outro, que em testes, apenas um valor a cima de 70% me entrega produtos iguais ou com diferenças de marcas, ou pesos, com isso muitos dados ficam de fora sendo classificados como lixo devido às diferentes formas de abreviação como, CH, para se referir a chocolate, tornando o projeto inviável.!

[DB_NFCEs dart - meu_mercado - Visual Studio Code 01_03_2023 22_57_33](https://user-images.githubusercontent.com/9409514/223276666-f63cbfd9-5210-4088-ab6b-71aa8119733a.png)


![Record_2023-03-06-10-41-43](https://user-images.githubusercontent.com/9409514/223279834-c1fdae3f-02a1-471f-8a52-d9c01ac88010.gif)
![Record_2023-03-06-11-24-23](https://user-images.githubusercontent.com/9409514/223279871-98182fe3-f9e1-4fea-8ce8-cdf43fa35bce.gif)
