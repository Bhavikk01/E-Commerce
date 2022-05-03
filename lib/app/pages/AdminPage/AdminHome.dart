import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../../models/products.dart';
import '../../../utils/snakbars.dart';
import '../../../widgets/projectListTile.dart';
import '../../providers.dart';
import '../AdminAppProducts.dart';

class AdminHomePage extends ConsumerWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
        actions: [
          IconButton(
              onPressed: () => ref.read(firebaseAuthProvider).signOut(),
              icon: const Icon(Icons.logout)
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AdminAddProduct())),
      ),

      body: StreamBuilder<List<Product>>(
          stream: ref.read(databaseProvider)!.getProduct(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active && snapshot.data!=null){
              if(snapshot.data!.isEmpty){
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("No products yet..."),
                      Lottie.asset("assets/anim/empty-box.json",width: 200,repeat: false),
                    ],
                  );
              }
              else {
                return ListView.builder(

                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final products = snapshot.data![index];
                      return ProductListTile(
                          product: products,
                          onDelete: () async {
                            openIconSnackBar(
                              context,
                              "Deleting item...",
                              const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            );
                            await ref.read(databaseProvider)!.deleteProducts(products.id!);
                            }
                          );
                    }
                );
              }
            }
            return Center(
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No products yet...",
                    style: TextStyle(fontSize: 18)),
                    Lottie.asset("lib/widgets/anim/empty-box.json",width: 300,height:300,repeat: false),
                  ],
                )
            );
          }
      ),
    );
  }
}