// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webView.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WebViewStore on _WebViewStore, Store {
  late final _$progressAtom =
      Atom(name: '_WebViewStore.progress', context: context);

  @override
  double get progress {
    _$progressAtom.reportRead();
    return super.progress;
  }

  @override
  set progress(double value) {
    _$progressAtom.reportWrite(value, super.progress, () {
      super.progress = value;
    });
  }

  late final _$_WebViewStoreActionController =
      ActionController(name: '_WebViewStore', context: context);

  @override
  void handleProgress(double value) {
    final _$actionInfo = _$_WebViewStoreActionController.startAction(
        name: '_WebViewStore.handleProgress');
    try {
      return super.handleProgress(value);
    } finally {
      _$_WebViewStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
progress: ${progress}
    ''';
  }
}
