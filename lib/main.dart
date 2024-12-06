import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test/cubit/bloc_observer.dart';
import 'package:test/layout/todo_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
return  const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: TodoScreen(),
);


  }

  // This widget is the root of your application.

}
