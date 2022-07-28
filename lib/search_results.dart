import 'club_details_row.dart';
import 'package:flutter/material.dart';

import 'club.dart';



class SearchResults extends StatelessWidget {

  final List<Club> clubs;

  const SearchResults({Key? key, required this.clubs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Search Results',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView.separated(
            itemCount: clubs.length,
            itemBuilder: (context, row) {
              return Container(
                color: row.isEven ? Colors.green.shade50: Colors.blue.shade50,
                  child: ClubDetailsRow(club: clubs[row]));
            },
          separatorBuilder: (context, row) {
              return Container(
                height: 1,
                color: Colors.black12,
              );
          },
        ),
      );
  }
}
