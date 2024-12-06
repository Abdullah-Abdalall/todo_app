import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:test/cubit/states.dart';
import 'package:test/moudle/archived_tasks_screen.dart';
import 'package:test/moudle/done_tasks_screen.dart';
import 'package:test/moudle/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit(BuildContext context) : super(AppInitialState());

  int currentIndex = 0;
  IconData fabIcon = Icons.edit;
  bool isBottomSheetShown = false;

  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];

  // Bottom Sheet state :
  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];

  List<String> titleChange = [
    'Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(BottomNavBarChangeState());
  }

  List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.task),
      label: 'Tasks',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.done),
      label: 'Done',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.archive),
      label: 'Archived',
    ),
  ];

  void insertToDataBase({
    required String title,
    required String date,
    required String time,
  }) {
    newtasks.add({
      'id': newtasks.length + 1,
      'title': title,
      'date': date,
      'time': time,
      'status': 'new',
    });
    emit(AppInsertDataBaseState());
    getDataFromDataBase();
  }

  void getDataFromDataBase() {
    emit(AppGetDataBaseLoadingState());
    donetasks = [];
    archivedtasks = [];

    newtasks.forEach((element) {
      if (element['status'] == 'done') {
        donetasks.add(element);
      } else if (element['status'] == 'archived') {
        archivedtasks.add(element);
      }
    });
    emit(AppGetDataFromDataBaseState());
  }

  void updateData({
    required String status,
    required int id,
  }) {
    var task = newtasks.firstWhere((element) => element['id'] == id);
    task['status'] = status;
    getDataFromDataBase();
    emit(AppUpdateDataBaseState());
  }

  void deleteData({
    required int id,
  }) {
    newtasks.removeWhere((element) => element['id'] == id);
    getDataFromDataBase();
    emit(AppDeleteDataBaseState());
  }

  void changeBottomSheetState({
    required IconData icon,
    required bool isShown,
  }) {
    isBottomSheetShown = isShown;
    fabIcon = icon;
    emit(BottomSheetChangeState());
  }
}
