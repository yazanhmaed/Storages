import 'package:bloc/bloc.dart';
import 'package:cubit_form/cubit_form.dart';

import 'package:storage/screens/home_screen/cubit/states.dart';

class MicroCubit extends Cubit<MicroStates> {
  MicroCubit() : super(MicroInitialState());

  static MicroCubit get(context) => BlocProvider.of(context);
  bool isChecked = false;

  void isCheckedSaleAndBuying() {
    isChecked = !isChecked;

    emit(IsCheckedSaleAndBuyingState());
  }
}
