//model
import 'index.model.dart';
// export
export './index.model.dart';

//消息中心数据
Future<MsgReadNumInfo> getNoReadNumReq() async {
  return MsgReadNumInfo.fromJson({});
}
