// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MessageStore on _MessageStore, Store {
  Computed<bool>? _$isNoReadMessageComputed;

  @override
  bool get isNoReadMessage =>
      (_$isNoReadMessageComputed ??= Computed<bool>(() => super.isNoReadMessage,
              name: '_MessageStore.isNoReadMessage'))
          .value;

  late final _$messageInfoAtom =
      Atom(name: '_MessageStore.messageInfo', context: context);

  @override
  MsgReadNumInfo get messageInfo {
    _$messageInfoAtom.reportRead();
    return super.messageInfo;
  }

  @override
  set messageInfo(MsgReadNumInfo value) {
    _$messageInfoAtom.reportWrite(value, super.messageInfo, () {
      super.messageInfo = value;
    });
  }

  late final _$getUserNoReadMessageAsyncAction =
      AsyncAction('_MessageStore.getUserNoReadMessage', context: context);

  @override
  Future<MsgReadNumInfo> getUserNoReadMessage() {
    return _$getUserNoReadMessageAsyncAction
        .run(() => super.getUserNoReadMessage());
  }

  @override
  String toString() {
    return '''
messageInfo: ${messageInfo},
isNoReadMessage: ${isNoReadMessage}
    ''';
  }
}
