import 'dart:developer';

import 'package:ecommerce/Data/Models/user_model.dart';
import 'package:ecommerce/Logic/GetUser/cubit/get_user_cubit.dart';
import 'package:ecommerce/Logic/UpdateAccount/bloc/update_account_bloc.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel userModel =
        BlocProvider.of<GetUserCubit>(context).state.props[0] as UserModel;
    final _formKey = GlobalKey<FormState>();

    TextEditingController nameCont = TextEditingController();
    TextEditingController emailCont = TextEditingController();
    TextEditingController passCont = TextEditingController();
    TextEditingController phoneCont = TextEditingController();

    nameCont.text = userModel.userData.name;
    emailCont.text = userModel.userData.email;
    passCont.text = userModel.userData.password;
    phoneCont.text = userModel.userData.phone;

    return Scaffold(
        appBar: AppBar(
            title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("الصفحة الشخصية")]),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Ionicons.notifications_outline)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Ionicons.search_outline))
            ]),
        body: BlocListener<UpdateAccountBloc, UpdateAccountState>(
            listener: (context, state) {
              if (state is UpdateAccountLoading) {
                const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );
              } else if (state is UpdateAccountSuccess) {
                SuccessAlertBox(
                    title: "تعديل الحساب",
                    context: context,
                    messageText: "تم التعديل بنجاح",
                    buttonColor: darkBlue,
                    icon: Icons.check_circle,
                    titleTextColor: darkBlue);
                BlocProvider.of<GetUserCubit>(context)
                    .getUserModel(userModel.userData.id);
                // log('${BlocProvider.of<GetUserCubit>(context).userModel.userData.name}');
              } else if (state is UpdateAccountError) {
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
                    nameInput(nameCont),
                    emailInput(emailCont),
                    phoneInput(phoneCont),
                    passwordInput(passCont),
                    button(
                        text: "تعديل الحساب",
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<UpdateAccountBloc>(context).add(
                                UpdateAccountButtonPressed(
                                    name: nameCont.text,
                                    email: emailCont.text,
                                    password: passCont.text,
                                    phone: phoneCont.text,
                                    userId: userModel.userData.id));
                          }
                        })
                  ]))
            ]))));
  }
}
