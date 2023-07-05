import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension TestWidgetExtension on Widget {
  Widget withTestStyle({
    double size = 14.0,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
    double opacity = 1.0,
    TextOverflow textOverflow = TextOverflow.clip,
    int maxLines = 1,
    TextStyle? style,
    String? fontFamily,
  }) {
    TextStyle textStyle = TextStyle(
      fontSize: size,
      color: color.withOpacity(opacity),
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    ).merge(style);

    if (fontFamily == null) {
      textStyle = GoogleFonts.openSans().merge(textStyle);
    } else {
      textStyle = GoogleFonts.getFont(fontFamily).merge(textStyle);
    }

    return DefaultTextStyle.merge(
      style: textStyle,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: double.infinity,
        ),
        child: DefaultTextStyle(
          style: textStyle,
          overflow: textOverflow,
          maxLines: maxLines,
          child: this,
        ),
      ),
    );
  }
}
/*
extension ExtendedText on Text {
  Widget withAttributes({
    double? size,
    Color? color,
    FontWeight? fontWeight,
    double? opacity,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(
      this.data ?? '',
      style: TextStyle(
        fontSize: size ?? this.style?.fontSize,
        color: color ?? this.style?.color,
        fontWeight: fontWeight ?? this.style?.fontWeight,
        fontFamily: this.style?.fontFamily,
        fontStyle: this.style?.fontStyle,
        decoration: this.style?.decoration,
        decorationColor: this.style?.decorationColor,
        decorationStyle: this.style?.decorationStyle,
        letterSpacing: this.style?.letterSpacing,
        wordSpacing: this.style?.wordSpacing,
        shadows: this.style?.shadows,
        background: this.style?.background,
        foreground: this.style?.foreground,
        height: this.style?.height,
        textBaseline: this.style?.textBaseline,
        locale: this.style?.locale,
        backgroundColor: this.style?.backgroundColor,
        fontFeatures: this.style?.fontFeatures,
        decorationThickness: this.style?.decorationThickness,
        debugLabel: this.style?.debugLabel,
        fontFamilyFallback: this.style?.fontFamilyFallback,
      ),
      overflow: overflow ?? this.overflow,
      maxLines: maxLines ?? this.maxLines,
      softWrap: this.softWrap,
      textAlign: this.textAlign,
      textDirection: this.textDirection,
      locale: this.locale,
      semanticsLabel: this.semanticsLabel,
      textScaleFactor: this.textScaleFactor,
      strutStyle: this.strutStyle,
    );
  }
}*/
