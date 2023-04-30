import 'package:chatbro/common/utils/coloors.dart';
import 'package:flutter/material.dart';

class ContactStatusScreen extends StatefulWidget {
  static const String routeName = '/status-screen';
  const ContactStatusScreen({super.key});

  @override
  ContactStatusScreenState createState() => ContactStatusScreenState();
}

class ContactStatusScreenState extends State<ContactStatusScreen> {
  // Data kontak yang akan ditampilkan
  List<Map<String, dynamic>> contacts = [
    {'name': 'Ahmad', 'status': 'Hari ini 11.34', 'isOnline': true},
    {'name': 'Budi', 'status': 'Hari ini 12.24', 'isOnline': false},
    {'name': 'Toni', 'status': 'Hari ini 15.00', 'isOnline': true},
    {'name': 'Rian', 'status': 'Hari ini 17.43', 'isOnline': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Tambahkan judul "Status" menggunakan widget Text
              const Text(
                'Status',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 16.0),
              // Tambahkan daftar kontak menggunakan widget ListView.builder
              Expanded(
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // Tambahkan kode untuk berpindah ke halaman chat
                      },
                      child: ListTile(
                        // Tambahkan gambar profil menggunakan widget CircleAvatar
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              "https://picsum.photos/id/23$index/200/300"),
                        ),
                        // Tambahkan nama kontak menggunakan widget Text
                        title: Text(
                          contacts[index]['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Tambahkan status kontak dan status online/offline menggunakan widget Row dan Icon
                        subtitle: Row(
                          children: <Widget>[
                            Icon(
                              contacts[index]['isOnline']
                                  ? Icons.circle
                                  : Icons.circle_outlined,
                              size: 10.0,
                              color: contacts[index]['isOnline']
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            const SizedBox(width: 8.0),
                            Text(contacts[index]['status']),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 80.0,
            right: 10.0,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: backgroundColor,
              heroTag: "tombolTambah",
              onPressed: () {},
              tooltip: 'Tambah',
              child: const Icon(
                Icons.edit,
                color: Colors.black87,
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: FloatingActionButton(
              heroTag: "camera",
              onPressed: () {},
              tooltip: 'Camera',
              child: const Icon(
                Icons.camera_alt,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
