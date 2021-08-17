import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ImagePicker _picker = ImagePicker();

  XFile? _image;
  String _uploadStatus = "Upload não iniciado";
  String? _urlImage;

  Future recoverImage(bool fromCamera) async {
    XFile? selectedImage;
    if (fromCamera) {
      selectedImage = await _picker.pickImage(source: ImageSource.camera);
    } else {
      selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _image = selectedImage;
    });
  }

  Future uploadImage() async {
    //Referenciando a imagem
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference rootFolder = storage.ref();
    Reference file = rootFolder.child("fotos/").child("foto1.jpg");

    //Fazendo o upload da imagem para o Firebase Storage
    UploadTask task = file.putFile(File(_image!.path));

    //Monitorar o progresso do upload
    task.snapshotEvents.listen((event) {
      if (event.state == TaskState.running) {
        setState(() {
          _uploadStatus = "Em progresso";
        });
      } else if (event.state == TaskState.success) {
        setState(() {
          _uploadStatus = "Upload realizado com sucesso!";
        });
      }
    });

    //Recuperando URL da imagem após o upload
    task.then((TaskSnapshot snapshot) async {
      String url = await snapshot.ref.getDownloadURL();
      setState(() {
        _urlImage = url;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Colors.white,
          child: Text("Selecionar imagem"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(_uploadStatus),
              ElevatedButton(
                onPressed: () {
                  recoverImage(true);
                },
                child: Text("Câmera"),
              ),
              ElevatedButton(
                onPressed: () {
                  recoverImage(false);
                },
                child: Text("Galeria"),
              ),
              _image == null
                  ? Container()
                  : Image.file(
                      File(_image!.path),
                    ),
              _image == null
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {
                        uploadImage();
                      },
                      child: Text("Upload Storage"),
                    ),
              _urlImage == null ? Container() : Image.network(_urlImage!),
            ],
          ),
        ),
      ),
    );
  }
}
