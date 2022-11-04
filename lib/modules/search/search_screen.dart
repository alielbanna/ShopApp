import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) => Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    label: 'Search',
                    prefix: Icons.search,
                    validate: (String? value) {
                      return null;
                    },
                    onSubmit: (String text) {
                      SearchCubit.get(context).search(text);
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  if (state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildSearchItem(
                            SearchCubit.get(context).model!.data!.data[index],
                            context),
                        separatorBuilder: (context, index) => Container(
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                        itemCount:
                            SearchCubit.get(context).model!.data!.data.length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSearchItem(Product? model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(model!.image),
                width: 120.0,
                height: 120.0,
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
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
                          '${model.price.round()}',
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
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
