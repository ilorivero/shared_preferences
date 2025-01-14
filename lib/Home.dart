import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _textoSalvo = "Nada salvo!";
  TextEditingController _textController = TextEditingController();
  //o método será assincrono, ou seja, ao salvar os dados não necessariamente serão salvos de forma instantânea
  //executado de forma paralela
  _salvarDados() async{
    String valorDigitado = _textController.text;
    // Aqui vamos usar SharedPreferencesAsync. O original (SharedPreferences) foi Deprecated
    // Ainda temos o SharedPreferencesCached, mas não vai ser abordado na disciplina
    final SharedPreferencesAsync prefs = await SharedPreferencesAsync();
    await prefs.setString("nome", valorDigitado); // a chave será usada para recuperar dados
    print("Operação salvar: $valorDigitado");
  }
  _recuperarDados() async{
    final SharedPreferencesAsync prefs = await SharedPreferencesAsync();
    final String? _textoRecuperado = await prefs.getString("nome");
    setState(()  {
      _textoSalvo = _textoRecuperado ?? "Sem valor";
    });
    print("Operação recuperar: $_textoSalvo");
  }
  _removerDados() async{
    final SharedPreferencesAsync prefs = await SharedPreferencesAsync();
    prefs.remove("nome");
    print("Operação remover");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Persistência de dados"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "Digite o nome: ",
              ),
              controller: _textController,
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text("Salvar"),
                  onPressed: _salvarDados,
                ),
                SizedBox(width: 16,),
                ElevatedButton(
                  child: Text("Recuperar"),
                  onPressed: _recuperarDados,
                ),
                SizedBox(width: 16,),
                ElevatedButton(
                  child: Text("Remover"),
                  onPressed: _removerDados,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 100),
                ),
                Text(_textoSalvo,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
