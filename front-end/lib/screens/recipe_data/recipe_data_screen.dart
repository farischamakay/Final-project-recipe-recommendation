import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/recipe_data_bloc.dart';
import '../recipe_random/widgets/recipe_success_widget.dart';

class RecipeData extends StatefulWidget {
  final String id;
  const RecipeData({Key? key, required this.id}) : super(key: key);

  @override
  State<RecipeData> createState() => _RecipeDataState();
}

class _RecipeDataState extends State<RecipeData> {
  late final RecipeDataBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<RecipeDataBloc>(context);
    bloc.add(LoadRecipeData(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<RecipeDataBloc, RecipeDataState>(
          builder: (context, state) {
            if (state is RecipeDataLoadState) {
              return const Center(child: LoadingWidget());
            } else if (state is RecipeDataSuccesState) {
              return RecipeDataWidget(
                equipment: state.equipment,
                info: state.recipe,
                similarlist: state.similar,
              );
            } else if (state is RecipeDataErrorState) {
              return Center(
                child: Container(
                  child: const Text("Error data"),
                ),
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
        color: Colors.greenAccent,
        strokeWidth: 1.5,
        backgroundColor: Colors.grey,
      ),
    );
  }
}
