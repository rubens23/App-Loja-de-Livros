import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Indicator extends StatefulWidget {




  final bool isActive;
  final int selectedIndex;
  final int indicatorPointOfPassage1;
  final int indicatorPointOfPassage2;
  final int indicatorPointOfPassage3;


  Indicator( {
    required this.isActive,
    required this.selectedIndex,
    required this.indicatorPointOfPassage1,
    required this.indicatorPointOfPassage2,
    required this.indicatorPointOfPassage3
  });




  @override
  State<StatefulWidget> createState() {
    print('selectedIndex aqui no indicator: ${this.selectedIndex}');

    return IndicatorCreatorState(isActive: isActive,
        selectedIndex: this.selectedIndex,
        indicatorPointOfPassage1: this.indicatorPointOfPassage1,
        indicatorPointOfPassage2: this.indicatorPointOfPassage2,
        indicatorPointOfPassage3: this.indicatorPointOfPassage3);

  }
}

class IndicatorCreatorState extends State<Indicator> {


  final bool isActive;
  final int selectedIndex;
  final int indicatorPointOfPassage1;
  final int indicatorPointOfPassage2;
  final int indicatorPointOfPassage3;

  IndicatorCreatorState({
    required this.isActive,
    required this.selectedIndex,
    required this.indicatorPointOfPassage1,
    required this.indicatorPointOfPassage2,
    required this.indicatorPointOfPassage3
  });



  @override
  Widget build(BuildContext context) {


    print('selectedIndex ${widget.selectedIndex} indicator1 $indicatorPointOfPassage1 indicator2 $indicatorPointOfPassage2 indicator3 $indicatorPointOfPassage3');

    if(widget.selectedIndex <= indicatorPointOfPassage1){
      return Row(
        children: [
          Container(
            width:  22.0,
            height: 8.0,
            decoration: BoxDecoration(
                color: const Color(0xFF5ABD8C),
                borderRadius: BorderRadius.circular(8.0)
            ),
          ),
          Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0)
            ),
          ),
          Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0)
            ),
          )
        ],
      );

    }else if(widget.selectedIndex <= indicatorPointOfPassage2){
      return Row(
        children: [
          Container(
            width:  8.0,
            height: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0)
            ),
          ),
          Container(
            width: 22.0,
            height: 8.0,
            decoration: BoxDecoration(
                color: const Color(0xFF5ABD8C),
                borderRadius: BorderRadius.circular(8.0)
            ),
          ),
          Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0)
            ),
          )
        ],
      );


    }else if(widget.selectedIndex <= indicatorPointOfPassage3){
      return Row(
        children: [
          Container(
            width:  8.0,
            height: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0)
            ),
          ),
          Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0)
            ),
          ),
          Container(
            width: 22.0,
            height: 8.0,
            decoration: BoxDecoration(
                color: const Color(0xFF5ABD8C),
                borderRadius: BorderRadius.circular(8.0)
            ),
          )
        ],
      );
    }else{
      return Row(
        children: [
          Container(
            width:  8.0,
            height: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0)
            ),
          ),
          Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0)
            ),
          ),
          Container(
            width: 22.0,
            height: 8.0,
            decoration: BoxDecoration(
                color: const Color(0xFF5ABD8C),
                borderRadius: BorderRadius.circular(8.0)
            ),
          )
        ],
      );


    };



  }
}