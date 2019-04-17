import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  FocusNode mUserNameFd;
  FocusNode mPwdFd;
  FocusScopeNode fsn;
  TextEditingController mUserController;
  TextEditingController mPwdController;

  final GlobalKey<ScaffoldState> _key = new GlobalKey();
  final GlobalKey<FormState> _formKey = new GlobalKey();
  TextEditingController mUserController2;
  TextEditingController mPwdController2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mUserNameFd = new FocusNode();
    mPwdFd = FocusNode();

    mUserController = TextEditingController();
    mPwdController = TextEditingController();

    mUserController.addListener(() {
      print("User name = ${mUserController.text}");
    });

    mPwdController.addListener(() {
      print("paddword = ${mPwdController.text}");
    });

    mUserController2 = TextEditingController();
    mPwdController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.people),
                    labelText: "UserName:",
                    hintText: "please input user name",
                  ),
                  focusNode: mUserNameFd,
                  controller: mUserController,
                  onSubmitted: (text) {
                    print("finally, user name = $text");
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: "Password:",
                    hintText: "please input password",
                  ),
                  obscureText: true,
                  focusNode: mPwdFd,
                  controller: mPwdController,
                  onSubmitted: (text) {
                    print("finally, password = $text");
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          mUserNameFd.unfocus();
                          mPwdFd.unfocus();
                          if (mUserController.text == "" ||
                              mPwdController.text == "") {
                            _key.currentState.showSnackBar(
                                SnackBar(content: Text("不能为空！！")));
                          }
                        },
                        child: Text("Submit"),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        if (fsn == null) {
                          fsn = FocusScope.of(context);
                        }

                        fsn.requestFocus(mPwdFd);
                      },
                      child: Text("request focus"),
                    ),
                    RaisedButton(
                      onPressed: () {
                        mUserNameFd.unfocus();
                        mPwdFd.unfocus();
                      },
                      child: Text("hide softkeyguard"),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: mUserController2,
                        decoration: InputDecoration(
                            labelText: "用户名：",
                            prefixIcon: Icon(Icons.people),
                            hintText: "用户名或邮箱"),
                        keyboardType: TextInputType.text,
                        autofocus: true,
                        validator: (text) {
                          return text.trim().length > 0 ? null : "用户名不能为空";
                        },
                      ),
                      TextFormField(
                          controller: mPwdController2,
                          decoration: InputDecoration(
                              labelText: "密码：",
                              prefixIcon: Icon(Icons.lock),
                              hintText: "密码"),
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          obscureText: true,
                          validator: (text) {
                            return text.trim().length > 5 ? null : "密码需大于6位数字";
                          }),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _key.currentState.showSnackBar(SnackBar(
                                      content: Text(
                                          "用户名：${mUserController2.text}, 密码：${mPwdController2.text}")));
                                }
                              },
                              child: Text("登录"),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                  autovalidate: true,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
