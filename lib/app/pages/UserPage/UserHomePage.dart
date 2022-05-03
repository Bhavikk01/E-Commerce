import 'package:e_commerce/widgets/ProductDetails.dart';
import 'package:e_commerce/widgets/productBanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/UserTopBar.dart';
import '../../providers.dart';

class UserHomePage extends ConsumerWidget{
  const UserHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserTopBar(
                  leadingIconButton: IconButton(
                    icon: const Icon(Icons.logout_outlined),
                    onPressed: () {
                      ref.read(firebaseAuthProvider).signOut();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const ProductBanner(),
                const SizedBox(height: 25),
                const Text(
                  "Products",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Text("View all of our products",
                    style: TextStyle(fontSize: 12)
                ),
                const ProductDetails(),
              ],
            ),
          )
      ),
    );
  }
}
