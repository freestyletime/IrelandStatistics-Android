import 'package:irelandstatistics/models/IBean.dart';

import 'SubChannel.dart';

class Channel extends IBean{
  String? channelId;
  String? channelName;
  String? channelType;
  List<int>? subChannelYears;
  List<SubChannel>? subChannels;

  Channel({this.channelId,
        this.channelName,
        this.channelType,
        this.subChannelYears,
        this.subChannels});

  Channel.fromJson(Map<String, dynamic> json) {
    channelId = json['channel_id'];
    channelName = json['channel_name'];
    channelType = json['channel_type'];
    subChannelYears = json['sub_channel_years'].cast<int>();
    if (json['sub_channels'] != null) {
      subChannels = <SubChannel>[];
      json['sub_channels'].forEach((v) {
        subChannels!.add(SubChannel.fromJson(v));
      });
    }
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return Channel.fromJson(json);
  }
}