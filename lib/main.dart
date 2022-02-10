import 'package:camarate_school_library/Screens/Abertura%20da%20app/abertura_screen.dart';
import 'package:flutter/material.dart';

//Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
//  runApp(const CamarateSchoolLibraryApp());
//}

void main() {
  runApp(const CamarateSchoolLibraryApp());
}

class CamarateSchoolLibraryApp extends StatelessWidget {
  const CamarateSchoolLibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // tira o debug do ecrã
      home: Scaffold(
        body: Stack(
          children: const [
            AberturaScreen(), // Abertura da página
          ],
        ),
        // para que o teclado do utilizador não redimensione a página
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
