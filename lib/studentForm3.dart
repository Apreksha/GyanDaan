import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project/connection.dart';
import 'package:hackathon_project/formDetails.dart';
import 'package:hackathon_project/homePage.dart';
import 'package:hackathon_project/loading.dart';
import 'dart:ui';

import 'package:toast/toast.dart';


class studentForm3 extends StatefulWidget {
  @override
  _studentForm3State createState() => _studentForm3State();
}

List<bool> _checked = List<bool>(8);

class _studentForm3State extends State<studentForm3>
    with SingleTickerProviderStateMixin,FormDetails,Connection{
  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _animation2;

  @override
  void initState() {
    super.initState();
    for(int i=0;i<8;i++){
      _checked[i]=true;
    }
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: -30, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.dispose();
    super.dispose();
  }
  String timz;
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: _w/10,right: _w/50),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Opacity(
    opacity: _animation.value,
    child: Transform.translate(
    offset:Offset(0, _animation2.value) ,
    child: GestureDetector(
    onTap: (){
      Details({},[], context,"list","",[]);
    Navigator.pop(context);
    },
    child: Container(
    width: 100,
    height: 50,
    decoration: BoxDecoration(
    boxShadow: [
    BoxShadow(
    color: Colors.black.withOpacity(0.5),
    blurRadius: 20,
    offset: Offset(5, 10),
    ),
    ],
    color: Colors.indigo,
    borderRadius: BorderRadius.all(Radius.circular(20))
    ),
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

    Icon(Icons.arrow_back,color: Colors.white,size: 20,),
    SizedBox(width: 10,),
    Text("Prev",style: TextStyle(
    color: Colors.white,
    ),),
    ],
    ),
    ),
    ),
    ),
    ),
    ),
    Opacity(
    opacity: _animation.value,
    child: Transform.translate(
    offset:Offset(0, _animation2.value) ,
    child: GestureDetector(
    onTap: (){
      if(_checked.contains(false) && timz!=null){
        fun(context);
        }else{
        Toast.show('Set day and time',context,gravity: Toast.TOP,duration: Toast.LENGTH_SHORT);
      }
    },
    child: Container(
    width: 100,
    height: 50,
    decoration: BoxDecoration(
    boxShadow: [
    BoxShadow(
    color: Colors.black.withOpacity(0.5),
    blurRadius: 20,
    offset: Offset(5, 10),
    ),
    ],
    color: Colors.indigo,
    borderRadius: BorderRadius.all(Radius.circular(20))
    ),
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text("Finish",style: TextStyle(
    color: Colors.white,
    ),),
    ],
    ),
    ),
    ),
    ),
    ),
    ),
    ],
    ),
      ),

        backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// ListView
          ListView(
            physics:
            BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(_w / 17, _w / 20, 0, _w / 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'STUDENT FORM',
                      style: TextStyle(
                        fontSize: 27,
                        color: Colors.black.withOpacity(.6),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: _w / 35),
                    Text(
                      'Choose Your Day and Time',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: _w/5,
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 20,
                      children: [
                        DayFinder(0,'Everyday',Color(0xfff37736)),
                        DayFinder(1,'Monday',Colors.lightGreen),
                        DayFinder(2,'Tuesday',Color(0xff63ace5)),
                        DayFinder(3,'Wednesday',Color(0xffFF6D6D)),
                        DayFinder(4,'Thursday',Color(0xffffa700)),
                        DayFinder(5,'Friday',Color(0xfff37736)),
                        DayFinder(6,'Saturday',Colors.lightGreen),
                        DayFinder(7,'Sunday',Color(0xff63ace5)),
                      ],
                    ),
                    SizedBox(
                      height: _w/5,
                    ),
                    timeFun(context)
                  ],
                ),
              ),

            ],
          ),
          // Blur the Status bar
          blurTheStatusBar(context),
        ],
      ),
    );
  }

  Widget blurTheStatusBar(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
        child: Container(
          height: _w / 18,
          color: Colors.transparent,
        ),
      ),
    );
  }
  TimeOfDay time = const TimeOfDay(hour: 12, minute: 12);
  Widget timeFun(BuildContext context){
    double _w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async{
        TimeOfDay newTime = await showTimePicker(context: context, initialTime: time);
        if(newTime != null){
          setState(() {
            time = newTime;
            timz = time.toString();
            Details({},[], context,time.toString(), "",[]);
          });
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.watch_later_outlined,size: _w/8),
          SizedBox(width: _w/10,),
          Text('${time.hour.toString()}:${time.minute.toString()}',
          style: const TextStyle(fontSize: 60),),
        ],
      ),
    );
  }

  Widget DayFinder(int i,String string, Color color){
    return GestureDetector(
      onTap: (){
        setState(() {
          if(i!=0){
            _checked[i] =!_checked[i];
          }
          else if(_checked[0]){
            _checked[0] =false;
            _checked[1] =false;
            _checked[2] =false;
            _checked[3] =false;
            _checked[4] =false;
            _checked[5] =false;
            _checked[6] =false;
            _checked[7] =false;
          }else{
            _checked[0] =true;
            _checked[1] =true;
            _checked[2] =true;
            _checked[3] =true;
            _checked[4] =true;
            _checked[5] =true;
            _checked[6] =true;
            _checked[7] =true;
          }
          if(_checked[0]==false && i>0){
            _checked[0]=true;
          }
          Details({ }, [], context, "days", " ", _checked);
        });
      },
      child: AnimatedContainer(
        height: 50,
        width: 100,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(!_checked[i] ? 0.2 : 0.0),
              blurRadius: 20,
              offset: Offset(5, 10),
            ),
          ],
          color: _checked[i]
              ? color
              : Colors.grey.withOpacity(0.8),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Center(
          child: Text(string,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15,
              color: _checked[i]
              ? Colors.black.withOpacity(0.7)
        : Colors.black.withOpacity(0.5),)),
        )
      ),
    );
  }
}
