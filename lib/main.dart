import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}



class Home extends StatefulWidget { //stful
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightControler = TextEditingController(); //controladro peso
  TextEditingController heightControler = TextEditingController(); //controlador altura

  GlobalKey<FormState> _formKey= GlobalKey<FormState>(); //chave global

  String _infoText = "Informe seus dados";

  void _resetField() {
    weightControler.text = ""; //controladores n precisam ser redesenhados
    heightControler.text = "";
    setState(() { //preciso redesenhar a string já que ela esta sendo atualizada
      _infoText = "Informe seus dados";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightControler.text);
      double height = double.parse(heightControler.text) / 100; // /100 pq esta em cm
      double imc = weight / (height * height); //calculo do imc

      if (imc < 18.6) {
        _infoText = "Abaixo do peso(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III(${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetField,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form( //campo formulario
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, //alinhou ao centro no eixo X
              children: [
                Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.green,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration( //texto guia de preenchimento
                      labelText: "Peso (Kg)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center, //texto digitado
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: weightControler,
                  validator: (value){ //faz a validação do campo
                    if (value.isEmpty){
                      return "Insira seu peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heightControler,
                  validator: (value){
                    if (value.isEmpty){
                      return "Insira sua Altura!";
                    }
                  },
                ),
                Padding( //padding para aumentar o tamanho do botão
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0), //margens
                    child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: (){
                            if(_formKey.currentState.validate()){ //verifica se o formulario esta valido
                              _calculate();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          color: Colors.green,
                        ))),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
