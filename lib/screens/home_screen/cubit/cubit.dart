// ignore_for_file: avoid_print, unused_element, depend_on_referenced_packages, unnecessary_import, unrelated_type_equality_checks

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:storage/model/client_model.dart';
import 'package:storage/model/invocie_model.dart';
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
    print('object');
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
          'CREATE TABLE clients(clientId INTEGER PRIMARY KEY ,clientName TEXT,clientNOTE TEXT,clientPhone INTEGER,onHim REAL, forHim REAL)',
        )
            .then((_) {
          print('Clients table created');
        }).catchError((error) {
          print('Error creating Clients table: ${error.toString()}');
        });

        await database.execute(
            '''
          CREATE TABLE invoices(
            id INTEGER ,
            itemNumber INTEGER  ,itemName TEXT,itemPrice INTEGER,itemCost INTEGER , itemFill INTEGER,itemCount INTEGER,
           date TEXT,
            clientsId INTEGER,
            FOREIGN KEY (clientsId) REFERENCES clients(clientId)
          )
        ''').then((_) {
          print('invoices table created');
        }).catchError((error) {
          print('Error creating Clients table: ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database, dataClients: true, dataItems: true);
        // getDataFromClientDatabase(dataBase);
        // invocieList(database);
        print('Database opened');
      },
    ).then((value) {
      dataBase = value;
      emit(CreateDatabaseState());
    });
  }

  void insertCustomer({required InVocieModel inVocieModel}) async {
    dataBase.transaction((txn) => txn
            .rawInsert(
                'INSERT INTO invoices(id,itemNumber,itemName,itemPrice,itemCost,itemFill,itemCount,date,clientsId) VALUES("${inVocieModel.id}","${inVocieModel.itemNumber}","${inVocieModel.itemName}","${inVocieModel.itemPrice}","${inVocieModel.itemCost}","${inVocieModel.itemFill}","${inVocieModel.itemCount}","${DateFormat.yMd().format(DateTime.now())}","${inVocieModel.customerId}")')
            .then((value) {
          print('$value inserted successfuly');
          // getDataFromDatabase(dataBase, dataClients: false, dataItems: true);
          emit(InsertDatabaseState());
        }).catchError((error) {
          print('Error when Inserting New Record${error.toString()}');
        }));
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

    dataBase.transaction((txn) => txn
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
  List<InVocieModel> inVocie = [];
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
          print('******************');
          print(element['itemCount']);
          print('object: ${i.length}');
          print('******************');
        });

        // print(items);
        // print(items.length);
        emit(GetDatabaseState());
      });
    }
    if (dataClients == true) {
      c = [];
      cleints = [];
      dataBase.rawQuery('SELECT * FROM  clients').then((value) {
        value.forEach((element) {
          cl.add(element);
          c.add(ClientModel.fromJson(element));
          print('cccc');
          print(element['itemCount']);
        });
        // print(c[0].clientId);
        emit(GetDatabaseState());
      });
    }
    if (dataClients == true) {
      inVocie = [];

      dataBase
          .rawQuery('SELECT * FROM  invoices WHERE clientsId=1 & id=1')
          .then((value) {
        value.forEach((element) {
          inVocie.add(InVocieModel.fromJson(element));
        });
        print(inVocie);
        emit(GetDatabaseState());
      });
    }
  }

  List<InVocieModel> invoiceClientList = [];

  void invoiceClient({required int clientsId}) {
    invoiceClientList = [];
    dataBase
        .rawQuery('SELECT * FROM  invoices WHERE clientsId=$clientsId ')
        .then((value) {
      for (var element in value) {
        // print(invoiceClientList.any((ele) => ele == element));
        // print(element['id']);
        if (invoiceClientList.any((ele) => ele.id == element['id'])) {
          print('object');
        } else {
          invoiceClientList.add(InVocieModel.fromJson(element));
        }
      }
      // print(invoiceClientList);
      emit(GetinvoiceClientListState());
    });
  }

  List<InVocieModel> invocieItemList = [];
  void invoiceItem({required int clientsId, required int invoiceId}) {
    invocieItemList = [];
    dataBase
        .rawQuery(
            'SELECT * FROM  invoices WHERE id=$invoiceId and clientsId=$clientsId ')
        .then((value) {
      for (var element in value) {
        // print(invoiceClientList.any((ele) => ele == element));
        // print(element['id']);

        invocieItemList.add(InVocieModel.fromJson(element));
      }
      // print(invoiceClientList);
      emit(GetinvoiceItemListState());
    });
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

  Future updateClient({required ClientModel clients}) async {
    await dataBase.update(
      'clients',
      clients.toMap(),
      where: 'clientId = ?',
      whereArgs: [clients.clientId],
    ).then((value) {
      getDataFromDatabase(dataBase, dataClients: true, dataItems: false);
      emit(UpdataDatabaseState());
    }).catchError((onError) {
      print(onError);
      emit(UpdataDatabaseErrorState());
    });
  }

  Future updateClient2({required ClientModel clients}) async {
    await dataBase.rawUpdate(
        'UPDATE clients SET onHim = ?, forHim = ? WHERE clientId = ?',
        [1223, 9876.0, '${clients.clientId}']).then((value) {
      getDataFromDatabase(dataBase, dataClients: true, dataItems: false);
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
    double? onHim,
    double? forHim,
  }) async {
    clientNOTE ??= "";
    onHim ??= 0.0;
    forHim ??= 0.0;

    await dataBase.transaction((txn) => txn
            .rawInsert(
                'INSERT INTO clients(clientName,clientPhone,clientNOTE, onHim, forHim) VALUES("$clientName","$clientPhone","$clientNOTE", 0.0, 0.0)')
            .then((value) {
          print('$value inserted successfuly');
          getDataFromDatabase(dataBase, dataClients: true, dataItems: false);
          emit(InsertDatabaseState());
        }).catchError((error) {
          print('Error when Inserting New Record${error.toString()}');
        }));
  }

  void changeCount({required List<SaleModel> list, required int index}) {
    if (list[index].itemCount! > 0) {
      list[index].itemCountb = list[index].itemCountb! + 1;
      list[index].itemCount = list[index].itemCount! - 1;
      print(list[index].itemCount);
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

  bool isForHim = true;
  void getHim({required bool isFor}) {
    isForHim = isFor;
    print(isForHim);
    emit(GetHim());
  }

  int? cliId;
  void clientId({required int id}) {
    cliId = id;
    print('id: $cliId');
    emit(GetSearch());
  }

  List<ClientModel> clientList = [];
  void searchClient(String text) {
    clientList = c
        .where((e) => e.clientName!.toLowerCase().contains(text.toLowerCase()))
        .toList();
    print('clientList.first.clientId!');
    print(clientList.first.clientId!);
    print('clientList.first.clientId!');
    emit(GetSearch());
  }
  TextEditingController nameClientText = TextEditingController();

  void nameClient(int index) {
    nameClientText.text = clientList[index].clientName!;
   clientId(id: clientList[index].clientId!);
    clientList = [];
    emit(GetNameClient());
  }

  bool clientSearch = false;
  void changeSearch() {
    clientSearch = !clientSearch;
    emit(GetChangeSearch());
  }
}
