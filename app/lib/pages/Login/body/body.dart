import 'package:ecommerce/Logic/GetUser/cubit/get_user_cubit.dart';
import 'package:ecommerce/Logic/Login/bloc/login_bloc.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/pages/Signup/sign_up.dart';
import 'package:ecommerce/pages/home_page.dart';
import 'package:ecommerce/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController familyId = TextEditingController();
  TextEditingController passCont = TextEditingController();
  LoginBloc? loginBloc;
  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    return MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(listener: (context, state) {
            if (state is LoginLoading) {
              const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            } else if (state is UserLoginSuccess) {
              BlocProvider.of<GetUserCubit>(context).getUserModel(state.userId);
            } else if (state is UserLoginError) {
              WarningAlertBoxCenter(
                  messageText: state.message,
                  // icon: Icons.alarm,
                  context: context,
                  titleTextColor: Colors.red);
            }
          }),
          BlocListener<GetUserCubit, GetUserState>(listener: (context, state) {
            if (state is GetUserLoading) {
              const Center(
                  child: CircularProgressIndicator(color: Colors.blue));
            } else if (state is GetUserSuccess) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                  (route) => false);
            } else if (state is GetUserError) {
              WarningAlertBoxCenter(
                  messageText: state.message,
                  // icon: Icons.alarm,
                  context: context,
                  titleTextColor: Colors.red);
            }
          })
        ],
        child: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(height: 20),
          Form(
              key: _formKey,
              child: Column(children: [
                familyIdInput(),
                passwordInput(),
                const SizedBox(height: 10),
                button(
                    text: "تسجيل دخول",
                    press: () async {
                      if (_formKey.currentState!.validate()) {
                        loginBloc?.add(LoginButtonPressed(
                            family_book_id: familyId.text,
                            password: passCont.text));
                      }
                    }),
                const SizedBox(height: 20),
                divider(),
                const SizedBox(height: 10),
                button(
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()));
                    },
                    text: "إنشاء حساب"),
              ]))
        ])));
  }

  Padding familyIdInput() {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: TextFormField(
            keyboardType: TextInputType.text,
            controller: familyId,
            validator: (familyId) {
              if (familyId!.isEmpty) {
                return 'Please fill';
              }
              return null;
            },
            decoration: decoration(
                labelText: 'رقم دفتر العائلة',
                hintText: 'ادخل رقم دفتر العائلة',
                icon: const Icon(Icons.email, color: Colors.blue))));
  }

  Padding passwordInput() {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            controller: passCont,
            validator: (pass) {
              if (pass!.isEmpty) {
                return 'Please fill';
              }
              return null;
            },
            decoration: decoration(
                labelText: 'كلمة السر',
                hintText: 'ادخل كلمة السر',
                icon: const Icon(Icons.lock, color: Colors.blue))));
  }
}
