import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_not_app/config/themes/app_theme.dart';
import 'package:yes_not_app/presentation/providers/chat_provider.dart';
import 'package:yes_not_app/presentation/screens/chat/chat_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // ponemos el provider ChatProvider dentro del main para que todos los widget de la app puedan tener acceso al mismo
      providers: [ChangeNotifierProvider(create: (_) => ChatProvider())],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        // ------- Creamos una clase de temas personalizados --------
        theme: AppTheme(selectedColor: 3).theme(),
        home: const ChatScreen(),
        // home: Scaffold(
        //   appBar: AppBar(
        //     title: const Text('Material App Bar'),
        //   ),
        //   body: Center(
        //     child:
        //         FilledButton.tonal(onPressed: () {}, child: const Text('Hola')),
        //   ),
        // ),
      ),
    );
  }
}
