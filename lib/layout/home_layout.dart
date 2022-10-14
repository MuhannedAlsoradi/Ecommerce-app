// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/modules/search_screen.dart';
import 'package:salla_app/shared/cubit/app_cubit/cubit.dart';
import 'package:salla_app/shared/cubit/app_cubit/states.dart';
import 'package:salla_app/shared/cubit/theme_cubit/cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 18.0,
                backgroundColor: Colors.grey[400],
                backgroundImage: NetworkImage(
                  'https://scontent.fgza2-1.fna.fbcdn.net/v/t39.30808-6/278097263_1915463335472774_1520428944919852700_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=LWfUSVkMWqcAX_Qeh8Z&_nc_ht=scontent.fgza2-1.fna&oh=00_AT-3-xG5OBCFklfrtGR8ViWeQ5XUW7TDvIRFKmQHOSeffQ&oe=633540B8',
                ),
              ),
            ),
            title: Text(
              AppCubit.get(context).titles[AppCubit.get(context).screenIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  ThemeCubit.get(context).changeAppTheme();
                },
                icon: Icon(Icons.light_mode),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppCubit.get(context).screenIndex,
            onTap: (index) {
              AppCubit.get(context).changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
          body: AppCubit.get(context)
              .bottomScreens[AppCubit.get(context).screenIndex],
        );
      },
    );
  }
}
