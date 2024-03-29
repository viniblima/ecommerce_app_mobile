import 'package:church_app/models/product.model.dart';
import 'package:church_app/widgets/like_button.widget.dart';
import 'package:church_app/widgets/rate_badge.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/config.controller.dart';

class ProductCardHorizontal extends StatelessWidget {
  final Product product;
  final Function onPressLike;
  const ProductCardHorizontal({
    required this.product,
    required this.onPressLike,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double price = product.discount != null
        ? product.discount!.priceWithDiscount
        : product.price;

    return Container(
      margin: const EdgeInsets.only(left: 16),
      height: 140,
      width: 150,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(
                color: Config.colors[ColorVariables.borderGray]!,
              ),
            ),
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (states) => Config.colors[ColorVariables.secondary]!,
          ),
        ),
        onPressed: () {
          Get.toNamed(
              '/detail_product/?product_id=${product.id}&origin=horizontal');
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        16.0,
                      ),
                      child: Hero(
                        tag: 'tag_${product.id}_horizontal',
                        child: FadeInImage(
                          height: 140,
                          width: 140,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (BuildContext context,
                              Object exception, StackTrace? stackTrace) {
                            return Image.asset('assets/images/placeholder.jpg');
                          },
                          image: const NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/1280px-A_small_cup_of_coffee.JPG',
                          ),
                          placeholder: const AssetImage(
                            'assets/images/placeholder.jpg',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: RateBadge(
                      rate: product.rate ?? 0.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 135,
              margin: const EdgeInsets.only(top: 4.0, left: 4.0),
              child: Text(
                product.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Config.colors[ColorVariables.black],
                ),
              ),
            ),
            SizedBox(
              width: 135,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 4, left: 4.0),
                        child: Text(
                          NumberFormat.simpleCurrency(
                            locale: Get.locale.toString(),
                          ).format(price),
                          style: TextStyle(
                            fontSize: 16,
                            color: Config.colors[ColorVariables.black]!,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4, left: 4.0),
                        child: Text(
                          '${product.maxQuantityInstallments}x de ${NumberFormat.simpleCurrency(
                            locale: Get.locale.toString(),
                          ).format(price / product.maxQuantityInstallments)}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Config.colors[ColorVariables.secondary]!,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.centerRight,
                    child: LikeButton(
                      onPressLike: onPressLike,
                      liked: product.liked,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
