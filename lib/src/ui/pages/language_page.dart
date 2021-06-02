import 'package:flutter/material.dart';
import 'package:flutter_app1/src/enums/language_enum.dart';
import 'package:flutter_app1/src/models/language_data.dart';
import 'package:flutter_app1/src/utils/locale_utils/language_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguagesPage extends StatefulWidget {
  @override
  _LanguagesPageState createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  LanguageData selectedLanguageData;
  List<LanguageData> languages = [];

  @override
  void initState() {
    super.initState();
/*
    // ignore: close_sinks
    final getLanguageBloc = BlocProvider.of<GetLanguageBloc>(context);
    getLanguageBloc.add(GetLanguages());
    */

    LanguageData english = new LanguageData();
    english.languagesId = 0;
    english.name = "English";
    english.code = "USD";
    english.image = "";
    english.directory = "ltr";
    english.sortOrder = 1;
    english.direction = "ltr";
    english.status = 1;
    english.isDefault = 1;

    LanguageData arabic = new LanguageData();
    arabic.languagesId = 1;
    arabic.name = "Arabic";
    arabic.code = "AR";
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
        title: Text("Language"),
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
              color: Colors.green[800],
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                BlocProvider.of<LanguageBloc>(context).add(LanguageSelected(
                    (selectedLanguageData.languagesId == 0)
                        ? Language.EN
                        : Language.AR));
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
