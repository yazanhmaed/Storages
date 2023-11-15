import 'package:flutter/material.dart';
import 'package:storage/resources/widgets/custom_text_field.dart';

import '../../../resources/color_manager.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({
    super.key,
    required this.scrollController,
    required this.data, this.delete,
  });
  final ScrollController scrollController;
  final Map<String, dynamic> data;
 final Function()? delete;

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> with TickerProviderStateMixin {
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

    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Material(
      color: Colors.amber,
      child: Stack(
        children: <Widget>[
          // Column(
          //   children: <Widget>[
          //     AspectRatio(
          //       aspectRatio: 1.2,
          //       child: GestureDetector(
          //         onTap: () async {
          //           await showDialog(
          //               context: context,
          //               builder: (_) => Dialog(
          //                     child: Stack(
          //                       alignment: Alignment.topRight,
          //                       children: [
          //                         IconButton(
          //                             onPressed: () {
          //                               Navigator.pop(context);
          //                             },
          //                             icon: const Text(
          //                               'X',
          //                               style: TextStyle(
          //                                   color: Colors.red,
          //                                   fontSize: 30,
          //                                   fontWeight: FontWeight.bold),
          //                             )),
          //                       ],
          //                     ),
          //                   ));
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('أسم المنتج'),
                    Text('${widget.data['itemName']}'),
                  ],
                ),
                Column(
                  children: [
                    const Text('الكمية'),
                    Text('${widget.data['itemCount']}'),
                  ],
                ),
                Column(
                  children: [
                    const Text('سعر البيع'),
                    Text('${widget.data['itemPrice']}'),
                  ],
                ),
                Column(
                  children: [
                    const Text('التكلفة'),
                    Text('${widget.data['itemCost']}'),
                  ],
                ),
                Column(
                  children: [
                    const Text('التعبئة'),
                    Text('${widget.data['itemFill']}'),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.width / 1.8),
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
                      blurRadius: 10.0),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: infoHeight,
                        maxHeight:
                            tempHeight > infoHeight ? tempHeight : infoHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              const Text(
                                'اضافة كمية للمخزون',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  letterSpacing: 0.27,
                                  color: Colors.green,
                                ),
                              ),
                              Expanded(
                                child: CustomTextField(
                                  height: '',
                                  hintText: '0',
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
                                onPressed: () {},
                                child: const Icon(Icons.add),
                              )
                            ],
                          ),
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: opacity1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'حذف المنتج ',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: Colors.green,
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: widget.delete,
                                  child: const Icon(Icons.delete),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(color: ColorManager.primary, thickness: 2),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: opacity1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'تعديل بيانات المنتج ',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: Colors.green,
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () {},
                                  child: const Icon(Icons.edit_document),
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
          //icon button close
          Positioned(
            top: (MediaQuery.of(context).size.width / 2.1),
            right: 35,
            child: ScaleTransition(
              scale: CurvedAnimation(
                  parent: animationController, curve: Curves.fastOutSlowIn),
              child: Card(
                color: ColorManager.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
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
                        color: Colors.brown,
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
  }
}
