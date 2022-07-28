import 'search_parameters.dart';
import 'package:flutter/material.dart';


class InterestSelector extends StatefulWidget {
  const InterestSelector({Key? key}) : super(key: key);

  @override
  _InterestSelectorState createState() => _InterestSelectorState();
}

class _InterestSelectorState extends State<InterestSelector> {

  void setSelected() {
    final allInterests = [
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

    selectedInterestType = [];

    for (var element in allInterests) {
      if (element.selected) {
        selectedInterestType.add(element);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Interest'),
      content: SingleChildScrollView(
        child: ListBody(
            children: [
              CheckboxListTile(
                  title: Text('Academic'),
                  value: academic.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {

                    setState(() {
                      academic.selected = newValue!;
                      // if (newValue == true) {
                      //   selectedInterestType.add(academic);
                      // } else {
                      //   selectedInterestType.remove(academic);
                      // }
                    });




                  }
              ),
              CheckboxListTile(
                  title: Text('Activism/Advocacy'),
                  value: activism.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    setState(() {
                      activism.selected = newValue!;
                      // if (newValue == true) {
                      //   selectedInterestType.add(activism);
                      // } else {
                      //   selectedInterestType.remove(activism);
                      // }
                    });
                  }
              ),
              CheckboxListTile(
                  title: Text('Arts/Media'),
                  value: arts.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    setState(() {
                      arts.selected = newValue!;
                    });

                  }
              ),
              CheckboxListTile(
                  title: Text('Business/Innovation'),
                  value: business.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    setState(() {
                      business.selected = newValue!;
                    });

                  }
              ),
              CheckboxListTile(
                  title: Text('Competition'),
                  value: competition.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {

                    setState(() {
                      competition.selected = newValue!;
                    });


                  }
              ),
              CheckboxListTile(
                  title: Text('Cultural/International'),
                  value: cultural.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {

                    setState(() {
                      cultural.selected = newValue!;
                    });

                  }
              ),
              CheckboxListTile(
                  title: Text('De-Stress/Mindfulness'),
                  value: mindfulness.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    setState(() {
                      mindfulness.selected = newValue!;
                    });
                  }
              ),
              CheckboxListTile(
                  title: Text('Faith/Religion'),
                  value: faith.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    setState(() {
                      faith.selected = newValue!;
                    });

                  }
              ),
              CheckboxListTile(
                  title: Text('Food'),
                  value: food.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    setState(() {
                      food.selected = newValue!;
                    });

                  }
              ),
              CheckboxListTile(
                  title: Text('Games/Gaming'),
                  value: games.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    setState(() {
                      games.selected = newValue!;
                    });

                  }
              ),
              CheckboxListTile(
                  title: Text('Government/Political'),
                  value: government.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    setState(() {
                      government.selected = newValue!;
                    });
                  }
              ),
              CheckboxListTile(
                  title: Text('Publications'),
                  value: publications.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    setState(() {
                      publications.selected = newValue!;
                    });
                  }
              ),
              CheckboxListTile(
                  title: Text('Recreation'),
                  value: recreation.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    setState(() {
                      recreation.selected = newValue!;
                    });

                  }
              ),
              CheckboxListTile(
                  title: Text('Service/Outreach'),
                  value: service.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    setState(() {
                      service.selected = newValue!;
                    });

                  }
              ),
              CheckboxListTile(
                  title: Text('Special Interest'),
                  value: special.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    setState(() {
                      special.selected = newValue!;
                    });

                  }
              ),
              CheckboxListTile(
                  title: Text('Spirit'),
                  value: spirit.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    setState(() {
                      spirit.selected = newValue!;
                    });

                  }
              ),
              CheckboxListTile(
                  title: Text('State/National Affiliations'),
                  value: state.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    setState(() {
                      state.selected = newValue!;
                    });

                  }
              ),
              CheckboxListTile(
                  title: Text('STEM'),
                  value: stem.selected,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    setState(() {
                      stem.selected = newValue!;
                    });

                  }
              ),



            ]
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Clear'),
          onPressed: () {
            setState(() {
              resetInterestType();
            });
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: () {

            setState(() {
              setSelected();
            });
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}


