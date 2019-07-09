import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Interest Calculator",
    home: CalculatorForm(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class CalculatorForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CalculatorState();
  }
}

class CalculatorState extends State<CalculatorForm> {
  var _minPadding = 5.0;
  var _currencies = ["Taka", "Dollar", "Euro"];
  var _currencySelected = '';
  var _displayResult = "";

  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _currencySelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Interest Calculator")),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(_minPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.all(_minPadding),
                    child: TextFormField(
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      controller: principalController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter principal amount";
                        }
                      },
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent, fontSize: 15.0),
                          labelText: "Principal",
                          hintText: "Enter Principal number e.g. 1000",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.all(_minPadding),
                    child: TextFormField(
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      controller: roiController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter interest rate";
                        }
                      },
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent, fontSize: 15.0),
                          labelText: "Interest",
                          hintText: "Enter interest rate",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.all(_minPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          style: textStyle,
                          keyboardType: TextInputType.number,
                          controller: termController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please enter term";
                            }
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 15.0),
                              labelText: "Term",
                              hintText: "Enter Term",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                        Container(
                          width: _minPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String dropDownItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownItem,
                              child: Text(dropDownItem),
                            );
                          }).toList(),
                          value: _currencySelected,
                          onChanged: (String newValue) {
                            setState(() {
                              _currencySelected = newValue;
                            });
                          },
                        ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.all(_minPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            "Calculate",
                            textScaleFactor: 1.2,
                          ),
                          onPressed: () {
                            //action
                            setState(() {
                              if (_formKey.currentState.validate())
                                this._displayResult = _calculateAmount();
                            });
                          },
                          elevation: 5.0,
                        )),
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              "Reset",
                              textScaleFactor: 1.2,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                            elevation: 5.0,
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minPadding * 2),
                  child: Text(
                    _displayResult,
                    style: textStyle,
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage("images/interest-512.png");
    Image image = Image(image: assetImage, width: 150.0, height: 120.0);

    return Container(
      child: image,
      margin: EdgeInsets.all(_minPadding * 10),
    );
  }

  String _calculateAmount() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double terms = double.parse(termController.text);

    double amountPayable = principal + (principal * roi * terms) / 100;

    return "After $terms years, Amount payable will be: $amountPayable $_currencySelected";
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";

    _currencySelected = _currencies[0];
    _displayResult = "";
  }
}
