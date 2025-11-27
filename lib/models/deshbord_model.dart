import 'dart:convert';

DeshbordModel deshbordModelFromJson(String str) =>
    DeshbordModel.fromJson(json.decode(str));

String deshbordModelToJson(DeshbordModel data) => json.encode(data.toJson());

class DeshbordModel {
  final Result? result;
  final int? statusCode;

  DeshbordModel({
    this.result,
    this.statusCode,
  });

  factory DeshbordModel.fromJson(Map<String, dynamic> json) => DeshbordModel(
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result?.toJson(),
    "statusCode": statusCode,
  };
}

class Result {
  final Quiz? quiz;
  final Mine? mine;
  final Team? team;
  final double? balance;
  final double? currentHashRate;
  final bool? isOffer;
  Result({
    this.quiz,
    this.mine,
    this.team,
    this.balance,
    this.currentHashRate,
    this.isOffer
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    quiz: json["Quiz"] == null ? null : Quiz.fromJson(json["Quiz"]),
    mine: json["Mine"] == null ? null : Mine.fromJson(json["Mine"]),
    team: json["Team"] == null ? null : Team.fromJson(json["Team"]),
    balance: json["Balance"]?.toDouble(),
    isOffer: json["isOffer"],
    currentHashRate: json["CurrentHashRate"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Quiz": quiz?.toJson(),
    "Mine": mine?.toJson(),
    "Team": team?.toJson(),
    "Balance": balance,
    "isOffer": isOffer,
    "CurrentHashRate": currentHashRate,
  };
}

class Mine {
  final int? timeLeft;
  final int? miningStartedAt;
  final MineSummary? mineSummary;
  final bool? isMining;
  final double? newMinedTokens;

  Mine({
    this.timeLeft,
    this.miningStartedAt,
    this.mineSummary,
    this.isMining,
    this.newMinedTokens,
  });

  factory Mine.fromJson(Map<String, dynamic> json) => Mine(
    timeLeft: json["TimeLeft"],
    miningStartedAt: json["MiningStartedAt"],
    mineSummary: json["MineSummary"] == null ? null : MineSummary.fromJson(json["MineSummary"]),
    isMining: json["IsMining"],
    newMinedTokens: json["NewMinedTokens"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "TimeLeft": timeLeft,
    "MiningStartedAt": miningStartedAt,
    "MineSummary": mineSummary?.toJson(),
    "IsMining": isMining,
    "NewMinedTokens": newMinedTokens,
  };
}

class MineSummary {
  final int? summaryHours;
  final int? miningHours;
  final double? sessionProgress;

  MineSummary({
    this.summaryHours,
    this.miningHours,
    this.sessionProgress,
  });

  factory MineSummary.fromJson(Map<String, dynamic> json) => MineSummary(
    summaryHours: json["summaryHours"],
    miningHours: json["miningHours"],
    sessionProgress: json["sessionProgress"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "summaryHours": summaryHours,
    "miningHours": miningHours,
    "sessionProgress": sessionProgress,
  };
}

class Quiz {
  final int? quizLastSolvedTime;
  final int? nextQuizTime;
  final double? quizTimeProgress;
  final QuizSummary? quizSummary;

  Quiz({
    this.quizLastSolvedTime,
    this.nextQuizTime,
    this.quizTimeProgress,
    this.quizSummary,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
    quizLastSolvedTime: json["QuizLastSolvedTime"],
    nextQuizTime: json["NextQuizTime"],
    quizTimeProgress: json["QuizTimeProgress"]?.toDouble(),
    quizSummary: json["QuizSummary"] == null ? null : QuizSummary.fromJson(json["QuizSummary"]),
  );

  Map<String, dynamic> toJson() => {
    "QuizLastSolvedTime": quizLastSolvedTime,
    "NextQuizTime": nextQuizTime,
    "QuizTimeProgress": quizTimeProgress,
    "QuizSummary": quizSummary?.toJson(),
  };
}

class QuizSummary {
  final int? quizSeason;
  int? totalSolvedQuiz = 0;
  final int? quizSeasonProgress;

  QuizSummary({
    this.quizSeason,
    this.totalSolvedQuiz,
    this.quizSeasonProgress,
  });

  factory QuizSummary.fromJson(Map<String, dynamic> json) => QuizSummary(
    quizSeason: json["quizSeason"],
    totalSolvedQuiz: json["totalSolvedQuiz"],
    quizSeasonProgress: json["quizSeasonProgress"],
  );

  Map<String, dynamic> toJson() => {
    "quizSeason": quizSeason,
    "totalSolvedQuiz": totalSolvedQuiz,
    "quizSeasonProgress": quizSeasonProgress,
  };
}


class Team {
  TeamMembers? teamMembers;

  Team({this.teamMembers});

  Team.fromJson(Map<String, dynamic> json) {
    teamMembers = json['teamMembers'] != null
        ? new TeamMembers.fromJson(json['teamMembers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teamMembers != null) {
      data['teamMembers'] = this.teamMembers!.toJson();
    }
    return data;
  }
}

class TeamMembers {
  int? activeTeam;
  int? totalTeam;
  List<TeamMember>? teamMembers;

  TeamMembers({this.activeTeam, this.totalTeam, this.teamMembers});

  TeamMembers.fromJson(Map<String, dynamic> json) {
    activeTeam = json['ActiveTeam'];
    totalTeam = json['TotalTeam'];
    if (json['teamMembers'] != null) {
      teamMembers = <TeamMember>[];
      json['teamMembers'].forEach((v) {
        teamMembers!.add(new TeamMember.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ActiveTeam'] = this.activeTeam;
    data['TotalTeam'] = this.totalTeam;
    if (this.teamMembers != null) {
      data['teamMembers'] = this.teamMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamMember {
  String? fullName;
  bool? isMining;

  TeamMember({this.fullName, this.isMining});

  TeamMember.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    isMining = json['isMining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['isMining'] = this.isMining;
    return data;
  }
}



// class Team {
//   final int? activeTeam;
//   final int? totalTeam;
//   final TeamMembers? teamMembers;
//
//   Team({
//     this.activeTeam,
//     this.totalTeam,
//     this.teamMembers,
//   });
//
//   factory Team.fromJson(Map<String, dynamic> json) => Team(
//     activeTeam: json["ActiveTeam"],
//     totalTeam: json["TotalTeam"],
//     teamMembers: json["teamMembers"] == null ? null : TeamMembers.fromJson(json["teamMembers"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "ActiveTeam": activeTeam,
//     "TotalTeam": totalTeam,
//     "teamMembers": teamMembers?.toJson(),
//   };
// }
//
// class TeamMembers {
//   final List<TeamMember>? teamMembers;
//
//   TeamMembers({
//     this.teamMembers,
//   });
//
//   factory TeamMembers.fromJson(Map<String, dynamic> json) => TeamMembers(
//     teamMembers: json["teamMembers"] == null
//         ? null
//         : List<TeamMember>.from(json["teamMembers"].map((x) => TeamMember.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "teamMembers": teamMembers == null ? null : List<dynamic>.from(teamMembers!.map((x) => x.toJson())),
//   };
// }
//
// class TeamMember {
//   final String? fullname;
//   final bool? isMining;
//
//   TeamMember({
//     this.fullname,
//     this.isMining,
//   });
//
//   factory TeamMember.fromJson(Map<String, dynamic> json) => TeamMember(
//     fullname: json["fullName"],
//     isMining: json["isMining"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "fullName": fullname,
//     "isMining": isMining,
//   };
// }