import 'package:get/get.dart';


import '../common/app_loading.dart';
import '../common/global_widget.dart';
import '../data/repo/repo.dart';
import '../models/my_offers_model.dart';
import '../models/offers_history_model.dart';

class MerchantController extends GetxController{

  var pageHistory = 0.obs;
  var pageOffers = 0.obs;
  var isLoading = false.obs;
  var isLastPage = false.obs;
  var historyModel = Rx<OffersHistoryModel?>(null);
  var offersModel = Rx<MyOffersModel?>(null);


  Future<void> setMerchantHistory() async {
    late OffersHistoryModel model;
    // if(isLoading.value || isLastPage.value)
    if(true)
    {
      try {
        showLoading();
        await UserRepo.getInstance().getMerchantHistory(pageHistory.value, 10).then((response) {
          response.fold((l) {
            print("Sakib Implemented refresh dashboard: error $l");
            errorSnack(l.errorMessage.toString());
            hideLoading();
          }, (r) async {
            historyModel.value = r;
          });
        });
      } catch (e) {
        errorSnack("$e");
        hideLoading();
      } finally {
        hideLoading();
      }
    }
  }


  Future<void> setMerchantOffers() async {
    // if(isLoading.value || isLastPage.value)
    if(true)
    {
      try {
        showLoading();
        await UserRepo.getInstance().getMerchantOffers(pageOffers.value, 10).then((response) {
          response.fold((l) {
            print("Sakib Implemented refresh dashboard: error $l");
            errorSnack(l.errorMessage.toString());
            hideLoading();
          }, (r) async {
            offersModel.value = r;
          });
        });
      } catch (e) {
        errorSnack("$e");
        hideLoading();
      } finally {
        hideLoading();
      }
    }
  }




  Future<void> claimOffer(String offerId) async {
    if(true)
    {
      try {
        showLoading();
        await UserRepo.getInstance().claimOffer(offerId).then((response) {
          response.fold((l) {
            errorSnack(l.errorMessage.toString());
            hideLoading();
          }, (r) async {
            successSnack(r);
          });
        });
      } catch (e) {
        errorSnack("$e");
        hideLoading();
      } finally {
        hideLoading();
      }
    }
  }

  @override
  Future<void> onInit() async {
    await setMerchantOffers();
    await setMerchantHistory();
    super.onInit();
  }

}