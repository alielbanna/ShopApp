import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: state is! ShopLoadingFavoritesState,
        fallback: (BuildContext context) => const Center(
          child: CircularProgressIndicator(),
        ),
        builder: (BuildContext context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildFavoriteItem(
              ShopCubit.get(context).favoritesModel!.data!.data[index],
              context),
          separatorBuilder: (context, index) => Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
          itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
        ),
      ),
    );
  }

  Widget buildFavoriteItem(FavoriteData? model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model!.product.image),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.product.discount != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      color: Colors.red,
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        height: 1.3,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product.price.round()}',
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (model.product.discount != 0)
                          Text(
                            '${model.product.oldPrice.round()}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.product.id);
                          },
                          icon: Icon(
                            ShopCubit.get(context).favorites[model.product.id]!
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: ShopCubit.get(context)
                                    .favorites[model.product.id]!
                                ? Colors.red
                                : Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
