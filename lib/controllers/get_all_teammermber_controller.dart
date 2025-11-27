import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pausable_timer/pausable_timer.dart';

import '../common/app_loading.dart';
import '../common/global_widget.dart';
import '../data/repo/repo.dart';
import '../models/all_team_model.dart';
import '../models/all_team_model.dart' as AllTeamModel;
import '../models/ping_all_members.dart';

class GetALLTeamController extends GetxController {

  var allTeamModel = Rx<AllTeamModel.AllTeamModel?>(null); // Changed Rx to Rxn
  var pingMembers = Rx<PingAllUsers?>(null); // Changed Rx to Rxn
  double totalRefEarn = 0.0;
  var searchQuery = ''.obs;
  var isLoading = false.obs; // Define isLoading property
  RxList<TeamMember> teamMembers = <TeamMember>[].obs;
  var isPingAvailable = true.obs;
  var nextPingCountDown = "00:00:00".obs;
  var pingStopTimeInSeconds = 3600.obs;
  late PausableTimer timer;
  static const oneSec = Duration(seconds: 1);
  final _cache = GetStorage();
  // Getter for isLoading

  Future<void> getData() async { // Changed return type to Future<void>
    try {
      showLoading(); // Set isLoading to true before API call
      final response = await UserRepo.getInstance().GetALLTeamModelData(); // Changed to await syntax
      response.fold((l) {
        errorSnack(l.errorMessage.toString());
      }, (r) {
        allTeamModel.value = r;
        teamMembers.value=allTeamModel.value?.result?.teamMembers??[];
        isLoading( false); // Set isLoading to false after API call completes
      });
    } catch (e) {
      errorSnack("$e");
    } finally {
      hideLoading(); // Set isLoading to false after API call completes
    }
  }

  Future<void> pingAllMembers() async { // Changed return type to Future<void>
    try {
      final response = await UserRepo.getInstance().pingInActiveUsers(); // Changed to await syntax
      response.fold((l) {
        errorSnack(l.errorMessage.toString());
      }, (r) {
        isPingAvailable.value = false;
        pingMembers.value = r;
        successSnack("Pinged successfully");
        pingStopTimeInSeconds.value = DateTime.now().second;
        nextPingCountDown.value = formatDuration(Duration(seconds: pingStopTimeInSeconds.value));
        _cache.write("pingIsActive", true);
        timer.start();
      });
    } catch (e) {
      errorSnack("$e");
    } finally {
    }
  }

  List<TeamMember> get filteredTeamMembers {
    final query = searchQuery.value.toLowerCase();
    final teamMembers = allTeamModel.value?.result?.teamMembers;

    if (teamMembers != null) {
      if (query.isEmpty) {
        return teamMembers;
      } else {
        return teamMembers
            .where((member) => member.fullname?.toLowerCase().contains(query) ?? false)
            .toList();
      }
    } else {
      return [];
    }
  }


  void startCountDownForNextPing(){
    timer = PausableTimer.periodic(oneSec, () async {
      if(pingStopTimeInSeconds.value >= 0){
        pingStopTimeInSeconds.value--;
        nextPingCountDown.value = formatDuration(Duration(seconds: pingStopTimeInSeconds.value));
      } else {
        isPingAvailable.value = true;
        timer.cancel();
      }
    });
  }



  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);
    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');
    return '$formattedHours:$formattedMinutes:$formattedSeconds';
  }

  @override
  void onInit() async {
    super.onInit();
    await getData();
    startCountDownForNextPing();
    if(_cache.hasData("pingIsActive")){
      timer.start();
      isPingAvailable.value = false;
    }
  }
}