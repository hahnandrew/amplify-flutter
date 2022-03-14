import 'package:smithy/ast.dart';

/// Binds a map structure member to prefixed HTTP headers.
class HttpPrefixHeadersTrait extends StringTrait {
  const HttpPrefixHeadersTrait(String value) : super(id, value);

  const HttpPrefixHeadersTrait.fromJson(Object? json) : this(json as String);

  static const id = ShapeId.core('httpPrefixHeaders');
}
