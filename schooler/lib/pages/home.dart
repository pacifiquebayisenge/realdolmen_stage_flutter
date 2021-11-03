import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:schooler/classes/registration.dart';
import 'package:schooler/widgets/widgets.dart';
import 'package:schooler/services/globals.dart' as globals;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Registration.getRegiList(),
        builder: (context, snapshot) {

        if(snapshot.connectionState == ConnectionState.none) {
          return Center(child: Text('Something went wrong'),);
        }

        if(snapshot.connectionState == ConnectionState.active) {
          return Center(child: Text('Something is  active'),);
        }

        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Something is  waiting'),);
        }

        if(snapshot.connectionState == ConnectionState.done) {
          if(!snapshot.hasData)
            {return Center(child: Text('Something is  ${snapshot.data}'),);}
          else {
            return  Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DelayedDisplay(
                    delay: Duration(milliseconds: 500),
                    child: Image(
                      image: AssetImage('lib/images/empty_space.gif'),
                      width: 250,
                    ),
                  ),
                  DelayedDisplay(
                    delay: Duration(milliseconds: 900),
                    child: Text('No registrations yet'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DelayedDisplay(
                    delay: Duration(milliseconds: 900),
                    child: Text('Create a new registration here'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DelayedDisplay(
                    delay: Duration(milliseconds: 900),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child:  ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Colors.indigo.shade800,
                          shape: StadiumBorder(),
                        ),


                        onPressed: () {
                          Navigator.pushNamed(context, 'new');
                        },
                        child: Icon(Icons.add_circle),

                      ),
                    ),
                  )
                ],
              ),
            );
          }
        }



        return Center(child: Text('Something went wrong'),);
        });



  }
}
/*
*
* Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DelayedDisplay(
            delay: Duration(milliseconds: 500),
            child: Image(
              image: AssetImage('lib/images/empty_space.gif'),
              width: 250,
            ),
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: 900),
            child: Text('No registrations yet'),
          ),
          SizedBox(
            height: 10,
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: 900),
            child: Text('Create a new registration here'),
          ),
          SizedBox(
            height: 10,
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: 900),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child:  ElevatedButton(

                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.indigo.shade800,
                  shape: StadiumBorder(),
                ),


                onPressed: () {
                  Navigator.pushNamed(context, 'new');
                },
                child: Icon(Icons.add_circle),

              ),
            ),
          )
        ],
      ),
    );
*
* */