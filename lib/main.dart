import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'dart:math' as math show Random;

void main() {
  runApp(MaterialApp(
    title: 'Slethwares Bloc Mastery',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.red,
        secondary: Colors.redAccent
      )
    ),
    debugShowCheckedModeBanner: false,
    home: const HomePageView(),
  ));
}

const names = ["Bellion", "Christos", "Abadel", "Myricad", "Ganterion"];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt((length)));
}

class Cubiton extends Cubit<String?> {
  Cubiton() : super(null);

  void pickRandomName() {
    emit(names.getRandomElement());
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late final Cubiton cubit;

  @override
  void initState() {
    //implement initState
    super.initState();
    cubit = Cubiton();
  }

  @override
  void dispose() {
    //implement dispose
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: StreamBuilder<String?>(
        stream: cubit.stream,
        builder: (context,snapshot) {
          final randoButton = TextButton(
              onPressed: () {
                cubit.pickRandomName();
              },
              child: const Text("Pick a random name"),
          );
          switch (snapshot.connectionState) {

            case ConnectionState.none:
              return randoButton;
            case ConnectionState.waiting:
              return randoButton;
            case ConnectionState.active:
              return Column(
                children: [
                  Text(snapshot.data ?? " "),
                  randoButton
                ],
              );
            case ConnectionState.done:
              return const SizedBox();
          }
        },
      ),
    );
  }
}



