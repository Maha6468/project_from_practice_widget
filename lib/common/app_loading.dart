
import 'package:flutter_easyloading/flutter_easyloading.dart';

showLoading() {
  EasyLoading.show(
      status: "Loading...",
      dismissOnTap: true
  );
}

hideLoading() {
  EasyLoading.dismiss(animation: true);
}