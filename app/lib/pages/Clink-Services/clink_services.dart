import 'package:ecommerce/Logic/GetServices/cubit/get_services_cubit.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/pages/Clink-Services/service_details.dart';
import 'package:ecommerce/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class ClinkServices extends StatelessWidget {
  String clinkName;
  int clinkId;
  ClinkServices({super.key, required this.clinkName, required this.clinkId});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetServicesCubit>(context).getServicesOnClinkId(clinkId);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(clinkName),
                    ]),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Ionicons.notifications_outline)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Ionicons.search_outline))
                ]),
            body: BlocBuilder<GetServicesCubit, GetServicesState>(
                builder: (context, state) {
              if (state is GetServicesLoading) {
                const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetServicesSuccess) {
                return SingleChildScrollView(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                        children: List.generate(
                            state.serviceModel.services.length, (i) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ServiceDetailsScreen(
                                        serviceId: 1, serviceName: "Test")));
                          },
                          child: ItemWidget(
                            image:
                                '$URL/${state.serviceModel.services[i].image}',
                            title: state.serviceModel.services[i].name,
                            otherData: state.serviceModel.services[i]
                                        .description.length >
                                    25
                                ? '${state.serviceModel.services[i].description.substring(0, 25)}...'
                                : state.serviceModel.services[i].description,
                            isHaveDoctor: true,
                            doctorName:
                                state.serviceModel.services[i].user.name,
                          ));
                    })));
              }
              return Container();
            })));
  }
}
