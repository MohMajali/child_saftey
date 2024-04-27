import 'package:ecommerce/Data/Models/appointements_model.dart';
import 'package:ecommerce/Data/Models/user_model.dart';
import 'package:ecommerce/Logic/GetClientAppointements/cubit/get_client_appointements_cubit.dart';
import 'package:ecommerce/Logic/GetUser/cubit/get_user_cubit.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class AppointementsScreen extends StatelessWidget {
  const AppointementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel userModel =
        BlocProvider.of<GetUserCubit>(context).state.props[0] as UserModel;
    BlocProvider.of<GetClientAppointementsCubit>(context)
        .appointementsDetailsModel(userModel.userData.id);
    AppointementsDetailsModel model =
        AppointementsDetailsModel(error: false, clientAppointments: []);
    return Scaffold(
        appBar: AppBar(
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("مرحبا ${userModel.userData.name}"),
              Text("كيف حالك؟",
                  style: Theme.of(context).textTheme.bodySmall)
            ]),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Ionicons.notifications_outline)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Ionicons.search_outline))
            ]),
        body: BlocBuilder<GetClientAppointementsCubit,
            GetClientAppointementsState>(builder: (context, state) {
          if (state is GetClientAppointementsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetClientAppointementsSuccess) {
            model = state.appointementsDetailsModel;
            return SingleChildScrollView(
                padding: const EdgeInsets.all(14),
                child: Column(
                    children:
                        List.generate(model.clientAppointments.length, (i) {
                  return InkWell(
                      onTap: () {
                        InfoAlertBox(
                            context: context,
                            title: "تفاصيل الموعد",
                            buttonText: "OK",
                            infoMessage: model.clientAppointments[i]
                                    .appointmentsReviews.isNotEmpty
                                ? model.clientAppointments[i]
                                    .appointmentsReviews[0].review
                                : "لا يوجد مواعيد حاليا");
                      },
                      child: ItemWidget(
                          image:
                              '$URL/${model.clientAppointments[i].service.image}',
                          title: state.appointementsDetailsModel
                              .clientAppointments[i].service.name,
                          otherData:
                              '${convertDate('${model.clientAppointments[i].servicesDate.date}')} ${convertTimeTo12System(model.clientAppointments[i].servicesDate.fromTime)} - ${convertTimeTo12System(state.appointementsDetailsModel.clientAppointments[i].servicesDate.fromTime)}',
                          isHaveDoctor: true,
                          doctorName:
                              'الحالة : ${model.clientAppointments[i].status}'));
                })));
          }
          return Container();
        }));
  }
}
