import 'package:Shop_App/screens/edit_product_screen.dart';
import 'package:Shop_App/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/UserProductScreen';

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProduct(true);
  }

  @override
  Widget build(BuildContext context) {
    //final productData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
              future: _refreshProduct(context),
              builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting 
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
          onRefresh: () => _refreshProduct(context),
          child: Consumer<ProductsProvider>(
                builder:(ctx,productData,_) => Padding(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: productData.items.length,
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      UserProductItem(
                          productData.items[index].id,
                          productData.items[index].title,
                          productData.items[index].imageUrl),
                      Divider(),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
