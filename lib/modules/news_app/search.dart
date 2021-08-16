import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/component/components.dart';
import 'package:flutter_application_1/shared/cubit/cubit.dart';
import 'package:flutter_application_1/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:news_app/states.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {

var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state){},
      builder: (context , state) 
      {
        var list = NewsCubit.get(context).search;
        return Scaffold(
        appBar: AppBar(

        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultFormField(
                controller: searchController, 
                type: TextInputType.text, 
                validate: (String value)
                {
                  if(value.isEmpty)
                  {
                    return 'Search must not be empty';
                  }
                  return null;

                }, 
                label: 'Search', 
                onChange: (value)
                {
                  NewsCubit.get(context).getSearch(value);
                },
                prefix: Icons.search 
                ),
            ),
            Expanded(child: articleBuilder(list, context ,isSearch: true))
          ],
        ),
      );
      },
    );
  }
}