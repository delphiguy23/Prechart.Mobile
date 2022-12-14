import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:person_portal/constants/constants.dart';
import 'package:person_portal/model/endPointServers.dart';

class MongoController extends GetxController{
  var endPointServers = <EndPointServersModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getEndPointServers();
  }

  void getEndPointServers() async {
    try {
      var db = await Db.create(mongoConnectionString);
      await db.open();

      var endPointCollection = db.collection(mongoEndPointsCollection);

      List<EndPointServersModel> data = [];

      await endPointCollection.find().forEach((element) {
        var result = EndPointServersModel.fromJson(element);

        if (result.active == true) {
          data.add(result);
        }
      });

      endPointServers.value = data;

      await db.close();
    } catch (e) {
      endPointServers.clear();

      if (kDebugMode) {
        print(e);
      }
    }
  }
}
