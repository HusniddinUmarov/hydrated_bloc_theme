import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hydrated_bloc_them/app_theme.dart';
import 'package:hydrated_bloc_them/bloc/cubit/theme_cubit.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("My App restart");
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state,
            title: 'Hydrated Bloc',
            home: Banner(
              message: 'umarov dev',
              location: BannerLocation.topEnd,
              child: HomeView(),
            ),
          );
        },
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final List<(String, ThemeMode)> _themes = const [
    ('Dark', ThemeMode.dark),
    ('Light', ThemeMode.light),
    ('System', ThemeMode.system),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hydrated bloc'),
      ),
      body: Center(
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          buildWhen: (previous, current)=> previous != current,
            builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: List.generate(_themes.length, (index) {
                  final String lable = _themes[index].$1;

                  final ThemeMode theme = _themes[index].$2;

                  final bool isSelected = state == theme;

                  return Card(
                    color: Theme.of(context).colorScheme.primary,
                    elevation: 4,
                    shadowColor: Theme.of(context).colorScheme.primary,
                    child: ListTile(
                        title: Text(
                          lable,
                          style: TextStyle( color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: isSelected ? FontWeight.bold : null,
                              fontSize: isSelected ? 20 : null),
                        ),
                        onTap: () => context.read<ThemeCubit>().updateTheme(theme),
                        trailing: isSelected
                            ? Icon(
                                Icons.check_sharp,
                                color: Theme.of(context).colorScheme.onPrimary,
                              )
                            : null),
                  );
                }),
              ),

              Image.asset('assets/img_1.png', color: Theme.of(context).colorScheme.primary,)
            ],
          );
        }),
      ),
    );
  }
}
