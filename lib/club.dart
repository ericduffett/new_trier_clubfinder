
import 'package:new_trier_clubfinder/search_parameters.dart';

enum Campus {winnetka, northfield}

//Definition of a club and its properties. These properties match how data is stored in the back-end.

// class Club {
//   String clubName;
//   String? id;
//   String? sponsor1;
//   String? sponsor2;
//   String? sponsorEmail;
//   String? campus;
//   String? roomNumber;
//   List<dynamic>? meetingDays;
//   String? meetingTime;
//   String? additionalInfo;
//   String? description;
//   List<dynamic>? interest;
//
//   Club({required this.clubName, this.id, this.sponsor1, this.sponsor2, this.sponsorEmail, this.campus, this.roomNumber, this.meetingDays, this.meetingTime, this.additionalInfo, this.description, this.interest});
//
//   String get stringMeetingDays {
//     var stringToReturn = '';
//     meetingDays?.forEach((element) {
//       if (stringToReturn == '') {
//         stringToReturn += '$element';
//       } else {
//         stringToReturn += ', $element';
//       }
//     });
//
//     if (stringToReturn == '') {
//       stringToReturn = 'Meeting day TBD';
//     }
//
//     return stringToReturn;
//   }
//
//   String get clubMeetingTime {
//     var stringToReturn = '';
//     if (meetingTime != null) {
//       stringToReturn = 'from $meetingTime';
//     }
//     return stringToReturn;
//   }
//
//   String get clubMeetingLocation {
//     var stringToReturn = '';
//
//     if (meetingTime != null) {
//       stringToReturn = 'Room $roomNumber';
//     } else {
//       stringToReturn = 'Room TBD';
//     }
//
//     return stringToReturn;
//   }
//
//   String get clubSponsorInfo {
//     var stringToReturn = '';
//
//     if (sponsor1 != null && sponsor1 != '') {
//       stringToReturn += '$sponsor1';
//     }
//
//     if (sponsor2 != null  && sponsor2 != '') {
//       if (sponsor1 != null) {
//         stringToReturn += ' & $sponsor2';
//       } else {
//         stringToReturn += '$sponsor2';
//       }
//
//     }
//
//     if ((sponsor1 == null || sponsor1 == '') && (sponsor2 == null || sponsor2 == '')) {
//       stringToReturn = 'TBD';
//     }
//
//     return stringToReturn;
//   }
//
//   Club.fromJSON(Map<String, Object?> json) : this(
//     clubName: json['clubName']! as String,
//     sponsor1: json['sponsor1'] as String?,
//     sponsor2: json['sponsor2'] as String?,
//     sponsorEmail: json['sponsorEmail'] as String?,
//     campus: json['campus'] as String?,
//     roomNumber: json['roomNumber'] as String?,
//     meetingDays: json['meetingDays'] as List<dynamic>?,
//     meetingTime: json['meetingTime'] as String?,
//     interest: json['interest'] as List<dynamic>?,
//     description: json['description'] as String?,
//   );
//
//   Map<String, Object?> toJSon() {
//     return {
//       'clubName': clubName,
//       'sponsor1': sponsor1,
//       'sponsor2': sponsor2,
//       'sponsorEmail': sponsorEmail,
//       'campus': campus,
//       'roomNumber': roomNumber,
//       'meetingDays': meetingDays,
//       'meetingTime': meetingTime,
//       'additionalInfo': additionalInfo,
//       'interest': interest,
//       'description': description,
//     };
//   }
// }

class Club {

  int clubID;
  String clubName;
  String description;
  String? clubMeetingTime;
  String? clubMeetingLocation;
  String? abbreviatedCampus;
  String? sponsor1Name;
  String? sponsor2Name;
  String? sponsor1Email;
  String? sponsor2Email;
  String? daysAsCommaString;
  String? offCampus;
  double? schoolID;
  String? comments;
  String? interestsAsCommaString;

  Club({required this.clubID, required this.clubName, required this.description, this.clubMeetingTime, this.clubMeetingLocation, this.abbreviatedCampus, this.sponsor1Name, this.sponsor2Name, this.sponsor1Email, this.sponsor2Email, this.daysAsCommaString, this.schoolID, this.offCampus, this.comments, this.interestsAsCommaString});

  factory Club.fromJSON(Map<String, dynamic> json) {
    return Club(
      clubID: json['ClubID'],
      clubName: json['ClubName'],
      description: json['ClubDescription'],
      clubMeetingTime: json['ClubTime'],
      clubMeetingLocation: json['ZoomOrRoom'],
      abbreviatedCampus: json['Location'],
      sponsor1Name: json['Sponsor1Name'],
      sponsor2Name: json['Sponsor2Name'],
      sponsor1Email: json['Sponsor1_Email'],
      sponsor2Email: json['Sponsor2_Email'],
      daysAsCommaString: json['Days'],
      offCampus: json['OffCampus'],
      schoolID: json['SchoolID'],
      comments: json['Comments'],
      interestsAsCommaString: json['Interests'],
    );
  }

  String get campus {
    if (abbreviatedCampus == 'WKA') {
      return 'Winnetka Campus';
    } else if (abbreviatedCampus == 'NFD') {
      return 'Northfield Campus';
    } else if (abbreviatedCampus == 'Contact Sponsor') {
      return 'Contact Sponsor for Campus Information';
    } else {
      return abbreviatedCampus ?? 'Contact Sponsor';
    }
  }

  List<String> get interests {
    List<String> listToReturn = [];

    if (interestsAsCommaString != null) {
      listToReturn = interestsAsCommaString!.split(',');
    }

    return listToReturn;
  }

  List<String> get days {
    List<String> listToReturn = [];

    if (daysAsCommaString != null) {
      listToReturn = daysAsCommaString!.split(',');
    }
    return listToReturn;
  }

    String get stringMeetingDays {
    var stringToReturn = '';
    for (var element in days) {
      if (stringToReturn == '') {
        stringToReturn += dayAsFullWord(element);
      } else {
        stringToReturn += ', ${dayAsFullWord(element)}';
      }
    }

    if (stringToReturn == '') {
      stringToReturn = 'Meeting day TBD';
    }

    return stringToReturn;
  }

  String get clubSponsorInfo {
    var stringToReturn = '';

    if (sponsor1Name != null && sponsor1Name != '') {
      stringToReturn += '$sponsor1Name';
    }

    if (sponsor2Name != null  && sponsor2Name != '' && sponsor2Name != 'N/A') {
      if (sponsor1Name != null) {
        stringToReturn += ' & $sponsor2Name';
      } else {
        stringToReturn += '$sponsor2Name';
      }

    }

    if ((sponsor1Name == null || sponsor1Name == '' || sponsor1Name == 'N/A') && (sponsor2Name == null || sponsor2Name == '' || sponsor2Name == 'N/A')) {
      stringToReturn = 'TBD';
    }

    return stringToReturn;
  }

}
