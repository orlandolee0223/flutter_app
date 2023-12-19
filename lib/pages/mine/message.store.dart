import 'package:mobx/mobx.dart';

import './services.dart';
// Include generated file
part 'message.store.g.dart';

class MessageStore = _MessageStore with _$MessageStore;

abstract class _MessageStore with Store {
  @observable
  MsgReadNumInfo messageInfo = MsgReadNumInfo.fromJson({});

  @computed
  bool get isNoReadMessage {
    // 计算总数
    int number = messageInfo.notice + messageInfo.post + messageInfo.promo;
    // 是否存在未读数量
    return number > 0;
  }

  // 初始化数据
  @action
  Future<MsgReadNumInfo> getUserNoReadMessage() async {
    //获取未读数量
    MsgReadNumInfo result = await getNoReadNumReq();
    messageInfo = result;
    return result;
  }
}

// 设置全局共享
final MessageStore messageStore = MessageStore();
