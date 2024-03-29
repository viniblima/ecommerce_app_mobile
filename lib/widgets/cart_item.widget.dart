import 'package:church_app/controllers/config.controller.dart';
import 'package:church_app/widgets/button.widget.dart';
import 'package:church_app/widgets/button_quantity_cart.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/product.model.dart';

class CartItem extends StatelessWidget {
  final Map<String, dynamic> mapProduct;
  final Function onPressExclude;
  final int index;

  const CartItem({
    required this.mapProduct,
    required this.onPressExclude,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = mapProduct["product"];

    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FadeInImage(
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                imageErrorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset('assets/images/placeholder.jpg');
                },
                image: const NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/1280px-A_small_cup_of_coffee.JPG',
                ),
                placeholder: const AssetImage(
                  'assets/images/placeholder.jpg',
                ),
              ),
              Container(
                width: 16,
                color: Colors.orange,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              product.name,
                            ),
                            const Text('info de frete'),
                          ],
                        ),
                        ButtonQuantityCart(index: index)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          color: Colors.blue,
                          child: const Text('Tamanho: P'),
                        ),
                        Column(
                          children: [
                            product.discount != null
                                ? Row(
                                    children: <Widget>[
                                      Text(
                                        '${product.discount!.percentDiscount.round().toString()}%',
                                        style: TextStyle(
                                          color: Config
                                              .colors[ColorVariables.secondary],
                                          fontSize: 10,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        NumberFormat.simpleCurrency(
                                          locale: Get.locale.toString(),
                                        ).format(
                                          product.price,
                                        ),
                                        style: TextStyle(
                                          color: Config.colors[
                                              ColorVariables.highlightGray],
                                          decorationColor: Config
                                              .colors[ColorVariables.black],
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            Text(
                              NumberFormat.simpleCurrency(
                                locale: Get.locale.toString(),
                              ).format(product.price),
                              style: TextStyle(
                                color: Config.colors[ColorVariables.black],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 30,
                child: Button(
                  onPress: onPressExclude,
                  type: ButtonVariables.text,
                  format: ButtonFormat.square,
                  child: Text(
                    'delete'.tr,
                    style: TextStyle(
                      color: Config.colors[ColorVariables.primary],
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
