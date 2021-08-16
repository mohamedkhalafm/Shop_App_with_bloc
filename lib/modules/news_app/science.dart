import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/component/components.dart';
import 'package:flutter_application_1/shared/cubit/cubit.dart';
import 'package:flutter_application_1/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScienceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state) {},
      builder: (context , state) 
      {
        var list = NewsCubit.get(context).science;
        return ConditionalBuilder(
        condition: list.length > 0 ,
        builder: (context) =>ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context , index) =>buildArticleItem(list[index], context)
          , separatorBuilder: (context , index) => myDivider()
          , itemCount: 20),
        fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
      
    );
  }
}