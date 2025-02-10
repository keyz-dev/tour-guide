import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  final String cloudName = "dgzzdltn0";  // Replace with your Cloudinary Cloud Name
  final String uploadPreset = "initial_preset";  // Replace with your upload preset

  Future<Map<String, dynamic>> uploadImage(File imageFile, {required String imagePath}) async {
    final url = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

    try{
      var request = http.MultipartRequest("POST", url)
        ..fields['upload_preset'] = uploadPreset
        ..fields['folder'] = imagePath
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final uploadedImageUrl = jsonDecode(responseData)['url'];
        return {
          'success': true,
          'value': uploadedImageUrl
        };
      } else {
        return {
          'success': false,
          'value': response.toString()
        };
      }
    }catch (e) {
      return {
        'success': false,
        'value': e.toString()
      };
    }
  }
}
