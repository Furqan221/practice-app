import 'package:apipractice/export_all.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Examples'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          ButtonWidget1(
              text: 'Get Api 1',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GetApiOneScreen()))),
          ButtonWidget1(
              text: 'Get Api 2',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GetApiTwoScreen()))),
          ButtonWidget1(
              text: 'Get Api 3',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GetApiThreeScreen()))),
          ButtonWidget1(
              text: 'Post Api 1',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PostApiOneScreen()))),
          ButtonWidget1(
              text: 'Post Api 2',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PostApiTwoScreen()))),
        ],
      ),
    );
  }
}

class ButtonWidget1 extends StatelessWidget {
  VoidCallback? onTap;
  final String? text;
  final Color? color;

  ButtonWidget1({super.key, this.onTap, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        // width: 388,
        height: 58,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: color ?? Colors.blue,
            borderRadius: BorderRadius.circular(7)),
        child: Text(
          text ?? 'Button Text',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
