import 'dart:convert';

import 'package:apipractice/export_all.dart';
import 'package:http/http.dart' as http;


// This is the example of getting simple json data form unnamed 
//array using modal (with custom selection)in UI list    

class GetApiTwoScreen extends StatefulWidget {
  const GetApiTwoScreen({super.key});

  @override
  State<GetApiTwoScreen> createState() => _GetApiTwoScreenState();
}

class _GetApiTwoScreenState extends State<GetApiTwoScreen> {
  List<Photos> photoList = [];
  Future<List<Photos>> getPhotoApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos =
            Photos(title: i['title'], id: i['id'].toString(), url: i['url']);
        photoList.add(photos);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Api Practice 2'),
      ),
      body: FutureBuilder(
          future: getPhotoApi(),
          builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                
                child: Text('Loading ...'),
              );
            } else {
              return ListView.builder(
                  itemCount: photoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data![index].url.toString()),
                      ),
                      title: Text(snapshot.data![index].title.toString()),
                      trailing: Text(snapshot.data![index].id.toString()),
                    );
                  });
            }
          }),
    );
  }
}

class Photos {
  String id, title, url;
  Photos({required this.title, required this.id, required this.url});
}
