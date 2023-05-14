# No 1

Mampu mendemonstrasikan penyelesaian masalah dengan pendekatan matematika dan algoritma pemrograman secara tepat (Lampirkan link source code terkait)

Jawab:

Ada beberapa pendekatan matematika dan algoritma yang project ini pakai, salah satunya:

-Pendekatan matematika method untuk memformat tanggal pesan dikirim atau diterima.

- Method ini menerima data chatContactData sebagai parameter.
- Kemudian, ia menghitung selisih antara waktu pengiriman pesan terakhir dengan waktu saat ini dalam satuan hari menggunakan fungsi "difference" pada objek DateTime.
- Jika selisih ini adalah 0, artinya pesan terakhir dikirim hari ini, maka method akan memformat waktu pengiriman pesan terakhir menggunakan DateFormat.Hm() dan menyimpan hasilnya dalam variabel formattedDate.
- Jika selisih ini adalah 1, artinya pesan terakhir dikirim kemarin, maka method akan menyimpan string "Kemarin" dalam variabel formattedDate.
- Jika selisih ini lebih besar dari 1, artinya pesan terakhir dikirim lebih dari 1 hari yang lalu, maka method akan memformat waktu pengiriman pesan terakhir menggunakan DateFormat('dd/MM/yyyy') dan menyimpan hasilnya dalam variabel formattedDate.
- Akhirnya, method mengembalikan nilai formattedDate sebagai output.

```dart
// Method ini menerima data chatContactData sebagai parameter.
  String getLastMessageFormattedDate(ChatContact chatContactData) {
    // mengurutkan waktu pesan terkahir
    String formattedDate = '';
    if (chatContactData.timeSent.difference(DateTime.now()).inDays == 0) {
      formattedDate = DateFormat.Hm().format(chatContactData.timeSent);
    } else if (chatContactData.timeSent
            .difference(DateTime.now().subtract(const Duration(days: 1)))
            .inDays ==
        0) {
      formattedDate = 'Kemarin';
    } else {
      formattedDate = DateFormat('dd/MM/yyyy').format(chatContactData.timeSent);
    }
    return formattedDate;
  }
```

Sedangkan untuk contoh algoritma pemrograman yang digunakan project ini adalah algoritma pengurutan pesan

- dimana pesan terbaru akan diurutkan paling atas dalam home chat screen, menggunakan fungsi bawaan sorting dart
- Fungsi sort((a, b) => b.timeSent.compareTo(a.timeSent)) menggunakan algoritma pengurutan (sorting algorithm) yang disebut dengan Merge Sort atau Mergesort.
-

```dart
// urutkan list berdasarkan waktu terkirim, pesan terbaru di atas
List<Message> sortMessagesByTimeSent(List<Message> messages) {
  return messages
      .sort((a, b) => b.timeSent.compareTo(a.timeSent));
}
```

# No 2

Mampu menjelaskan algoritma dari solusi yang dibuat (Lampirkan link source code terkait)

Jawab:

