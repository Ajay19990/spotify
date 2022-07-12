import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:spotify/home_module/home_constatns.dart';
import 'package:spotify/utils/api.dart';
import 'package:spotify/utils/helpers.dart';

class HomeService {
  HomeService._privateConstructor();
  static final instance = HomeService._privateConstructor();

  Future getNewReleasedAlbums() async {
    final request = await API.createRequest(
      url: HomeConstants.newAlbumsUrl,
      method: RequestMethod.get,
    );

    try {
      var streamedResponse = await request.send();
      var resp = await http.Response.fromStream(streamedResponse);

      final Map<String, dynamic> decodedBody = jsonDecode(resp.body);
      log('Get New Released Albums: $decodedBody');
      if (resp.statusCode == 200) {
        //
      } else {
        if (decodedBody.containsKey('error')) {
          throw CustomException(decodedBody['error']['message']);
        }
        throw CustomException('Something went wrong');
      }
    } on SocketException {
      throw CustomException('No Internet connection');
    } on HttpException {
      throw CustomException('Something went wrong');
    } on FormatException {
      throw CustomException('Bad request');
    }
  }
}
