import 'package:flutter/material.dart';
import 'package:new_trier_clubfinder/email_sponsor_button.dart';
import 'club.dart';
import 'club_details_page.dart';


class ClubDetailsRow extends StatelessWidget {

  final Club club;

  const ClubDetailsRow({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(club.clubName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Text(club.campus,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          Text('This club meets on ${club.stringMeetingDays} from ${club.clubMeetingTime} in ${club.clubMeetingLocation}.',
            style: const TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text('Sponsor(s)',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Text(club.clubSponsorInfo,
            style: const TextStyle(
              //fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.only(right: 6.0)),
                ),
                child: const Text('Get More Info'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClubDetailsPage(club: club)));
                },
              ),
              const SizedBox(
                width: 48.0,
              ),
              EmailSponsorButton(club: club),
            ],
          ),
        ],
      ),
    );
  }
}

class AdminClubDetailsRow extends StatelessWidget {

  final Club club;

  const AdminClubDetailsRow({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(club.clubName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Text(club.campus,
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(
            height: 6.0,
          ),
          Text('Meeting Details: ${club.clubMeetingLocation}. ${club.stringMeetingDays} ${club.clubMeetingTime}'),
          Text('Club Sponsors: ${club.clubSponsorInfo}'),
        ],
      ),
    );
  }
}

