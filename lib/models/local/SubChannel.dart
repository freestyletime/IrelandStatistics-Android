import 'package:irelandstatistics/models/IBean.dart';

class SubChannel implements IBean{
  String? subChannelId;
  String? subChannelName;
  String? subChannelType;

  SubChannel({this.subChannelId, this.subChannelName, this.subChannelType});

  SubChannel.fromJson(Map<String, dynamic> json) {
    subChannelId = json['sub_channel_id'];
    subChannelName = json['sub_channel_name'];
    subChannelType = json['sub_channel_type'];
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return SubChannel.fromJson(json);
  }
}