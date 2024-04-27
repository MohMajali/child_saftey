import 'dart:convert';
import 'dart:developer';
import 'package:ecommerce/pages/Chat/chat.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce/Data/Models/user_model.dart';
import 'package:ecommerce/Logic/GetServiceDetails/cubit/get_service_details_cubit.dart';
import 'package:ecommerce/Logic/GetUser/cubit/get_user_cubit.dart';
import 'package:ecommerce/Logic/MakeAppointement/bloc/make_appointement_bloc.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceDetailsScreen extends StatefulWidget {
  String serviceName;
  int serviceId;
  ServiceDetailsScreen(
      {super.key, required this.serviceName, required this.serviceId});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  int selected = -1;

  Future createConversation(int clientId) async {
    try {
      final body = jsonEncode({
        'patient_id': clientId,
        'midwife_id': 1,
      });
      var response = await http.post(Uri.parse('$URL/chats/'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: body);

      var conversationResponse = json.decode(response.body);
      return conversationResponse;
    } catch (err) {
      log('createConversation FUNCTION ===> $err');
      return err;
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetServiceDetailsCubit>(context)
        .getServiceDetails(widget.serviceId);
    UserModel userModel =
        BlocProvider.of<GetUserCubit>(context).state.props[0] as UserModel;
    return BlocListener<MakeAppointementBloc, MakeAppointementState>(
        listener: (context, state) {
      if (state is makeAppointementLoading) {
        const Center(child: CircularProgressIndicator());
      } else if (state is makeAppointementSuccess) {
        SuccessAlertBox(
            title: "Success",
            messageText: state.message,
            context: context,
            titleTextColor: Colors.amber);
        BlocProvider.of<GetServiceDetailsCubit>(context)
            .getServiceDetails(widget.serviceId);
      } else if (state is makeAppointementError) {
        WarningAlertBoxCenter(
            messageText: state.message,
            // icon: Icons.alarm,
            context: context,
            titleTextColor: Colors.red);
      }
    }, child: BlocBuilder<GetServiceDetailsCubit, GetServiceDetailsState>(
            builder: (context, state) {
      if (state is GetServiceDetailsLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is GetServiceDetailsSuccess) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                body: SingleChildScrollView(
                    child: Column(children: [
              const SizedBox(height: 50),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(Icons.arrow_back_ios_new,
                                  color: Colors.black, size: 25)),
                          InkWell(
                              onTap: () {},
                              child: const Icon(Icons.more_vert,
                                  color: Colors.black, size: 25))
                        ]),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(
                                      '$URL/${state.serviceModel.service.image}')),
                              const SizedBox(height: 15),
                              Text(state.serviceModel.service.name,
                                  style: const TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                              const SizedBox(height: 5),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            shape: BoxShape.circle),
                                        child: const Icon(Icons.call,
                                            color: Colors.black, size: 25)),
                                    const SizedBox(width: 20),
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            shape: BoxShape.circle),
                                        child: InkWell(
                                          onTap: () async {
                                            await createConversation(
                                                    userModel.userData.id)
                                                .then((value) {
                                              if (!value['error']) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatScreen(
                                                                conversationId:
                                                                    value[
                                                                        'conversation_id'],
                                                                clientId:
                                                                    userModel
                                                                        .userData
                                                                        .id)));
                                              } else {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatScreen(
                                                                conversationId:
                                                                    value['id'],
                                                                clientId:
                                                                    userModel
                                                                        .userData
                                                                        .id)));
                                              }
                                            });
                                          },
                                          child: const Icon(Icons.chat,
                                              color: Colors.black, size: 25),
                                        ))
                                  ])
                            ]))
                  ])),
              const SizedBox(height: 20),
              Container(
                  // height: MediaQuery.of(context).size.height / 1.5,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 20, right: 15),
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text('تفاصيل الخدمة',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                        const SizedBox(height: 5),
                        Text(state.serviceModel.service.description,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white)),
                        const SizedBox(height: 10),
                        Row(children: [
                          const Text("التواريخ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                          const SizedBox(width: 10),
                          const Icon(Icons.star, color: Colors.amber),
                          const Text('الأوقات',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white)),
                          const SizedBox(width: 5),
                          Text('${state.serviceModel.service.dates.length}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black)),
                          const Spacer(),
                          TextButton(
                              onPressed: () {},
                              child: const Text("",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.white)))
                        ]),
                        SizedBox(
                            height: 110,
                            child: ListView.builder(
                                itemCount:
                                    state.serviceModel.service.dates.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  return InkWell(
                                      onTap: () {
                                        setState(() {
                                          selected = i;
                                        });
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                selected != i
                                                    ? const BoxShadow(
                                                        color: Colors.white,
                                                        blurRadius: 4,
                                                        spreadRadius: 2)
                                                    : const BoxShadow(
                                                        color: Colors.black,
                                                        blurRadius: 4,
                                                        spreadRadius: 2)
                                              ]),
                                          child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.4,
                                              child: Column(children: [
                                                ListTile(
                                                    title: Center(
                                                        child: Text(
                                                            '${convertTimeTo12System(state.serviceModel.service.dates[i].fromTime)} - ${convertTimeTo12System(state.serviceModel.service.dates[i].toTime)}',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                    subtitle: Center(
                                                        child: Text(convertDate(
                                                            '${state.serviceModel.service.dates[i].date}'))))
                                              ]))));
                                })),
                        state.serviceModel.service.dates.isEmpty
                            ? Container()
                            : Center(
                                child: TextButton(
                                    onPressed: () {
                                      BlocProvider.of<MakeAppointementBloc>(
                                              context)
                                          .add(makeAppointementButtonPressed(
                                              clientId: userModel.userData.id,
                                              dateId: state.serviceModel.service
                                                  .dates[selected].id,
                                              doctorId: state.serviceModel
                                                  .service.doctorId,
                                              serviceId: state
                                                  .serviceModel.service.id));
                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: const BorderSide(
                                                    color: Colors.white)))),
                                    child: const Text("Make Appointement",
                                        style: TextStyle(color: Colors.white))))
                      ]))
            ]))));
      }
      return Container();
    }));
  }
}
