import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/news_layout/cubit/App_cubit.dart';
//import 'package:flutter_application_1/layout/news_layout/cubit/App_cubit.dart';
import 'package:flutter_application_1/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:flutter_application_1/layout/shop_layout/cubit/shop_states.dart';
import 'package:flutter_application_1/modules/shop_app/search/search.dart';
import 'package:flutter_application_1/shared/component/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Gallery',
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  navigateTo(context, ShopSearchScreen(),);
                },
              ),
              IconButton(
              icon: 
              Icon(Icons.brightness_2_rounded), 
                onPressed: ()
                {
                 // NewsCubit.get(context).darkMode();
                  AppCubit.get(context).changeAppMode();

                }
                )
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
