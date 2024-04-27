import 'package:ecommerce/Logic/GetClinks/cubit/get_clinks_cubit.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/pages/Clink-Services/clink_services.dart';
import 'package:ecommerce/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearClinksDoctors extends StatelessWidget {
  const NearClinksDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetClinksCubit>(context).getClinks(0);
    return BlocBuilder<GetClinksCubit, GetClinksState>(
        builder: (context, state) {
      if (state is GetClinksLoading) {
        return const Center(
            child: CircularProgressIndicator(color: Colors.blue));
      } else if (state is GetClinksSuccess) {
        return Column(
            children: List.generate(state.clinkModel.clinks.length, (i) {
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ClinkServices(
                            clinkName: state.clinkModel.clinks[i].name,
                            clinkId: state.clinkModel.clinks[i].id)));
              },
              child: ItemWidget(
                  image: '$URL/${state.clinkModel.clinks[i].image}',
                  title: state.clinkModel.clinks[i].name,
                  otherData: state.clinkModel.clinks[i].phone));
        }));
      }
      return Container();
    });
  }
}