- [Pengimplementasian dari algoritma chat](https://gitlab.com/fikiaprian23/TA_OOP/-/blob/master/lib/features/chat/repositories/chat_repository.dart)

# No 3

Mampu menjelaskan konsep dasar OOP

Jawab:

- Abstraction: Memperlihatkan fungsi utama dari Class yang dibutuhkan oleh publik dan menyembunyikan detail pelaksanaannya.
- Encapsulation: membatasi akses langsung ke data atau metod di dalam kelas dan mengatur akses tersebut.
- Inheritance: penurunan sikap dan perilaku dari Orang Tua (Parent / Superclass) ke Anaknya (Child / Subclass).
- Polymorphism :Subclass dapat memiliki implementasi method yang berbeda dari Superclass nya (banyak bentuk).

# No 4

Mampu mendemonstrasikan penggunaan Encapsulation secara tepat (Lampirkan link source code terkait)

Jawab:

Encapsulation membatasi akses langsung ke data atau metode di dalam kelas dan mengatur akses tersebut.

- pada Dart akses modifier terdapat 2 yaitu publik dan private
- Private ditandai dengan (\_) pada atribut atau methodnya. contoh dalam program saya
- **\_saveDataToContactsSubcollection**
- **\_saveMessageToMessageSubcollection**

```dart
// fungsi untuk mengirim pesan text
  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required UserModel senderUser,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel? recieverUserData;

      if (!isGroupChat) {
        var userDataMap =
            await firestore.collection('users').doc(recieverUserId).get();
        recieverUserData = UserModel.fromMap(userDataMap.data()!);
      }

      var messageId = const Uuid().v1();

      _saveDataToContactsSubcollection(
        senderUser,
        recieverUserData,
        text,
        timeSent,
        recieverUserId,
        isGroupChat,
      );

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        text: text,
        timeSent: timeSent,
        messageType: MessageEnum.text,
        messageId: messageId,
        username: senderUser.name,
        messageReply: messageReply,
        recieverUserName: recieverUserData?.name,
        senderUsername: senderUser.name,
        isGroupChat: isGroupChat,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
```

# No 5

Mampu mendemonstrasikan penggunaan Abstraction secara tepat (Lampirkan link source code terkait)

Jawab:

Abstraction: Memperlihatkan fungsi utama dari Class yang dibutuhkan oleh publik dan menyembunyikan detail pelaksanaannya.

- [Abstraction Auth](https://gitlab.com/fikiaprian23/TA_OOP/-/blob/master/lib/features/auth/abstraction/abstract.dart)
- [Abstraction Call](https://gitlab.com/fikiaprian23/TA_OOP/-/blob/master/lib/features/call/abstraction/abstrct_call.dart)
- [Abstraction Chat](https://gitlab.com/fikiaprian23/TA_OOP/-/blob/master/lib/features/chat/abstraction/abstract_chat.dart)
- [Abstraction Group](https://gitlab.com/fikiaprian23/TA_OOP/-/blob/master/lib/features/group/abstraction/abstract_group.dart)
- [Abstraction Contacts](https://gitlab.com/fikiaprian23/TA_OOP/-/blob/master/lib/features/select_contacts/abstraction/abstract_contacts.dart)
- [Abstraction Status](https://gitlab.com/fikiaprian23/TA_OOP/-/blob/master/lib/features/status/abstraction/abstract_status.dart)

# No 6

Mampu mendemonstrasikan penggunaan Inheritance dan Polymorphism secara tepat (Lampirkan link source code terkait)

Jawab:

- Inheritance adalah konsep dimana sebuah class dapat mewarisi properti dan method yang ada pada class lainnya. Pada codingan tersebut, **LoginScreen** dijadikan child class dari **ConsumerStatefulWidget**, sehingga LoginScreen dapat menggunakan semua properti dan method yang ada pada ConsumerStatefulWidget, termasuk juga memodifikasi dan menambahkannya.
- Polymorphism adalah konsep dimana sebuah class dapat berubah bentuk atau tampilan sesuai dengan implementasinya. Dalam codingan tersebut, **\_LoginScreenState** merupakan child class dari **ConsumerState<LoginScreen>**, dimana \_LoginScreenState mengimplementasikan **build method** dengan memodifikasi tampilan dari LoginScreen. Dalam method build, terdapat implementasi dari Loader Widget ketika isLoading bernilai true, dan juga terdapat implementasi dari tampilan Scaffold ketika isLoading bernilai false.

```dart
 // extends--> inheritance
class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  //override => Polymorphism
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;
  bool isLoading = false;

  //override => Polymorphism
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

// fungsi untuk memilih negara menggunakan plugin country_picker_flutter
  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

// fungsi untuk mengirim nomor telepon pengguna yang telah dimasukkan
  sendPhoneNumber() async {
    // trim untuk menghapus spasi awal dan akhir string
    String phoneNumber = phoneController.text.trim();

    if (country != null && phoneNumber.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await ref.read(authControllerProvider).signInWithPhone(
            context,
            '+${country!.phoneCode}$phoneNumber',
          );

      setState(() {
        isLoading = false;
      });
    } else {
      showAlertDialog(context: context, message: 'Fill out all the fields');
    }
  }

  //override => Polymorphism
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (isLoading) return const Loader();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        elevation: 0,
        backgroundColor: greenButton,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('WhatsApp will need to verify your phone number.'),
              const SizedBox(height: 10),
              TextButton(
                onPressed: pickCountry,
                child: const Text('Pick Country'),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  if (country != null) Text('+${country!.phoneCode}'),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'phone number',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.5),
              SizedBox(
                width: 90,
                child: CustomButton(
                  onPressed: sendPhoneNumber,
                  text: 'NEXT',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```

# No 7

Mampu menjelaskan rancangan dalam bentuk Class Diagram, dan Use Case table (Lampirkan diagram terkait)

Jawab:

**USE CASE DIAGRAM**

```plantuml

@startuml
left to right direction

actor User

rectangle Aplikasi_WhatsApp {
  usecase Registrasi
  usecase Lihat_Kontak
  usecase Mengirim_Pesan_Teks
  usecase Mengirim_Pesan_Suara
  usecase Mengirim_Pesan_Video
  usecase Panggilan_Suara
  usecase Panggilan_Video
  usecase Menerima_Pesan
  usecase Membuat_Grup
  usecase Mengirim_Pesan_di_Grup

  User --> Registrasi
  User --> Lihat_Kontak
  User --> Mengirim_Pesan_Teks
  User --> Mengirim_Pesan_Suara
  User --> Mengirim_Pesan_Video
  User --> Panggilan_Suara
  User --> Panggilan_Video
  User --> Menerima_Pesan
  User --> Membuat_Grup
  User --> Mengirim_Pesan_di_Grup
}
@enduml

```

**USE CASE PRIORITY**
| Use Case | Priority | Status |
|------------------------------|----------|--------|
| Registrasi | Tinggi | Selesai
| Liat kontak | Tinggi | Selesai |
| Mengirim Pesan Teks | Tinggi | Selesai |
| Mengirim Pesan Suara | Tinggi | Selesai |
| Mengirim Pesan Video | Tinggi | Selesai |
| Menerima Pesan | Tinggi | Selesai |
| Menyimpan Pesan | Tinggi | Selesai |
| Membuat Grup | Tinggi | Selesai
| Mengirim Pesan di Grup | Tinggi | Selesai |
| Panggilan Suara | Tinggi | **Belum** |
| Panggilan Video | Tinggi | **Ongoing** |
| Mengirim Berkas | Tinggi | **Belum** |
| Menyimpan Riwayat Panggilan | Sedang | **Baru UI** |
| Mengatur Notifikasi | Sedang | **Belum** |
| Buat Status Teman | Sedang | **Baru Ui** |
| Melihat Status Teman | Sedang | **Baru Ui** |
| Liat Profil teman | Sedang | Selesai |
| Ubah profile | Sedang | **Belum** |

**CLASS DIAGRAM**

```plantuml

@startuml

class User {
    - name: string
    - phone_number: string
    - profile_picture: string
    - auth_status: boolean
    + get_name(): string
    + set_name(name: string): void
    + get_phone_number(): string
    + set_phone_number(phone_number: string): void
    + get_profile_picture(): string
    + set_profile_picture(profile_picture: string): void
    + is_auth(): boolean
    + set_auth(auth_status: boolean): void
    + authenticate(phone_number: string, otp: string): boolean
    + generate_otp(): string
}

class Contact {
    - name: string
    - phone_number: string
    - profile_picture: string
    + get_name(): string
    + set_name(name: string): void
    + get_phone_number(): string
    + set_phone_number(phone_number: string): void
    + get_profile_picture(): string
    + set_profile_picture(profile_picture: string): void
}

class Group {
    - name: string
    - participants: list<Contact>
    + get_name(): string
    + set_name(name: string): void
    + add_participant(participant: Contact): void
    + remove_participant(participant: Contact): void
    + get_participants(): list<Contact>
}

class Message {
    - sender: User
    - receiver: Contact
    - content: string
    - timestamp: datetime
    + get_sender(): User
    + set_sender(sender: User): void
    + get_receiver(): Contact
    + set_receiver(receiver: Contact): void
    + get_content(): string
    + set_content(content: string): void
    + get_timestamp(): datetime
    + set_timestamp(timestamp: datetime): void
}

class Call {
    - caller: User
    - receiver: Contact
    - type: string
    - timestamp: datetime
    + get_caller(): User
    + set_caller(caller: User): void
    + get_receiver(): Contact
    + set_receiver(receiver: Contact): void
    + get_type(): string
    + set_type(type: string): void
    + get_timestamp(): datetime
    + set_timestamp(timestamp: datetime): void
}

class Notification {
    - title: string
    - message: string
    - timestamp: datetime
    + get_title(): string
    + set_title(title: string): void
    + get_message(): string
    + set_message(message: string): void
    + get_timestamp(): datetime
    + set_timestamp(timestamp: datetime): void
}

class Status {
    - creator: User
    - content: string
    - timestamp: datetime
    + get_creator(): User
    + set_creator(creator: User): void
    + get_content(): string
    + set_content(content: string): void
    + get_timestamp(): datetime
    + set_timestamp(timestamp: datetime): void
}

class Chat {
    -id: int
    -sender_id: int
    -receiver_id: int
    -message: string
    -timestamp: datetime
    +get_id(): int
    +get_sender_id(): int
    +get_receiver_id(): int
    +get_message(): string
    +get_timestamp(): datetime
}

User "1" -- "many" Contact
User "1" -- "many" Group
Contact "1" -- "many" Group
User "1" -- "many" Message
Contact "1" -- "many" Message
User "1" -- "many" Call
Contact "1" -- "many" Call
User "1" -- "many" Notification
Contact "1" -- "many" Notification
User "1" -- "many" Status
User "1" o-- "many" Chat

User --> AuthController

class AuthController {
    + request_otp
    + authenticate(phone_number: string, otp: string): boolean
}

AuthController --> SMSProvider

class SMSProvider {
    + send_otp(phone_number: string, otp: string): boolean
}

@enduml


```

# No 8

Mampu menerjemahkan proses bisnis ke dalam skema OOP secara tepat. Bagaimana cara Kamu mendeskripsikan proses bisnis (kumpulan use case) ke dalam OOP ?

Jawab:

- Pertama-tama saya membuat use case scenarionya, agar mendapat gambaran skema dan proses bisnis yang akan saya buat.
- Identifikasi aktor-aktor yang terlibat dalam proses bisnis, seperti pengguna, sistem, dan sebagainya.
- Identifikasi use case-use case yang terkait dengan proses bisnis, seperti registrasi, mengirim pesan, menerima pesan, dan sebagainya.
- Identifikasi objek-objek yang terlibat dalam proses bisnis, seperti pesan, grup, kontak, dan sebagainya.
- Membuat kelas-kelas(Class Diagram digunakan untuk pemodelan OOP) yang merepresentasikan aktor, use case, dan objek yang telah diidentifikasi dalam proses bisnis.
- Hubungkan kelas-kelas tersebut dengan relasi objek-objek, seperti kelas pesan yang memiliki hubungan dengan kelas kontak dan kelas grup.
- Implementasikan method-method yang dibutuhkan dalam setiap kelas, seperti method untuk mengirim pesan, menerima pesan, membuat grup, dan sebagainya.
- Uji coba model OOP yang telah dibuat untuk memastikan konsistensi dan fungsionalitasnya.

**DFD**

```plantuml
@startuml
actor User

User -> WhatsApp: Buka Aplikasi

WhatsApp -> WhatsApp: Tampilkan Daftar Kontak

User -> WhatsApp: Pilih Kontak

WhatsApp -> WhatsApp: Tampilkan Layar Pesan

User -> WhatsApp: Ketik Pesan

User -> WhatsApp: Tekan Tombol Kirim

WhatsApp -> Server: Kirim Pesan Teks

Server -> Server: Validasi Pesan Teks

Server -> Server: Simpan Pesan ke Database

Server -> Penerima: Kirim Notifikasi Pesan Baru

Penerima -> WhatsApp: Terima Notifikasi Pesan Baru

WhatsApp -> WhatsApp: Tampilkan Pesan Baru
@enduml
```

```md
Berikut adalah beberapa contoh skenario use case untuk aplikasi WhatsApp:

### Skenario 1: Mengirim pesan teks

**Aktor**: Pengguna

**Tujuan**: Mengirim pesan teks ke kontak yang dipilih

**Deskripsi**: Pengguna ingin mengirim pesan teks ke kontak yang dipilih melalui WhatsApp.

**Langkah-langkah**:

1. Pengguna membuka WhatsApp.
2. Pengguna memilih kontak yang ingin dikirimi pesan teks.
3. Pengguna mengetik pesan teks yang ingin dikirim.
4. Pengguna mengirimkan pesan teks tersebut.
5. WhatsApp menampilkan pesan teks tersebut pada layar pengguna dan pada penerima pesan.

### Skenario 2: Menerima pesan

**Aktor**: Pengguna

**Tujuan**: Menerima pesan dari pengguna lain

**Deskripsi**: Pengguna ingin menerima pesan yang dikirim oleh pengguna lain melalui WhatsApp.

**Langkah-langkah**:

1. Pengguna membuka WhatsApp.
2. WhatsApp menampilkan pesan yang diterima oleh pengguna pada layar.
3. Pengguna membaca pesan tersebut.

### Skenario 3: Membuat grup

**Aktor**: Pengguna

**Tujuan**: Membuat grup chat dengan beberapa kontak

**Deskripsi**: Pengguna ingin membuat grup chat dengan beberapa kontak untuk mempermudah komunikasi dalam kelompok.

**Langkah-langkah**:

1. Pengguna membuka WhatsApp.
2. Pengguna memilih opsi membuat grup.
3. Pengguna memberikan nama grup yang ingin dibuat.
4. Pengguna memilih kontak yang ingin dijadikan anggota grup.
5. Pengguna mengonfirmasi pembuatan grup.
6. WhatsApp menampilkan grup yang baru saja dibuat pada layar pengguna.

### Skenario 4: Mengirim pesan di grup

**Aktor**: Pengguna

**Tujuan**: Mengirim pesan di grup yang sudah dibuat

**Deskripsi**: Pengguna ingin mengirim pesan di grup yang sudah dibuat untuk berkomunikasi dengan anggota grup lainnya.

**Langkah-langkah**:

1. Pengguna membuka WhatsApp.
2. Pengguna memilih grup yang ingin dikirimi pesan.
3. Pengguna mengetik pesan yang ingin dikirim.
4. Pengguna mengirimkan pesan tersebut.
5. WhatsApp menampilkan pesan tersebut pada layar pengguna dan pada anggota grup lainnya.

### Skenario 5: Melihat profil teman

**Aktor**: Pengguna

**Tujuan**: Melihat profil teman yang ada dalam daftar kontak

**Deskripsi**: Pengguna ingin melihat profil teman yang ada dalam daftar kontak, seperti nama, foto profil, status, dan informasi lainnya.

**Langkah-langkah**:

1. Pengguna membuka WhatsApp.
2. Pengguna memilih kontak teman yang ingin dilihat profilnya.
3. WhatsApp menampilkan profil teman yang dipilih pada layar pengguna.

### Skenario 6: Panggilan suara

**Aktor**: Pengguna

**Tujuan**: Melakukan panggilan suara dengan kontak yang dipilih

**Deskripsi**: Pengguna ingin melakukan panggilan suara dengan kontak yang dipilih melalui WhatsApp.

**Langkah-langkah**:

1. Pengguna membuka WhatsApp.
2. Pengguna memilih kontak yang ingin dihubungi melalui panggilan suara.
3. Pengguna memilih opsi panggilan suara.
4. WhatsApp menghubungkan pengguna dengan kontak yang dipilih untuk melakukan panggilan suara.
5. Pengguna dan kontak yang dipilih dapat berbicara melalui panggilan suara.

### Skenario 7: Panggilan video

**Aktor**: Pengguna

**Tujuan**: Melakukan panggilan video dengan kontak yang dipilih

**Deskripsi**: Pengguna ingin melakukan panggilan video dengan kontak yang dipilih melalui WhatsApp.

**Langkah-langkah**:

1. Pengguna membuka WhatsApp.
2. Pengguna memilih kontak yang ingin dihubungi melalui panggilan video.
3. Pengguna memilih opsi panggilan video.
4. WhatsApp menghubungkan pengguna dengan kontak yang dipilih untuk melakukan panggilan video.
5. Pengguna dan kontak yang dipilih dapat berbicara dan melihat satu sama lain melalui panggilan video.
```

# No 9

Mampu memberikan gambaran umum aplikasi kepada publik menggunakan presentasi berbasis video (Lampirkan link Youtube terkait)

Jawab:

**Video Demo Project**

![](Screenshot_Aplikasi/DemoWA.mp4)

**[Link Youtube](https://youtu.be/XR-BveZi0fU)**

# No 10

Inovasi UX (Lampirkan url screenshot aplikasi di Gitlab / Github)

Jawab:

- **Landing page**

<img src="Screenshot_Aplikasi/landing_page.png" alt="alt text" width="300">

- **Register**

<img src="Screenshot_Aplikasi/Register.png" alt="alt text" width="300">

- **OTP**

<img src="Screenshot_Aplikasi/Otp.png" alt="alt text" width="300">

- **Grup**

<img src="Screenshot_Aplikasi/grup.png" alt="alt text" width="300">

- **User Chat**

<img src="Screenshot_Aplikasi/user_chatlist.png" alt="alt text" width="300">

- **History call**

<img src="Screenshot_Aplikasi/history.png" alt="alt text" width="300">

- **Status**

<img src="Screenshot_Aplikasi/status.png" alt="alt text" width="300">

- **Select Contact**

<img src="Screenshot_Aplikasi/select_contact.png" alt="alt text" width="300">

- **Chat Grup**

<img src="Screenshot_Aplikasi/chat_grup.png" alt="alt text" width="300">

- **Chat Personal**

<img src="Screenshot_Aplikasi/chat_personal.png" alt="alt text" width="300">

- **Profile teman**

<img src="Screenshot_Aplikasi/profile_friend.png" alt="alt text" width="300">
