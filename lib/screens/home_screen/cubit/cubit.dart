// ignore_for_file: avoid_print, unused_element, depend_on_referenced_packages, unnecessary_import

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:sqflite/sqflite.dart';
import 'package:storage/model/item_model.dart';

import 'package:storage/screens/home_screen/cubit/states.dart';

class MicroCubit extends Cubit<MicroStates> {
  MicroCubit() : super(MicroInitialState());

  static MicroCubit get(context) => BlocProvider.of(context);
  bool isChecked = false;

  void isCheckedSaleAndBuying() {
    isChecked = !isChecked;

    emit(IsCheckedSaleAndBuyingState());
  }

  late Database dataBase;

  void createDatabase() {
    openDatabase(
      'add.db',
      version: 1,
      onCreate: (dataBase, version) {
        print('Data base create');
        dataBase
            .execute(
                'CREATE TABLE items(itemNumber INTEGER PRIMARY KEY,itemName TEXT,itemPrice INTEGER,itemCost INTEGER , itemFill INTEGER,itemCount INTEGER)')
            .then((value) {
          print('create table');
        }).catchError((error) {
          print('Error when Criating table${error.toString()}');
        });
      },
      onOpen: (dataBase) {
        getDataFromDatabase(dataBase);
        print('Data base open');
      },
    ).then((value) {
      dataBase = value;
      emit(CreateDatabaseState());
    });
  }

  void insertToDatabase({
    required String itemName,
    int? itemPrice,
    int? itemCost,
    int? itemFill,
    int? itemCount,
  }) async {
    itemPrice ??= 0;
    itemCost ??= 0;
    itemFill ??= 0;
    itemCount ??= 0;

    await dataBase.transaction((txn) => txn
            .rawInsert(
                'INSERT INTO items(itemName,itemPrice,itemCost,itemFill,itemCount) VALUES("$itemName","$itemPrice","$itemCost","$itemFill","$itemCount")')
            .then((value) {
          print('$value inserted successfuly');
          getDataFromDatabase(dataBase);
          emit(InsertDatabaseState());
        }).catchError((error) {
          print('Error when Inserting New Record${error.toString()}');
        }));
  }

  List<Map> items = [];
  List<ItemModel> i = [];
  List<Map<String, dynamic>> temps = [];
  void getDataFromDatabase(dataBase) {
    items = [];
    i = [];
    temps = [];
    emit(GetDatabaseLodingState());
    dataBase.rawQuery('SELECT * FROM  items').then((value) {
      value.forEach((element) {
        items.add(element);

        i.add(ItemModel.fromJson(element));

        // print('object: ${i.length}');
      });
      // print(items);
      // print(items.length);
      emit(GetDatabaseState());
    });
  }

  String randomNumber = '100000000000';
  void generateRandomNumber(int length) {
    Random random = Random();
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < length; i++) {
      buffer.write(random.nextInt(10));
    }
    for (var map in i) {
      if (map.itemNumber != buffer) {
        randomNumber = buffer.toString();
      } else {
        generateRandomNumber(12);
      }
    }
  }

  Future delete(int id) async {
    await dataBase.delete('items',
        where: 'itemNumber = ?', whereArgs: [id]).then((value) {
          
      getDataFromDatabase(dataBase);
      emit(DeleteDatabaseState());
    }).catchError((onError) {
      print(onError);
    });
  }
  // static Future<int> deleteAll() async {
  //   print('delete All');
  //   return await _db!
  //       .delete(_tableName);
  // }
}
