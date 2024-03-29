import 'package:church_app/controllers/products.controller.dart';
import 'package:church_app/providers/categories.provider.dart';
import 'package:church_app/providers/products.provider.dart';
import 'package:church_app/widgets/categories_slider.widget.dart';
import 'package:church_app/widgets/search_posts.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/list_products_vertical.widget.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductProvider _productProvider = ProductProvider();
  final CategoryProvider _categoryProvider = CategoryProvider();
  final ProductControllerX _productControllerX = Get.find<ProductControllerX>();

  Future getProducts() async {
    _productControllerX.page = 1;
    _productControllerX.endListProducts = false;

    await _productProvider.getHighlightProducts();
    await _productProvider.getProducts();
    // await _categoryProvider.getCategories();
    // setState(() {});
  }

  final _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() async {
      var nextPageTrigger = 0.8 * _controller.position.maxScrollExtent;

      if (_controller.position.pixels > nextPageTrigger) {
        if (_productControllerX.endListProducts ||
            _productControllerX.loadingMoreProducts.value ||
            _productControllerX.loadingListProducts.value) {
          return;
        } else {
          _productControllerX.page++;
          await _productProvider.getMoreProducts();
          //setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => getProducts(),
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: const <Widget>[
              SearchPosts(),
              CategoriesSlider(),
              // ListProductsHorizontal(),
              // ListProductsVertical(),
            ],
          ),
        ),
      ),
    );
  }
}
