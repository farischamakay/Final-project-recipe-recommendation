import 'package:cooking_tutorial_application/screens/homepage/homepage.dart';
import 'package:cooking_tutorial_application/screens/homepage/list_recommendation.dart';
import 'package:cooking_tutorial_application/screens/navigator/bottom_navigator.dart';
import 'package:cooking_tutorial_application/screens/profile/about_app.dart';
import 'package:cooking_tutorial_application/screens/recipe_view/recipeView.dart';
import 'package:cooking_tutorial_application/screens/start/ingredients/input_ingredients.dart';
import 'package:cooking_tutorial_application/screens/profile/profile_page.dart';
import 'package:cooking_tutorial_application/screens/profile/edit_profile.dart';
import 'package:cooking_tutorial_application/screens/profile/version.dart';
import 'package:cooking_tutorial_application/screens/recipe_data/bloc/recipe_data_bloc.dart';
import 'package:cooking_tutorial_application/screens/recipe_random/random_recipe_screen.dart';
import 'package:cooking_tutorial_application/screens/recipe_search_result/bloc/recipe_search_result_bloc.dart';
import 'package:cooking_tutorial_application/screens/search/search_page.dart';
import 'package:cooking_tutorial_application/screens/start/screens/edit_preferences.dart';
import 'package:cooking_tutorial_application/screens/start/screens/screens.dart';
import 'package:cooking_tutorial_application/screens/start/screens/user_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:cooking_tutorial_application/screens/start/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'screens/recipe_random/bloc/recipe_random_bloc.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('Favorite');

  runApp(MultiBlocProvider(providers: [
    BlocProvider<RecipeRandomBloc>(
      create: (context) => RecipeRandomBloc(),
      child: const RandomRecipe(),
    ),
    BlocProvider(
      create: (context) => RecipeDataBloc(),
    ),
    BlocProvider(
      create: (context) => RecipeSearchResultBloc(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final themeData = GetStorage();
  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    bool darkMode = themeData.read('darkmode') ?? false;
    return GetMaterialApp(
      title: 'Cooking Tutorial Apps',
      theme: darkMode
          ? ThemeData.dark()
          : ThemeData(
              fontFamily: 'Satoshi',
              primarySwatch: Colors.blue,
              primaryColor: Colors.redAccent,
              textTheme: const TextTheme(
                headline1: TextStyle(
                    fontFamily: 'Satisfy',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
      initialRoute: Splash.nameRoutes,
      // initialRoute: InputIngredientsPage.nameRoute,
      debugShowCheckedModeBanner: false,
      routes: {
        Splash.nameRoutes: (context) => const Splash(),
        '/loginpage': (BuildContext context) => const LoginScreen(),
        '/bottomnav': (BuildContext context) => const BottomNavigatorView(),
        '/editProfile': (BuildContext context) => const EditProfile(),
        '/addPref': (BuildContext context) => const AddPreferences(),
        '/about': (BuildContext context) => const AboutApp(),
        '/listRec': (BuildContext context) => const ListRecommendation(),
        SignUpScreen.nameRoute: (BuildContext context) => const SignUpScreen(),
        ProfilePage.nameRoute: (context) => const ProfilePage(),
        VersionPage.nameRoute: (context) => const VersionPage(),
        ForgotPasswordPage.nameRoute: (context) => const ForgotPasswordPage(),
        CompleteProfilPage.nameRoute: (context) => const CompleteProfilPage(),
        SearchPage.nameRoute: (context) => const SearchPage(),
        UserPreferencesPage.routeName: (context) => const UserPreferencesPage(),
        InputIngredientsPage.nameRoute: (context) =>
            const InputIngredientsPage(),
        Homepage.nameRoute: (context) => const Homepage(),
      },
    );
  }
}
