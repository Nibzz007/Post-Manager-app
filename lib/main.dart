import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:post_manager_app/core/theme/app_theme.dart';
import 'package:post_manager_app/injection_container.dart' as di;
import 'package:post_manager_app/presentation/post/bloc/post_bloc.dart';
import 'package:post_manager_app/presentation/post/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the secret note!
  await dotenv.load(fileName: ".env");

  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // 1. Post Feature BLoC
        BlocProvider<PostBloc>(
          // We ask 'di.sl' (the Tool Belt) to build the BLoC for us.
          // We also use the '..' (cascade operator) to immediately
          // tell the BLoC to go fetch the posts as soon as it's born!
          create: (context) => di.sl<PostBloc>()..add(GetPostsEvent()),
        ),

        /* You can add more BLoCs here as your app grows:
        BlocProvider<ProfileBloc>(create: (context) => di.sl<ProfileBloc>()),
        BlocProvider<SettingsBloc>(create: (context) => di.sl<SettingsBloc>()),
        */
      ],
      child: MaterialApp(
        title: 'Post Manager App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: HomePage(),
      ),
    );
  }
}
