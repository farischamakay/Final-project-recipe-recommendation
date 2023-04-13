import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/search_result.dart';
import '../recipe_data/bloc/recipe_data_bloc.dart';
import '../recipe_data/recipe_data_screen.dart';
import '../recipe_search_result/bloc/recipe_search_result_bloc.dart';

class SearchResults extends StatefulWidget {
  final String id;
  const SearchResults({Key? key, required this.id}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late final RecipeSearchResultBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<RecipeSearchResultBloc>(context);
    bloc.add(LoadSearchResults(name: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xfff1bb274),
          title: const Text(
            "EasyCook",
            style: TextStyle(
                fontFamily: 'Satisfy',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        body: BlocBuilder<RecipeSearchResultBloc, RecipeSearchResultState>(
          builder: (context, state) {
            if (state is SearchResultsLoading) {
              return const Center(child: LoadingWidget());
            } else if (state is SearchResultsSuccess) {
              return Container(
                  child: SafeArea(
                      child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 13 / 16,
                  ),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    ...state.results.map((result) {
                      return SearchResultItem(
                        result: result,
                      );
                    }).toList()
                  ],
                ),
              )));
            } else if (state is SearchResultsError) {
              return const Center(
                child: Text("Error"),
              );
            } else {
              return Center(
                child: Container(
                  child: const Text("Nothing"),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class SearchResultItem extends StatefulWidget {
  final SearchResult result;
  const SearchResultItem({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  _SearchResultresulttate createState() => _SearchResultresulttate();
}

class _SearchResultresulttate extends State<SearchResultItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => RecipeDataBloc(),
              child: RecipeData(
                id: widget.result.id,
              ),
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                offset: Offset(-2, -2),
                blurRadius: 12,
                color: Color.fromRGBO(0, 0, 0, 0.05),
              ),
              BoxShadow(
                offset: Offset(2, 2),
                blurRadius: 5,
                color: Color.fromRGBO(0, 0, 0, 0.10),
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Container(
                  height: 120,
                  foregroundDecoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: widget.result.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(9),
                child: Text(
                  widget.result.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
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
