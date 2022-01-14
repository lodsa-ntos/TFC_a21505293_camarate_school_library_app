import 'package:flutter/material.dart';
import 'cores.dart';

class MyTextTheme {
  static TextStyle tituloLivrosTextStyle = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 32.0,
    color: Colors.white,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.1,
  );

  static TextStyle nomeAutoresTextStyle = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12.0,
    color: Colors.grey,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.1,
  );
}

const TextStyle headingTextStyle = TextStyle(
  fontFamily: 'Gobold',
  fontSize: 32.0,
  color: Colors.white,
  fontWeight: FontWeight.w700,
  letterSpacing: 1.1,
);

const TextStyle whiteNameTextStyle = TextStyle(
  fontSize: 24.0,
  color: Colors.white,
  fontWeight: FontWeight.w600,
);

const TextStyle whiteSubHeadingTextStyle = TextStyle(
  fontSize: 18.0,
  color: Colors.white,
  fontWeight: FontWeight.w400,
);

const TextStyle titleStyle = TextStyle(
  fontSize: 22.0,
  color: primaryTextColor,
  fontWeight: FontWeight.w600,
);

const TextStyle subTitleStyle = TextStyle(
  fontSize: 18.0,
  color: secondaryTextColor,
  fontWeight: FontWeight.w200,
);

const TextStyle actionMenuStyle = TextStyle(
  fontSize: 16.0,
  color: primaryColor,
  fontWeight: FontWeight.w600,
  letterSpacing: 5,
);

const kDefaultPadding = 20.0;

// sombra
const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);
