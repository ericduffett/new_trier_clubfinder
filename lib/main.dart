
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';
import 'meeting_days.dart';
import 'new_trier_colors.dart';
import 'search_parameters.dart';
import 'search_results.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'club.dart';
import 'interest_selector.dart';
import 'package:http/http.dart' as http;



void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: GoogleFonts.manrope().fontFamily,
          primaryColor: NewTrierColors.blue,
          appBarTheme: const AppBarTheme(
            color: NewTrierColors.blue,
          ),
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.all(NewTrierColors.blue),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                //foregroundColor: MaterialStateProperty.all(NewTrierColors.blue),
                backgroundColor: MaterialStateProperty.all(NewTrierColors.blue),
                textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
              )
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(NewTrierColors.blue),
              )
          ),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(NewTrierColors.blue),
              )
          ),
          textTheme: const TextTheme(
              bodyText1: TextStyle(
                fontSize: 14.0,
              )
          )
      ),
      home: const HomePage(),
    );
  }
}




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _nameSearchController = TextEditingController();
  final FocusNode _nameSearchFocusNode = FocusNode();

  void showMultiSelect() {
    showDialog(context: context, builder: (context) {
      return const InterestSelector();
    });
  }

  Future<http.Response> fetchClubs() {
    const url = "https://nths-app.nths.net/CFTestApp/WebService1.asmx/Search?keyword=";
    return http.get(Uri.parse(url));
  }

  //This function grabs the data from the database and then returns a list of Clubs. It's called when the user presses the search button.
  Future<List<Club>> performSearch() async {
    List<Club> allClubs = [];
    List<Club> clubsToReturn = [];

    allClubs.clear();
    clubsToReturn.clear();
    final getClubs = await fetchClubs();
    String response = getClubs.body;
    final clubList = jsonDecode(response);
    for (var club in clubList) {
      Club newClub = Club.fromJSON(club);
      allClubs.add(newClub);
    }


    bool madeSearchQuery = false;

    //Order of search
    //INTEREST - DAY OF WEEK - CAMPUS - NAME

    //Search by interest
    if (selectedInterestType.isNotEmpty) {
      madeSearchQuery = true;

      List<String> selectedInterests = [];

      for (var interest in selectedInterestType) {
        selectedInterests.add(interest.name);
      }

      //TODO: Filter by interest
      //TODO: Add club to database
      for (var interest in selectedInterests) {
        for (var club in allClubs) {
          if (club.interests.contains(interest)) {
            clubsToReturn.add(club);
          }
        }
      }

      //This connects to the back end and pulls data from the database by checking to see if any of the interests the user has selected match the interest category of the the club in the database.
      //The filtering function is defined as part of the Firebase Cloud Firestore functionality


      // final clubsRef = FirebaseFirestore.instance.collection('Clubs').where('interest', arrayContainsAny: selectedInterests).withConverter<Club>(
      //     fromFirestore: (snapshot, _) => Club.fromJSON(snapshot.data()!),
      //     toFirestore: (club, _) => club.toJSon());

      //This function works in conjunction with the one above and actually makes the request to the database.

      // List<QueryDocumentSnapshot<Club>> databaseClubs = await clubsRef.get().then((snapshot) => snapshot.docs);
      // for (var element in databaseClubs) {
      //   Club newClub = element.data();
      //   newClub.id = element.id;
      //   clubsToReturn.add(newClub);
      // }

      //Sort the clubs in alpha order
      clubsToReturn.sort((a, b) => a.clubName.toLowerCase().compareTo(b.clubName.toLowerCase()));

    }

    //Search by day of week
    if (selectedMeetingDays.isNotEmpty) {
      if (madeSearchQuery) {
        //User has already searched by interest, so we just need to filter that list rather than making a new request to the database.
        //Remove the clubs that don't satisfy selected meeting days
        List<Club> clubsToReturnCopy = clubsToReturn.map((club) => club).toList();
        clubsToReturn.clear();

        for (var club in clubsToReturnCopy) {
          for (var day in selectedMeetingDays) {
            if (club.days.isNotEmpty) {
              final convertedDay = dayAsAbbreviation(day);
              if (club.days.contains(convertedDay)) {
                clubsToReturn.add(club);
              }
            }
          }
        }

      } else {
        //User has not made any kind of search yet. Will need to start with all clubs from database.
        //TODO: Filter by days of the week.
        for (var club in allClubs) {
          for (var day in selectedMeetingDays) {
            if (club.days.isNotEmpty) {
              final convertedDay = dayAsAbbreviation(day);
              if (club.days.contains(convertedDay)) {
                clubsToReturn.add(club);
              }
            }
          }
        }
        // final clubsRef = FirebaseFirestore.instance.collection('Clubs').where('meetingDays', arrayContainsAny: selectedMeetingDays).withConverter<Club>(
        //     fromFirestore: (snapshot, _) => Club.fromJSON(snapshot.data()!),
        //     toFirestore: (club, _) => club.toJSon());
        //
        // List<QueryDocumentSnapshot<Club>> databaseClubs = await clubsRef.get().then((snapshot) => snapshot.docs);
        // for (var element in databaseClubs) {
        //   Club newClub = element.data();
        //   newClub.id = element.id;
        //   clubsToReturn.add(newClub);
        // }

        clubsToReturn.sort((a, b) => a.clubName.toLowerCase().compareTo(b.clubName.toLowerCase()));
      }

      madeSearchQuery = true;
    }

    //Search by campus
    if ((winnetka || northfield) && !(winnetka && northfield)) {

      if (madeSearchQuery) {
        //Has already searched by another criteria. Just filter that list.
        List<Club> clubsToReturnCopy = clubsToReturn.map((club) => club)
            .toList();
        clubsToReturn.clear();


        for (var club in clubsToReturnCopy) {
          print(club.abbreviatedCampus);
          if (winnetka) {
            if (club.abbreviatedCampus == 'WKA') {
              clubsToReturn.add(club);
            }
          }

          if (northfield) {
            if (club.abbreviatedCampus == 'NFD') {
              clubsToReturn.add(club);
            }
          }
        }
      } else {

        //Search database by location
        //TODO: Search by campus
        for (var club in allClubs) {
          if (winnetka) {
            if (club.abbreviatedCampus == 'WKA') {
              clubsToReturn.add(club);
            }
          }

          if (northfield) {
            if (club.abbreviatedCampus == 'NFD') {
              clubsToReturn.add(club);
            }
          }
        }

        // var selectedCampus = 'Winnetka';
        // if (northfield) {
        //   selectedCampus = 'Northfield';
        // }
        // final clubsRef = FirebaseFirestore.instance.collection('Clubs').where('campus', isEqualTo: selectedCampus).withConverter<Club>(
        //     fromFirestore: (snapshot, _) => Club.fromJSON(snapshot.data()!),
        //     toFirestore: (club, _) => club.toJSon());
        //
        // List<QueryDocumentSnapshot<Club>> databaseClubs = await clubsRef.get().then((snapshot) => snapshot.docs);
        // for (var element in databaseClubs) {
        //   Club newClub = element.data();
        //   newClub.id = element.id;
        //   clubsToReturn.add(newClub);
        // }

        clubsToReturn.sort((a, b) => a.clubName.toLowerCase().compareTo(b.clubName.toLowerCase()));
      }
      madeSearchQuery = true;
    }

    // Filter by name
    if (_nameSearchController.text != '') {
      print(_nameSearchController.text);

      List<Club> clubsToReturnCopy = [];

      if (madeSearchQuery) {
        clubsToReturnCopy = clubsToReturn.map((club) => club)
            .toList();
        clubsToReturn.clear();

      } else {
        clubsToReturnCopy = allClubs.map((club) => club).toList();
        clubsToReturn.clear();
        //Pull all clubs from database. Will filter using client.
        // //TODO: Pull all clubs. Put this first.
        // final clubsRef = FirebaseFirestore.instance.collection('Clubs').orderBy('clubName').withConverter<Club>(
        //     fromFirestore: (snapshot, _) => Club.fromJSON(snapshot.data()!),
        //     toFirestore: (club, _) => club.toJSon());
        //
        // List<QueryDocumentSnapshot<Club>> databaseClubs = await clubsRef.get().then((snapshot) => snapshot.docs);
        // for (var element in databaseClubs) {
        //   Club newClub = element.data();
        //   newClub.id = element.id;
        //   clubsToReturnCopy.add(newClub);
        // }
      }

      final searchParameters = _nameSearchController.text;
      final lowerCasedSearch = searchParameters.toLowerCase();

      //Filter all clubs by searching clubs for search criteria
      for (var element in clubsToReturnCopy) {
        final lowerCaseClubName = element.clubName.toLowerCase();
        if (lowerCaseClubName.contains(lowerCasedSearch)) {
          clubsToReturn.add(element);
        }
      }

      madeSearchQuery = true;
    }

    if (!madeSearchQuery) {
      //If user has not entered any search query data, then just pull all clubs from database.
      //TODO: pull all clubs from database.
      clubsToReturn = allClubs.map((club) => club).toList();
      // final clubsRef = FirebaseFirestore.instance.collection('Clubs').orderBy('clubName').withConverter<Club>(
      //     fromFirestore: (snapshot, _) => Club.fromJSON(snapshot.data()!),
      //     toFirestore: (club, _) => club.toJSon());
      //
      // List<QueryDocumentSnapshot<Club>> databaseClubs = await clubsRef.get().then((snapshot) => snapshot.docs);
      // for (var element in databaseClubs) {
      //   Club newClub = element.data();
      //   newClub.id = element.id;
      //   clubsToReturn.add(newClub);
      // }
    }

    return clubsToReturn;
  }

  String get clubInterestType {
    var stringToReturn = '';

    if (selectedInterestType.isNotEmpty) {
      for (var element in selectedInterestType) {
        final uppercased = '${element.name[0].toUpperCase()}${element.name.substring(1)}';
        if (stringToReturn == '') {
          stringToReturn += uppercased;
        } else {
          stringToReturn += ', $uppercased';
        }
      }
    } else {
      stringToReturn = 'No Club Interest Type Selected';
    }
    return stringToReturn;
  }

  String get clubMeetingDays {
    var stringToReturn = '';

    if (selectedMeetingDays.isNotEmpty) {
      for (var element in selectedMeetingDays) {
        if (stringToReturn == '') {
          stringToReturn += element.toString();
        } else {
          stringToReturn += ', ${element.toString()}';
        }
      }
    } else {
      stringToReturn = 'No Meeting Days Selected';
    }
    return stringToReturn;
  }

