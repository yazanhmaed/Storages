// ignore_for_file: prefer_const_constructors

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/model/sale_model.dart';
import 'package:storage/resources/color_manager.dart';
import 'package:storage/resources/styles.dart';
import 'package:storage/resources/widgets/custom_text_field.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';
import 'package:storage/screens/home_screen/cubit/states.dart';

class InfoSaleScreen extends StatefulWidget {
  const InfoSaleScreen({
    Key? key,
    required this.scrollController,
    required this.data,
    this.delete,
    required this.cubit,
    required this.list,
  }) : super(key: key);

  final ScrollController scrollController;
  final SaleModel data;
  final Function()? delete;
  final MicroCubit cubit;
  final List<SaleModel> list;

  @override
  State<InfoSaleScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoSaleScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      setState(() {
        opacity1 = 1.0;
      });
    }
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      setState(() {
        opacity2 = 1.0;
      });
    }
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      setState(() {
        opacity3 = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController itemCountr = TextEditingController();
    final TextEditingController itemDiscount = TextEditingController();

    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;

    return BlocConsumer<MicroCubit, MicroStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Material(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
                child: Column(
                  children: [
                    buildInfoColumn('أسم المنتج', '${widget.data.itemName}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildInfoColumn(
                            'سعر البيع', '${widget.data.itemPrice}'),
                        buildInfoColumn('التعبئة', '${widget.data.itemFill}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildInfoColumn('الكمية', '${widget.data.itemCount}'),
                        buildInfoColumn('التكلفة', '${widget.data.itemCost}'),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: (MediaQuery.of(context).size.width / 1.2),
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: ColorManager.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: infoHeight,
                            maxHeight: tempHeight > infoHeight
                                ? tempHeight
                                : infoHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  Text(' كمية المطلوبة',
                                      style: Styles.textStyle20),
                                  Expanded(
                                    child: CustomTextField(
                                      label: '',
                                      hintText: '${widget.data.itemCountb}',
                                      controller: itemCountr,
                                      keyboardType: TextInputType.number,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'النص مطلوب';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  FloatingActionButton(
                                    onPressed: () {
                                      widget.data.itemCountb = widget.cubit
                                          .changeCountSheet(
                                              index: int.tryParse(
                                                  itemCountr.text)!);
                                      widget.cubit.calculateTotalCount(
                                          list: widget.list);
                                      widget.cubit.calculateTotalCost(
                                          salesItems1: widget.list);
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: const Icon(Icons.add),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  Text(' أضافة خصم', style: Styles.textStyle20),
                                  Expanded(
                                    child: CustomTextField(
                                      label: '',
                                      hintText: '${widget.data.itemPrice}',
                                      controller: itemDiscount,
                                      keyboardType: TextInputType.number,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'النص مطلوب';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  FloatingActionButton(
                                    onPressed: () {
                                      widget.data.itemPrice = widget.cubit
                                          .itemDiscountSheet(
                                              index: int.tryParse(
                                                  itemDiscount.text)!);
                                      widget.cubit.calculateTotalCount(
                                          list: widget.list);
                                      widget.cubit.calculateTotalCost(
                                          salesItems1: widget.list);
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: const Icon(Icons.add),
                                  )
                                ],
                              ),
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('  حذف المنتج من القائمة ',
                                        textAlign: TextAlign.left,
                                        style: Styles.textStyle20),
                                    FloatingActionButton(
                                      onPressed: () {
                                        widget.cubit.removeItem(
                                            list: widget.list,
                                            index: widget.data.itemNumber!);
                                        widget.cubit.calculateTotalCount(
                                            list: widget.list);
                                        widget.cubit.calculateTotalCost(
                                            salesItems1: widget.list);
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                      child: const Icon(Icons.delete),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: (MediaQuery.of(context).size.width / 1.3),
                right: 35,
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animationController,
                    curve: Curves.fastOutSlowIn,
                  ),
                  child: Card(
                    color: ColorManager.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    elevation: 10.0,
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Center(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            minimumSize: const Size(60, 60),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildInfoColumn(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: Styles.textStyle18.copyWith(
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 2,
              color: Colors.grey,
            ),
            color: Colors.grey.shade200,
          ),
          child: Text(
            value,
            style: Styles.textStyle18.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
          ),
        ),
      ],
    );
  }
}
