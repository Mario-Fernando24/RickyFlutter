import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmorty/presentation/blocs/character/character_bloc.dart';
import 'package:rickmorty/presentation/blocs/episode/episode_bloc.dart';
import 'package:rickmorty/presentation/blocs/location/location_bloc.dart';
import 'package:rickmorty/presentation/pages/home_page.dart';
import 'constants/constants.dart';
import 'presentation/routes/routes.dart';

void main() async {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CharacterBloc>(create: (context) => CharacterBloc()),
      BlocProvider<LocationBloc>(create: (context) => LocationBloc()),
      BlocProvider<EpisodeBloc>(create: (context) => EpisodeBloc()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RickyMorty',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
      initialRoute: AppConstants.homePage,
      routes: appRoutes,
    );
  }
}
