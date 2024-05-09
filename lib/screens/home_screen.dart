import 'package:flutter/material.dart';
import 'package:paml_exe2/controllers/kuliner_controller.dart';
import 'package:paml_exe2/models/kuliner.dart';
import 'package:paml_exe2/widgets/kuliner_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final KulinerController _controller = KulinerController();

  @override
  void initState() {
    super.initState();
    _controller.getPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wisata Tempat Kuliner Saras"),
      ),
      body: FutureBuilder<List<Kuliner>>(
        future: _controller.getPeople(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Kuliner kuliner = snapshot.data![index];
                return ListTile(
                  title: Text(kuliner.nama),
                  subtitle: Text(kuliner.alamat),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(kuliner.foto),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const KulinerForm()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
