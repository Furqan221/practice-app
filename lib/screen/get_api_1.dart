import 'dart:convert';

import 'package:apipractice/export_all.dart';
import 'package:http/http.dart' as http;

class GetApiOneScreen extends StatefulWidget {
  const GetApiOneScreen({super.key});

  @override
  State<GetApiOneScreen> createState() => _GetApiOneScreenState();
}

class _GetApiOneScreenState extends State<GetApiOneScreen> {
  List<postModel> postList = [];

  Future<List<postModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        var map = i as Map<String, dynamic>;
        postList.add(postModel.fromJson(map));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Api Practice 1'),
      ),
      body: FutureBuilder(
          future: getPostApi(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('Loading...');
            } else {
              return ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.amber,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            postList[index].id.toString(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            postList[index].title.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            postList[index].body.toString(),
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
