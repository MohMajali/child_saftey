import 'package:device_preview/device_preview.dart';
import 'package:ecommerce/Data/Repo/clinks_repo.dart';
import 'package:ecommerce/Data/Repo/user_repo.dart';
import 'package:ecommerce/Data/Services/Auth.dart';
import 'package:ecommerce/Data/Services/clinks.dart';
import 'package:ecommerce/Logic/GetClientAppointements/cubit/get_client_appointements_cubit.dart';
import 'package:ecommerce/Logic/GetClinks/cubit/get_clinks_cubit.dart';
import 'package:ecommerce/Logic/GetLocations/cubit/get_locations_cubit.dart';
import 'package:ecommerce/Logic/GetServiceDetails/cubit/get_service_details_cubit.dart';
import 'package:ecommerce/Logic/GetServices/cubit/get_services_cubit.dart';
import 'package:ecommerce/Logic/GetUser/cubit/get_user_cubit.dart';
import 'package:ecommerce/Logic/Login/bloc/login_bloc.dart';
import 'package:ecommerce/Logic/MakeAppointement/bloc/make_appointement_bloc.dart';
import 'package:ecommerce/Logic/SignUp/bloc/sign_up_bloc.dart';
import 'package:ecommerce/Logic/UpdateAccount/bloc/update_account_bloc.dart';
import 'package:ecommerce/pages/Login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  LoginBloc(LoginInitial(), UserRepo(UserServices()))),
          BlocProvider(
              create: (context) => GetUserCubit(UserRepo(UserServices()))),
          BlocProvider(
              create: (context) =>
                  SignUpBloc(SignUpInitial(), UserRepo(UserServices()))),
          BlocProvider(
              create: (context) =>
                  GetClinksCubit(ClinksRepo(ClinksServices()))),
          BlocProvider(
              create: (context) =>
                  GetLocationsCubit(ClinksRepo(ClinksServices()))),
          BlocProvider(
              create: (context) =>
                  GetServicesCubit(ClinksRepo(ClinksServices()))),
          BlocProvider(
              create: (context) =>
                  GetServiceDetailsCubit(ClinksRepo(ClinksServices()))),
          BlocProvider(
              create: (context) => MakeAppointementBloc(
                  MakeAppointementInitial(), ClinksRepo(ClinksServices()))),
          BlocProvider(
              create: (context) => UpdateAccountBloc(
                  UpdateAccountInitial(), UserRepo(UserServices()))),
          BlocProvider(
              create: (context) =>
                  GetClientAppointementsCubit(ClinksRepo(ClinksServices())))
        ],
        child: MaterialApp(
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.locale(context),
          title: 'health app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorSchemeSeed: const Color(0xff5a73d8),
            textTheme: GoogleFonts.plusJakartaSansTextTheme(
              Theme.of(context).textTheme,
            ),
            useMaterial3: true,
          ),
          home: const Directionality(
              textDirection: TextDirection.rtl, child: LoginScreen()),
        ));
  }
}
