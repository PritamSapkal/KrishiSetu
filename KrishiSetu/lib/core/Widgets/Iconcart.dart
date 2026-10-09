import 'package:flutter/cupertino.dart';

class Iconcart extends StatelessWidget{
  Iconcart({required this.iconsize,required this.icon,required this.color,super.key});
  final Color color;
  final IconData icon;
  final double iconsize;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon,color: color,size: iconsize,),
        ),
      ),
    );
  }
}