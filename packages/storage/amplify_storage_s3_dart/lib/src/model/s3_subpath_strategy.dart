// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:amplify_core/amplify_core.dart';

/// {@template storage.amplify_storage_s3.list_category_options}
/// Configurable options for `Amplify.Storage.list`.
/// {@endtemplate}
class SubpathStrategy extends StorageCategoryOptions {
  /// {@macro storage.amplify_storage_s3.list_category_options}
  const SubpathStrategy._({
    this.excludeSubPaths = false,
    this.delimiter = '/',
  });

  /// {@macro storage.amplify_storage_s3.list_category_options}
  ///
  /// Use this to include subpaths
  const SubpathStrategy.include() : this._();

  /// {@macro storage.amplify_storage_s3.list_category_options}
  ///
  /// Constructor for SubpathStrategy for excluding subpaths, option to specify the delimiter
  const SubpathStrategy.exclude({String? delimiter = '/'})
      : this._(
          excludeSubPaths: true,
          delimiter: delimiter ?? '/',
        );

  /// Whether to exclude objects under the sub paths of the path to list.
  final bool excludeSubPaths;

  /// The delimiter to use when evaluating sub paths. If [excludeSubPaths] is
  /// false, this value has no impact on behavior.
  final String delimiter;

  @override
  Map<String, Object?> toJson() {
    return <String, dynamic>{
      'excludeSubPaths': excludeSubPaths,
      'delimiter': delimiter,
    };
  }
}
