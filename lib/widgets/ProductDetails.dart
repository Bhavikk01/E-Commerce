import 'package:e_commerce/app/providers.dart';
import 'package:e_commerce/widgets/EmptyCart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app/ProductDisplay.dart';
import '../models/products.dart';

class ProductDetails extends ConsumerWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return StreamBuilder<List<Product>>(
      stream: ref.read(databaseProvider)!.getProduct(),
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.active && snapshot.data!=null){
          if(snapshot.data!.isEmpty){
            return const EmptyWidget();
          }
          else
            {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2
                    ),
                    itemBuilder: (context,index){
                      final product = snapshot.data![index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (_)=> ProductDisplay(products: product)
                          ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Expanded(

                                child: Hero(
                                    tag: product.name,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(product.imageUrl),
                                    )
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(product.name.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),),
                              const SizedBox(height: 5,),
                              Text(
                                "\$" + product.price.toString(),
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                      }
                    ),
              );
            }
        }
        else
          {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      }
    );
  }
}
