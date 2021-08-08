import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//font sizes
const LargeTextSize = 26.0;
const MediumTextSize = 20.0;
const Body1TextSize = 16.0;
const Body2TextSize = 14.0;
const CaptionTextSize = 12.0;
const OverlineTextSize = 10.0;
//font families
const String BodyFont = 'DMSans';
const String HeadingFont = 'PlayfairDisplay';
//colors
const Color SurfaceA = Color(0xff0F0F0F);
const Color SurfaceB = Color(0xff171717);
const Color SurfaceC = Color(0xff2A2A2A);
const Color SurfaceD = Color(0xff303030);
const Color PrimaryColor = Color(0xff2196F3);
const Color SecondaryColor = Color(0xff79C9AD);
const Color AccentColor = Color(0xff5776BA);
const Color GreyA = Color(0xffDDDEDD);
const Color GreyB = Color(0xff929292);
const Color GreyC = Color(0xff767676);
const Color GreyD = Color(0xff3D3D3D);
const Color DangerColor = Color(0xffFF6363);
const Color Turquoise = Color(0xFF219f9c);
const Color FaintBlue = Color(0xFFF5FCFF);
const Color FaintBlueDeeper = Color(0xFFDBF3FA);
const List<Color> Combination1 = [Color(0x105b86e5), Color(0x1036d1dc)];
const List<Color> Combination2 = [Color(0xFFFFFFFF), Color(0x80DDDEDD), Color(0xff3bbdc2), Color(0xff219f9c)];
const List<Color> CombinationBlue = [Color(0xFF2196F3), Color(0xFF009dff)];
const List<Color> CombinationPink = [Color(0xFFE91E63), Color(0xFFD7008A)];
const List<Color> CombinationGreen = [Color(0xFF4CAF50), Color(0xFF00C301)];

MaterialColor turquoise = MaterialColor(0xFF219f9c,
    <int, Color>{
      50:Color.fromRGBO(4,131,184, .1),
      100:Color.fromRGBO(4,131,184, .2),
      200:Color.fromRGBO(4,131,184, .3),
      300:Color.fromRGBO(4,131,184, .4),
      400:Color.fromRGBO(4,131,184, .5),
      500:Color.fromRGBO(4,131,184, .6),
      600:Color.fromRGBO(4,131,184, .7),
      700:Color.fromRGBO(4,131,184, .8),
      800:Color.fromRGBO(4,131,184, .9),
      900:Color.fromRGBO(4,131,184, 1),
    }
);

//appbar style
const AppBarTextStyle =
    TextStyle(fontFamily: BodyFont, fontWeight: FontWeight.w500, color: GreyA);
//text styles
const TitleTextStyle = TextStyle(
  fontFamily: HeadingFont,
  fontWeight: FontWeight.w500,
  fontSize: LargeTextSize,
  letterSpacing: 0,
  color: GreyA,
);
const BodyText1Style = TextStyle(
  fontFamily: BodyFont,
  fontWeight: FontWeight.w400,
  fontSize: Body1TextSize,
  color: GreyA,
  letterSpacing: 0.3,
);
const BodyText2Style = TextStyle(
  fontFamily: BodyFont,
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: GreyA,
  letterSpacing: 0.2,
);
const CaptionTextStyle = TextStyle(
    fontFamily: BodyFont,
    fontWeight: FontWeight.w400,
    fontSize: CaptionTextSize,
    color: GreyC,
    letterSpacing: 0.3);
const OverlineTextStyle = TextStyle(
  fontFamily: BodyFont,
  fontWeight: FontWeight.w700,
  fontSize: OverlineTextSize,
  color: GreyC,
  letterSpacing: 0.2,
);
const ButtonTextStyle = TextStyle(
  fontFamily: BodyFont,
  fontWeight: FontWeight.w700,
  fontSize: Body2TextSize,
  letterSpacing: 0.1,
);
const OutlineButtonStyle = TextStyle(
  fontSize: Body2TextSize - 0.5,
  fontFamily: BodyFont,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.4,
);
const SectionTitleStyle = TextStyle(
  fontFamily: BodyFont,
  fontWeight: FontWeight.w700,
  fontSize: 11.0,
  color: GreyA,
  letterSpacing: 0.3,
);
const SystemUiStyle = SystemUiOverlayStyle(
  statusBarColor: SurfaceA,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarColor: SurfaceA,
);
const CardStyle = BoxDecoration(
  color: SurfaceB,
  borderRadius: BorderRadius.all(
    const Radius.circular(4),
  ),
);
const InputLabelStyle = TextStyle(
  fontFamily: BodyFont,
  fontWeight: FontWeight.w500,
  fontSize: 12,
  color: GreyA,
  letterSpacing: 0.3,
);
