import 'package:ecommerce/Data/Models/location_model.dart';
import 'package:ecommerce/Data/Models/user_model.dart';
import 'package:ecommerce/Logic/GetClinks/cubit/get_clinks_cubit.dart';
import 'package:ecommerce/Logic/GetLocations/cubit/get_locations_cubit.dart';
import 'package:ecommerce/Logic/GetUser/cubit/get_user_cubit.dart';
import 'package:ecommerce/widgets/health_needs.dart';
import 'package:ecommerce/widgets/nearby_clinks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userModel =
        BlocProvider.of<GetUserCubit>(context).state.props[0] as UserModel;
    BlocProvider.of<GetLocationsCubit>(context).getLocations();
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("مرحبا ${userModel.userData.name}"),
                      Text("كيف حالك؟",
                          style: Theme.of(context).textTheme.bodySmall)
                    ]),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Ionicons.notifications_outline)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Ionicons.search_outline))
                ]),
            body: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(14),
                children: [
                  // const UpcomingCard(),
                  // const SizedBox(height: 20),
                  Text(
                    "الاحتياجات الصحية",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 15),
                  const HealthNeeds(),
                  const SizedBox(height: 25),
                  BlocBuilder<GetLocationsCubit, GetLocationsState>(
                      builder: (context, state) {
                    if (state is GetLocationsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetLocationsSuccess) {
                      return DropdownMenu<String>(
                          initialSelection:
                              state.locationModel.locations.first.name,
                          onSelected: (value) {
                            BlocProvider.of<GetClinksCubit>(context)
                                .getClinks(int.parse(value!));
                          },
                          dropdownMenuEntries: state.locationModel.locations
                              .map((Location location) {
                            return DropdownMenuEntry<String>(
                                value: '${location.id}', label: location.name);
                          }).toList());
                    }
                    return Container();
                  }),
                  Text("العيادات القريبة",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 15),
                  const NearClinksDoctors()
                ])));
  }
}
