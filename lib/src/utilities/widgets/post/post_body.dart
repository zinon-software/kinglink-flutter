import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:whatsapp_group_links/src/api/services/group_services.dart';

class PostBody extends StatefulWidget {
  final urlServer;
  final nativeIsAd;
  const PostBody({Key key, this.urlServer, this.nativeIsAd}) : super(key: key);

  @override
  _PostBodyState createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String _titel, _linke, _selection;

  List dataSelection = []; //edited line

  Future<String> getSectionsData() async {
    var res = await http.get(
        Uri.parse('https://kinglink.herokuapp.com/api/Sections'),
        headers: {"Accept": "application/json"});
    var resBody = jsonDecode(utf8.decode(res.bodyBytes));
    setState(() {
      dataSelection = resBody;
    });
    return "Sucess";
  }

  @override
  void initState() {
    super.initState();

    this.getSectionsData();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<GroupServices>(context);

    _submit() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        await postProvider.postGroup(
          context,
          _titel,
          _linke.trim(),
          _selection,
        );
      }
    }

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "السياسة والشروط",
                      style: TextStyle(color: Colors.red),
                    ),
                    IconButton(
                      icon: Icon(Icons.report),
                      color: Colors.black,
                      onPressed: () => theConditions(),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Text(' أقسام الرابط'),
                      SizedBox(width: 10),
                      Container(
                        alignment: Alignment.center,
                        color: Color.fromARGB(255, 127, 196, 241),
                        child: DropdownButton(
                          items: dataSelection.map((item) {
                            return new DropdownMenuItem(
                              child: Center(child: new Text(item['name'])),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              _selection = newVal;
                            });
                          },
                          value: _selection,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 10.0,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => _titel = input,
                          decoration: InputDecoration(
                            labelText: "العنوان",
                            prefixIcon: Icon(Icons.email),
                            hintText: "عنوان المجموعة",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (input) => input.length < 4
                              ? 'يجب  الا يقل العنوان عن 4 احرف'
                              : null,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 10.0,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => _linke = input,
                          decoration: InputDecoration(
                            labelText: "الرابط",
                            prefixIcon: Icon(Icons.link),
                            hintText: "رابط المجموعة",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (input) => !input.contains('http')
                              ? 'الرابط غير صحيح'
                              : null,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            primary: Colors.black,
                            backgroundColor: Color.fromARGB(255, 127, 196, 241),
                          ),
                          onPressed: _submit,
                          child: postProvider.isLoading
                              ? CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Color.fromARGB(255, 10, 10, 10)),
                                )
                              : Text(
                                  'مشاركة',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Billabong',
                                    fontSize: 20.0,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      if (postProvider.errorMessage != null)
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          margin: EdgeInsets.all(5),
                          color: Colors.amberAccent,
                          child: ListTile(
                            title: Text(postProvider.errorMessage),
                            leading: Icon(Icons.error),
                            trailing: IconButton(
                                onPressed: () =>
                                    postProvider.setErrorMessage(null),
                                icon: Icon(Icons.close)),
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  theConditions() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('تعليمات النشر'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.0 / 3,
              ),
              Text("بسم الله الرحمن الرحيم"),
              SizedBox(
                height: 20.0 / 3,
              ),
              Icon(Icons.report),
              Text(" قم بتعبئة جميع الحقول "),
              SizedBox(
                height: 20.0 / 3,
              ),
              Text(" لن يتم عرض الرابط المنشٌُور الا بعد التاكد من صحته "),
              SizedBox(
                height: 20.0 / 3,
              ),
              Text(
                  " لاتقم بتكرار الرابط عند تعقبنا لتكرار يتم حذف جميع الروابط "),
              SizedBox(
                height: 20.0 / 3,
              ),
              Text(" احرص علئ ان يحصل الرابط الخاص بك على اعلى نسب المشاهدة "),
              SizedBox(
                height: 20.0 / 3,
              ),
              Text("تاكد بان حقل الرابط لا يحتوي على احرف او كلمات زائدة "),
              SizedBox(
                height: 20.0 / 3,
              ),
              Text(
                  "يمكنك نشر جميع حسابتك من مختلف منصات التواصل الاجتماعي مثلاً  Tik Tok   يوتيوب سناب واتساب.... "),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('فهمت'),
          ),
        ],
      ),
    );
  }
}
