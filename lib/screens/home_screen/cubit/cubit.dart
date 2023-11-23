// ignore_for_file: avoid_print, unused_element, depend_on_referenced_packages, unnecessary_import

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:sqflite/sqflite.dart';
import 'package:storage/model/client_model.dart';
import 'package:storage/model/item_model.dart';
import 'package:storage/model/sale_model.dart';

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
      version: 2,
      onCreate: (database, version) async {
        print('Database created');
        await database
            .execute(
          'CREATE TABLE items(itemNumber INTEGER  ,itemName TEXT,itemPrice INTEGER,itemCost INTEGER , itemFill INTEGER,itemCount INTEGER)',
        )
            .then((_) {
          print('Items table created');
        }).catchError((error) {
          print('Error creating Items table: ${error.toString()}');
        });

        await database
            .execute(
          'CREATE TABLE clients(clientId INTEGER PRIMARY KEY ,clientName TEXT,clientNOTE TEXT,clientPhone INTEGER)',
        )
            .then((_) {
          print('Clients table created');
        }).catchError((error) {
          print('Error creating Clients table: ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database, dataClients: true, dataItems: true);
        // getDataFromClientDatabase(dataBase);
        print('Database opened');
      },
    ).then((value) {
      dataBase = value;
      emit(CreateDatabaseState());
    });
  }

  void insertToDatabase({
    required int itemNumber,
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
                'INSERT INTO items(itemNumber,itemName,itemPrice,itemCost,itemFill,itemCount) VALUES("$itemNumber","$itemName","$itemPrice","$itemCost","$itemFill","$itemCount")')
            .then((value) {
          print('$value inserted successfuly');
          getDataFromDatabase(dataBase, dataClients: false, dataItems: true);
          emit(InsertDatabaseState());
        }).catchError((error) {
          print('Error when Inserting New Record${error.toString()}');
        }));
  }

  List<Map> items = [];
  List<ItemModel> i = [];
  List<Map<String, dynamic>> temps = [];
  List<Map> cl = [];
  List<ClientModel> c = [];
  List<Map<String, dynamic>> cleints = [];
  void getDataFromDatabase(dataBase,
      {required bool dataItems, required bool dataClients}) {
    emit(GetDatabaseLodingState());
    if (dataItems == true) {
      items = [];
      i = [];
      temps = [];
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
    if (dataClients == true) {
      cl = [];
      c = [];
      cleints = [];
      dataBase.rawQuery('SELECT * FROM  clients').then((value) {
        value.forEach((element) {
          cl.add(element);
          c.add(ClientModel.fromJson(element));
        });

        emit(GetDatabaseState());
      });
    }
  }

  String randomNumber = '0000000';
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
      getDataFromDatabase(dataBase, dataClients: false, dataItems: true);
      emit(DeleteDatabaseState());
    }).catchError((onError) {
      print(onError);
    });
  }

  void plusCount({
    required int count,
    required int number,
  }) async {
    await dataBase
        .update('items', {'itemCount': count},
            where: 'itemNumber = ?', whereArgs: ['$number'])
        .then((value) {
      getDataFromDatabase(dataBase, dataClients: false, dataItems: true);
      emit(UpdataDatabaseState());
    }).catchError((onError) {
      print(onError);
      emit(UpdataDatabaseErrorState());
    });
  }

  Future update({required ItemModel item}) async {
    await dataBase.update('items', item.toMap(),
        where: 'itemNumber = ?', whereArgs: [item.itemNumber]).then((value) {
      getDataFromDatabase(dataBase, dataClients: false, dataItems: true);
      emit(UpdataDatabaseState());
    }).catchError((onError) {
      print(onError);
      emit(UpdataDatabaseErrorState());
    });
  }
  // static Future<int> deleteAll() async {
  //   print('delete All');
  //   return await _db!
  //       .delete(_tableName);
  // }

//      ###################  Client   ######################/
  void insertClientDatabase({
    required String clientName,
    required String clientPhone,
    String? clientNOTE,
  }) async {
    clientNOTE ??= "";

    await dataBase.transaction((txn) => txn
            .rawInsert(
                'INSERT INTO clients(clientName,clientPhone,clientNOTE) VALUES("$clientName","$clientPhone","$clientNOTE")')
            .then((value) {
          print('$value inserted successfuly');
          getDataFromDatabase(dataBase, dataClients: true, dataItems: false);
          emit(InsertDatabaseState());
        }).catchError((error) {
          print('Error when Inserting New Record${error.toString()}');
        }));
  }

  void changeCount({required List<SaleModel> list, required int index}) {
    if (list[index].itemCount! > list[index].itemCountb!) {
      list[index].itemCountb = list[index].itemCountb! + 1;
    }

    emit(ChangeCountState());
  }

  void removeItem({required List<SaleModel> list, required int index}) {
    list.removeWhere((element) => element.itemNumber == index);

    emit(RemoveState());
  }

  int changeCountSheet({required int index}) {
    emit(ChangeCountState());
    return index;

    //  totalCost;
  }

  int itemDiscountSheet({required int index}) {
    emit(ItemDiscountState());
    return index;

    //  totalCost;
  }

  int totalCount = 0;
  int calculateTotalCount({required List<SaleModel> list}) {
    totalCount = 0;
    for (var index = 0; index < list.length; index++) {
      totalCount += list[index].itemCountb!;
    }

    emit(CalculateTotalCountState());
    return totalCount;
  }

  double totalCost = 0;
  double calculateTotalCost({required List<SaleModel> salesItems1}) {
    totalCost = 0;
    for (var index = 0; index < salesItems1.length; index++) {
      totalCost += (salesItems1[index].itemCountb! *
          salesItems1[index].itemFill! *
          salesItems1[index].itemPrice!);
    }
    emit(CalculateTotalCostState());
    return totalCost;
  }
}
