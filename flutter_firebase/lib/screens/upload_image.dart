import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  bool loading = false;

  Future<void> uploadImage(String inputSource) async{
    final picker = ImagePicker();
    final XFile? pickImage = await picker.pickImage(source: inputSource == 'camera'? ImageSource.camera: ImageSource.gallery);

    if(pickImage == null) {
      return null;
    }
    String fileName = pickImage.name;
    File imageFile = File(pickImage.path);
    print(imageFile);
    File compressedFile = await compressImage(imageFile);
    print(compressedFile);
    // try{
    //   setState(() {
    //     loading = true;
    //   });
    //   await firebaseStorage.ref(fileName).putFile(compressedFile);
    //   setState(() {
    //     loading = false;
    //   });
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Uploaded",)));
    // }on FirebaseException catch(e){
    //   print(e);
    // }
    // catch(error){
    //   print(error);
    // }
  }

  //Retrieve all uploaded image
  Future<List> loadImages() async{
    List<Map> files = [];
    final ListResult result = await firebaseStorage.ref().listAll();
    final List<Reference> allFiles = result.items;
    await Future.forEach(allFiles, (Reference file)async{
      final String fileUrl = await file.getDownloadURL();
      files.add({
        "url" : fileUrl,
        "path" : file.fullPath
      });
    });
    return files;
  }

  Future<void> delete(String ref) async{
    await firebaseStorage.ref(ref).delete();
    setState(() {

    });
  }

  Future<File> compressImage(File file) async {
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
        quality: 50);
    print(file);
    print(compressedFile);
    print("Original Size:");
    print(file.lengthSync());
    print("Compressed Size");
    print(compressedFile.lengthSync());

    return compressedFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload to Firebase Storage'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            loading? Center(child: CircularProgressIndicator(),):Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(onPressed: (){
                  uploadImage("camera");
                },
                icon: Icon(Icons.camera),label: Text("Camera"),),
                ElevatedButton.icon(onPressed: (){
                  uploadImage("gallery");
                },
                  icon: Icon(Icons.library_add),label: Text("Gallery"),),
              ],
            ),
            SizedBox(height: 50),
            Expanded(child: FutureBuilder(
              future: loadImages(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data.length ?? 0,
                    itemBuilder: (context, index){
                      final Map image = snapshot.data[index];
                      return Row(
                        children: [
                          Expanded(child: Card(
                            child: Container(
                              height: 200,
                              child: Image.network(image['url']),
                            ),
                          )),
                          IconButton(onPressed: () async{
                            await delete(image['path']);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image Deleted Successfully!")));
                          },
                              icon: Icon(Icons.delete,color: Colors.red,))
                        ],
                      );
                    });
              }
            ))
          ],
        ),
      ),
    );
  }
}
