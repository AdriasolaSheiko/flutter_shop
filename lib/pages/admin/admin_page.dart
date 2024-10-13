import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/admin/children/categories/categories_page.dart';
import 'package:flutter_shop/pages/admin/children/products/products_page.dart';
import 'package:flutter_shop/pages/home/home_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Administrador'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Categorías',
              ),
              Tab(
                text: 'Productos',
              ),
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const HomePage(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.home),
              ),
            )
          ],
        ),
        body: const TabBarView(
          children: [
            CategoriesPage(),
            ProductsPage(),
          ],
        ),
      ),
    );
  }
}
