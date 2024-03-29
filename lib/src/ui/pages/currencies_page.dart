import 'package:flutter/material.dart';
import 'package:flutter_app1/app_data.dart';
import 'package:flutter_app1/main.dart';
import 'package:flutter_app1/src/models/language_data.dart';

class CurrenciesPage extends StatefulWidget {
  @override
  _CurrenciesPageState createState() => _CurrenciesPageState();
}

class _CurrenciesPageState extends State<CurrenciesPage> {
  LanguageData selectedLanguageData;
  List<LanguageData> languages = [];

  @override
  void initState() {
    super.initState();

    LanguageData english = new LanguageData();
    english.languagesId = 0;
    english.name = "US Dolor";
    english.code = "\$";
    english.image = "";
    english.directory = "ltr";
    english.sortOrder = 1;
    english.direction = "ltr";
    english.status = 1;
    english.isDefault = 1;

    LanguageData arabic = new LanguageData();
    arabic.languagesId = 1;
    arabic.name = "UAE Dolor";
    arabic.code = "د.إ";
    arabic.image = "";
    arabic.directory = "ltr";
    arabic.sortOrder = 1;
    arabic.direction = "ltr";
    arabic.status = 1;
    arabic.isDefault = 1;

    languages.add(english);
    languages.add(arabic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Currency"),
      ),
      body: buildBody(context, languages),
    );
  }

  Widget buildBody(BuildContext context, List<LanguageData> languages) {
    if (languages.isNotEmpty) {
      selectedLanguageData = languages[0];
      return Stack(
        fit: StackFit.expand,
        children: [
          RadioListBuilder(languages, languageSelected, selectedLanguageData),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: FlatButton(
              color: Color.fromRGBO(20, 137, 54, 1),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                AppData.currencySymbol = selectedLanguageData.code;
                AppData.categories = null;
                AppData.banners = null;
                RestartWidget.restartApp(context);
              },
              child: Text(
                "Proceed",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      );
    } else
      return buildLoading();
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void languageSelected(LanguageData languageData) {
    this.selectedLanguageData = languageData;
  }
}

class RadioListBuilder extends StatefulWidget {
  final List<LanguageData> languages;
  final Function(LanguageData selectedLanguageData) languageSelected;
  final LanguageData selectedLanguageData;

  const RadioListBuilder(
      this.languages, this.languageSelected, this.selectedLanguageData);

  @override
  RadioListBuilderState createState() {
    return RadioListBuilderState();
  }
}

class RadioListBuilderState extends State<RadioListBuilder> {
  int value = 0;

  @override
  void initState() {
    super.initState();
    value = widget.selectedLanguageData.languagesId;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return RadioListTile(
          value: index,
          groupValue: value,
          onChanged: (ind) => setState(() {
            value = ind;
            widget.languageSelected(widget.languages[index]);
          }),
          title: Text(widget.languages[index].name),
          subtitle: Text(widget.languages[index].code),
        );
      },
      itemCount: widget.languages.length,
    );
  }
}