//Below are all the UI Components on the home screen.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Trier Club Finder',
          style: TextStyle(
            //fontSize: 32.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AdminLogin()));
        //       },
        //       icon: const Icon(Icons.admin_panel_settings)
        //   )
        // ],
      ),
      body: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const Center(
          child:  CircularProgressIndicator(
            color: NewTrierColors.blue,
          ),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => _nameSearchFocusNode.unfocus(),
            child: Container(
              height: double.infinity,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                          child: Text('Use the filters to find a club that interests you and fits your schedule.',
                            style: Theme.of(context).textTheme.headline6,)),
                      const SizedBox(height: 24.0,),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Text('Search for a Specific Club Name (optional)',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          autocorrect: false,
                          cursorColor: NewTrierColors.blue,
                          controller: _nameSearchController,
                          focusNode: _nameSearchFocusNode,
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: NewTrierColors.blue, width: 2.0)
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                              hintText: 'Club Name...',
                              border: OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(height: 24.0,),
                      Text('Filter by Interest',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () async {
                          await showDialog(context: context, builder: (context) {
                            return const InterestSelector();
                          });

                          setState(() {
                            selectedInterestType;
                          });
                        },
                        child: const Text('Select Interests'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(clubInterestType),
                      ),
                      const SizedBox(height: 24.0,),
                      Text('Filter by Club Meeting Days',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      ElevatedButton(
                        child: const Text('Select Days of the Week'),
                        onPressed: () async {
                          await showDialog(context: context, builder: (context) {
                            return const MeetingDays();
                          });
                          setState(() {
                            clubMeetingDays;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(clubMeetingDays),
                      ),
                      const SizedBox(height: 24.0,),
                      Text('Filter by Campus',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Wrap(
                        children: [
                          SizedBox(
                            width: 175,
                            child: CheckboxListTile(
                                title: const AutoSizeText('Northfield',
                                maxLines: 1),
                                value: northfield,
                                controlAffinity: ListTileControlAffinity.leading,
                                onChanged: (newValue) {

                                  setState(() {
                                    northfield = newValue!;
                                  });


                                }
                            ),
                          ),
                          SizedBox(
                            width: 175,
                            child: CheckboxListTile(
                                title: const AutoSizeText('Winnetka',
                                maxLines: 1,),
                                value: winnetka,
                                controlAffinity: ListTileControlAffinity.leading,
                                onChanged: (newValue) {
                                  setState(() {
                                    winnetka = newValue!;
                                  });
                                }
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Center(
                        child: OutlinedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(color: NewTrierColors.blue)),
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0)),
                          ),
                          child: const Text('Search',
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                          onPressed: () async {
                            context.loaderOverlay.show();
                            final List<Club> searchResults = await performSearch();
                            context.loaderOverlay.hide();
                            if (searchResults.isNotEmpty) {
                              Navigator.of(context).push(MaterialPageRoute(builder: (builder) => SearchResults(clubs: searchResults,)));
                            } else {
                              //Show alert of no search results.
                              showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  title: const Text('No Clubs Match Search'),
                                  content: const Text('No clubs match your search criteria. Please remove some search criteria and try again.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('OK'),
                                    )
                                  ],
                                );
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 36.0,
                      ),
                      TextButton(
                        onPressed: () async {
                          if (!await launch('https://774f073b.flowpaper.com/AftertheAcademics20212022Final/#page=1')) {
                            throw showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                title: const Text('Something Went Wrong...'),
                                content: const Text('If this error continues, please report it to duffette@nths.net'),
                                actions: [
                                  TextButton(onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                      child: const Text('OK'))
                                ],
                              );
                            });
                          }

                        },
                        child: const Center(
                            child: Text('Want to explore all clubs?\nClick here to access the interactive guide.',
                              textAlign: TextAlign.center,)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

