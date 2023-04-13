import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/recipe_random_bloc.dart';
import './widgets/recipe_success_widget.dart';

class RandomRecipe extends StatefulWidget {
  const RandomRecipe({Key? key}) : super(key: key);

  @override
  State<RandomRecipe> createState() => _RandomRecipeState();
}

class _RandomRecipeState extends State<RandomRecipe> {
  late final RecipeRandomBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<RecipeRandomBloc>(context);
    bloc.add(LoadRandomRecipe());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<RecipeRandomBloc, RecipeRandomState>(
          builder: (context, state) {
            if (state is RecipeRandomLoadState) {
              return const Center(child: LoadingWidget());
            } else if (state is RecipeRandomSuccesState) {
              return RecipeDataWidget(
                equipment: state.equipment,
                info: state.recipe,
                similarlist: state.similar,
              );
            } else if (state is RecipeRandomErrorState) {
              return const Center(
                child: Text("Error random"),
              );
            } else {
              return Center(
                child: Container(
                  child: const Text("Waiting..."),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        color: Colors.redAccent,
        strokeWidth: 1.5,
        backgroundColor: Colors.grey,
      ),
    );
  }
}
