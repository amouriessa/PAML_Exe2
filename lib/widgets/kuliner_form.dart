import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paml_exe2/controllers/kuliner_controller.dart';
import 'package:paml_exe2/models/kuliner.dart';
import 'package:paml_exe2/screens/home_screen.dart';
import 'package:paml_exe2/screens/map_screen.dart';

class KulinerForm extends StatefulWidget {
  const KulinerForm({super.key});

  @override
  State<KulinerForm> createState() => _KulinerFormState();
}

class _KulinerFormState extends State<KulinerForm> {
  final formkey = GlobalKey<FormState>();
  final kulinerController = KulinerController();
  final _namaController = TextEditingController();
  // final _alamatController = TextEditingController();

  File? _image;
  final _imagePicker = ImagePicker();
  String? _alamat;

  Future<void> getImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kuliner Form")),
      body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Nama Tempat Kuliner",
                        hintText: "Masukkan nama tempat kuliner"),
                    controller: _namaController,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Alamat"),
                      _alamat == null
                          ? const SizedBox(
                              width: double.infinity,
                              child: Text('Alamat kosong'))
                          : Text('$_alamat'),
                      _alamat == null
                          ? TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapScreen(
                                        onLocationSelected: (selectedAddress) {
                                      setState(() {
                                        _alamat = selectedAddress;
                                      });
                                    }),
                                  ),
                                );
                              },
                              child: const Text('Pilih Alamat'),
                            )
                          : TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapScreen(
                                        onLocationSelected: (selectedAddress) {
                                      setState(() {
                                        _alamat = selectedAddress;
                                      });
                                    }),
                                  ),
                                );
                                setState(() {});
                              },
                              child: const Text('Ubah Alamat'),
                            ),
                    ],
                  ),
                ),
                _image == null
                    ? const Text('Tidak ada gambar yang dipilih')
                    : Image.file(_image!),
                ElevatedButton(
                  onPressed: getImage,
                  child: const Text("Pilih gambar"),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          formkey.currentState!.save();
                          var result = await kulinerController.addPerson(
                              Kuliner(
                                  nama: _namaController.text,
                                  alamat: _alamat ?? '',
                                  foto: _image!.path),
                              _image);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result['message'])),
                          );

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                              (route) => false);
                        }
                      },
                      child: const Text("Submit")),
                )
              ],
            ),
          )),
    );
  }
}
