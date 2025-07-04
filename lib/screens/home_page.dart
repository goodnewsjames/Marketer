import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marketer/controllers/network_controller.dart';
import 'package:marketer/models/product.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:marketer/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NetworkController dataSource = NetworkController();
  ScrollController scrollController = ScrollController();
  late Future<List<Product>> productList;

  @override
  void initState() {
    productList = dataSource.fetchData();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.green,
          flexibleSpace: Container(
            height: 50,
            padding: EdgeInsets.only(left: 10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.arrow_back),
                hintText: "I am looking for...",
              ),
              cursorColor: Colors.black,
              cursorWidth: 1,
              cursorHeight: 15,
            ),
          ),
        ),
        body: FutureBuilder(
          future: productList,
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
              return MasonryGridView.count(
                controller:
                    scrollController, // Use the scrollController
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data?.length,
                shrinkWrap: true,
                mainAxisSpacing: 16,
                crossAxisSpacing: 14,
                crossAxisCount:
                    (MediaQuery.of(context).size.width / 180)
                        .floor()
                        .clamp(2, 6),
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];
                  double height = index % 2 == 0 ? 300 : 400;
                  String price = NumberFormat.currency(
                    locale: 'en_NG',
                    symbol: '₦ ',
                    decimalDigits:
                        (product.price * 1600) % 1 == 0
                            ? 0
                            : 2,
                  ).format(product.price * 1600);
                  return ProductCard(
                    height: height,
                    product: product,
                    price: price,
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
