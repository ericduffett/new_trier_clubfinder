
import 'interest.dart';

bool monday = false;
bool tuesday = false;
bool wednesday = false;
bool thursday = false;
bool friday = false;
bool northfield = false;
bool winnetka = false;
Interest academic = Interest(name: 'Academic', selected: false);
Interest activism = Interest(name: 'Activism/Advocacy', selected: false);
Interest arts = Interest(name: 'Arts/Media', selected: false);
Interest business = Interest(name: 'Business/Innovation', selected: false);
Interest competition = Interest(name: 'Competition', selected: false);
Interest cultural = Interest(name: 'Cultural/International', selected: false);
Interest mindfulness = Interest(name: 'De-Stress/Mindfulness', selected: false);
Interest faith = Interest(name: 'Faith/Religion', selected: false);
Interest food = Interest(name: 'Food', selected: false);
Interest games = Interest(name: 'Games/Gaming', selected: false);
Interest government = Interest(name: 'Government/Political', selected: false);
Interest publications = Interest(name: 'Publications', selected: false);
Interest recreation = Interest(name: 'Recreation', selected: false);
Interest service = Interest(name: 'Service/Outreach', selected: false);
Interest special = Interest(name: 'Special Interest', selected: false);
Interest spirit = Interest(name: 'Spirit', selected: false);
Interest state = Interest(name: 'State/National Affiliations', selected: false);
Interest stem = Interest(name: 'STEM', selected: false);


List<String> selectedMeetingDays = [];
List<Interest> selectedInterestType = [];
List<Interest> allInterestTypes = [
   academic,
   activism,
   arts,
   business,
   competition,
   cultural,
   mindfulness,
   faith,
   food,
   games,
   government,
   publications,
   recreation,
   service,
   special,
   spirit,
   state,
   stem,
];

void resetAllInterests() {
   monday = false;
   tuesday = false;
   wednesday = false;
   thursday = false;
   friday = false;
   northfield = false;
   winnetka = false;
   academic.selected = false;
   activism.selected = false;
   arts.selected = false;
   business.selected = false;
   competition.selected = false;
   cultural.selected = false;
   mindfulness.selected = false;
   faith.selected = false;
   food.selected = false;
   games.selected = false;
   government.selected = false;
   publications.selected = false;
   recreation.selected = false;
   service.selected = false;
   special.selected = false;
   spirit.selected = false;
   state.selected = false;
   stem.selected = false;
   selectedInterestType = [];
   selectedMeetingDays = [];
}

void resetMeetingDays() {
   monday = false;
   tuesday = false;
   wednesday = false;
   thursday = false;
   friday = false;
   selectedMeetingDays = [];
}

void resetInterestType() {
   academic.selected = false;
   activism.selected = false;
   arts.selected = false;
   business.selected = false;
   competition.selected = false;
   cultural.selected = false;
   mindfulness.selected = false;
   faith.selected = false;
   food.selected = false;
   games.selected = false;
   government.selected = false;
   publications.selected = false;
   recreation.selected = false;
   service.selected = false;
   special.selected = false;
   spirit.selected = false;
   state.selected = false;
   stem.selected = false;
   selectedInterestType = [];
}

String dayAsAbbreviation(String day) {
   if (day == 'Monday') {
      return 'M';
   } else if (day == 'Tuesday') {
      return 'Tu';
   } else if (day == 'Wednesday') {
      return 'W';
   } else if (day == 'Thursday') {
      return 'Th';
   } else if (day == 'Friday') {
      return 'F';
   } else {
      return '';
   }
}

String dayAsFullWord(String abbreviatedDay) {
   if (abbreviatedDay == 'M') {
      return 'Monday';
   } else if (abbreviatedDay == 'Tu') {
      return 'Tuesday';
   } else if (abbreviatedDay == 'W') {
      return 'Wednesday';
   } else if (abbreviatedDay == 'Th') {
      return 'Thursday';
   } else if (abbreviatedDay == 'F') {
      return 'Friday';
   } else {
      return '';
   }
}
