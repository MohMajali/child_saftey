import 'package:ecommerce/Logic/SignUp/bloc/sign_up_bloc.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/pages/Login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
  Body({super.key});

  final _formKey = GlobalKey<FormState>();

  TextEditingController nationalId = TextEditingController();
  TextEditingController familyBookId = TextEditingController();
  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController passConfirmCont = TextEditingController();

  bool visiblePass = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignupLoading) {
            const Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is UserSignupSuccess) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          } else if (state is UserSignupError) {
            WarningAlertBoxCenter(
                messageText: state.message,
                // icon: Icons.alarm,
                context: context,
                titleTextColor: Colors.red);
          }
        },
        child: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(height: 20),
          Form(
              key: _formKey,
              child: Column(children: [
                familyIdInput(),
                nationalIdInput(),
                nameInput(nameCont),
                phoneInput(phoneCont),
                passwordInput(passCont),
                button(
                    text: "تسجيل حساب",
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<SignUpBloc>(context).add(
                            SignupButtonPressed(
                                nationalId: nationalId.text,
                                familyBookId: familyBookId.text,
                                name: nameCont.text,
                                email: emailCont.text,
                                password: passCont.text,
                                phone: phoneCont.text));
                      }
                    })
              ]))
        ])));
  }

  Padding familyIdInput() {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: TextFormField(
            keyboardType: TextInputType.text,
            controller: familyBookId,
            validator: (familyId) {
              if (familyId!.isEmpty) {
                return 'Please fill';
              }
              return null;
            },
            decoration: decoration(
                labelText: 'رقم دفتر العائلة',
                hintText: 'ادخل رقم دفتر العائلة',
                icon: const Icon(Icons.book, color: Colors.blue))));
  }

  Padding nationalIdInput() {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: TextFormField(
            keyboardType: TextInputType.text,
            controller: nationalId,
            validator: (nationalId) {
              if (nationalId!.isEmpty) {
                return 'Please fill';
              }
              return null;
            },
            decoration: decoration(
                labelText: 'الرقم الوطني',
                hintText: 'ادخل الرقم الوطني',
                icon: const Icon(Icons.numbers, color: Colors.blue))));
  }
}
