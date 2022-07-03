import 'dart:convert';
import 'dart:typed_data';

class ConverterUtils {
  Uint8List stringToUInt8Code(String data) => base64Decode(data);
  String uInt8CodeToString(Uint8List data) => base64Encode(data);
}
