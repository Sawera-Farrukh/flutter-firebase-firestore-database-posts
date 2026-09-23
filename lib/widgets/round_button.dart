import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool loading;
  const RoundButton({Key? key , 
  required this.title, 
  this.loading = false,
  this.onTap
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(child: loading ? CircularProgressIndicator(color: Colors.white,):
      Text(title, style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),)
      ),
    ),
    );
  }
}