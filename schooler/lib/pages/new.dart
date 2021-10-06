import 'package:flutter/material.dart';

class New extends StatefulWidget {
  const New({Key? key}) : super(key: key);

  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<New> {
  // de form stappen
  List<Step> getSteps() => [
        Step(
          title: Text(''),
          content: Container(),
        ),
        Step(
          title: Text(''),
          content: Container(),
        ),
        Step(
          title: Text(''),
          content: Container(),
        ),
        Step(
          title: Text(''),
          content: Container(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(

              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ),
            Center(
              child: Container(
                child: Text(
                  'New Registration',
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Stepper(
                  type: StepperType.horizontal,
                  steps: getSteps(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
