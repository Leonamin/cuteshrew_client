import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart'
    as core show WidgetFactory;

const kCssListStyleTypeCircle = 'circle';
const kCssListStyleTypeSquare = 'square';

class CustomWidgetFactory extends core.WidgetFactory {
  /// Builds [SelectableText].
  @override
  Widget? buildListMarker(
    BuildMetadata meta,
    TextStyleHtml tsh,
    String listStyleType,
    int index,
  ) {
    final text = getListMarkerText(listStyleType, index);
    final style = tsh.style;
    return text.isNotEmpty
        ? SelectableText.rich(
            TextSpan(style: style, text: text),
            maxLines: 1,
            textDirection: tsh.textDirection,
          )
        // ? SelectableText(
        //     maxLines: 1,
        //     softWrap: fal,
        //     text: TextSpan(style: style, text: text),
        //     textDirection: tsh.textDirection,
        //   )
        : listStyleType == kCssListStyleTypeCircle
            ? HtmlListMarker.circle(style)
            : listStyleType == kCssListStyleTypeSquare
                ? HtmlListMarker.square(style)
                : HtmlListMarker.disc(style);
  }

  @override
  Widget? buildText(BuildMetadata meta, TextStyleHtml tsh, InlineSpan text) =>
      SelectableText.rich(
        TextSpan(
          children: [text],
        ),
        style: TextStyle(overflow: meta.overflow),
        maxLines: meta.maxLines > 0 ? meta.maxLines : null,
        textAlign: tsh.textAlign ?? TextAlign.start,
        textDirection: tsh.textDirection,
      );
  // RichText(
  //   maxLines: meta.maxLines > 0 ? meta.maxLines : null,
  //   overflow: meta.overflow,
  //   selectionRegistrar: tsh.getDependency(),
  // selectionColor:
  //     tsh.getDependency<DefaultSelectionStyle>().selectionColor,
  //   text: text,
  //   textAlign: tsh.textAlign ?? TextAlign.start,
  //   textDirection: tsh.textDirection,
  // );
}
