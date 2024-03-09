import 'package:vechtrackapp/constant/kimports.dart';

class convertimagestobyte {
  Future<Uint8List> convertimage(BuildContext context) async {
    ByteData data = await DefaultAssetBundle.of(context).load(img.makercar);
    return data.buffer.asUint8List();
  }
}
