import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


import '../../common/app_loading.dart';
import '../../common/global_widget.dart';
import '../../data/repo/repo.dart';
import '../../models/register_model.dart';
import '../../routes/app_pages.dart';
import '../../views/widgets/dialogs.dart';

class RegisterRepo {
  Future<bool> registerWithEmailAndPassword(
      {String? fullname,
        String? phone,
        String? email,
        required BuildContext context,
        String? password}) async {
    try {
      showLoading();
      await UserRepo.getInstance().userRegister(
        data: {
          "fullname": fullname,
          "phonenumber": phone,
          "email": email,
          "password": password
        },
      ).then((response) {
        response.fold((l) {
          errorSnack(l.errorMessage.toString());
          print("Sakib Checking Register Error. Left");
          hideLoading();
          return false;
        }, (RegisterModel r) async {
          // PreferenceHelper.instance.setData(Pref.token, r.data?.accesstoken);
          print("Sakib Checking Register Error. Right: ${r.toJson()}");
          if (r.result != null) {
            String successText =
                "Congratulations! You're now connected to the Orbaic mining portal. To complete your registration, please verify your email by clicking the link we've sent to your email address. If you can't find it in your inbox, please check your spam folder.";

            await Dialogs.generalDialog(context, successText);


            Get.offAllNamed(Routes.LOGIN, arguments: {"email": email, "password": password});

            return true;
          }
        });
      });
    } catch (e) {
      errorSnack("$e");
      hideLoading();
      return false;
    }
    hideLoading();
    return false;

  }
}