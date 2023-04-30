// Pakai enum untuk  memudahkan kita untuk membaca kode dan menghindari kesalahan penulisan.
// Membuat sebuah enum MessageEnum untuk menyimpan tipe pesan yang akan dikirimkan
enum MessageEnum {
  text('text'),
  image('image'),
  audio('audio'),
  video('video'),
  gif('gif');

  // Constructor dari enum MessageEnum
  const MessageEnum(this.type);

  // Properti dari enum MessageEnum yang menyimpan tipe pesan
  final String type;
}

// Membuat sebuah extension untuk mengkonversi String ke enum MessageEnum
extension ConvertMessage on String {
  // Fungsi untuk mengkonversi String menjadi enum MessageEnum
  MessageEnum toEnum() {
    switch (this) {
      case 'audio':
        return MessageEnum.audio;
      case 'image':
        return MessageEnum.image;
      case 'text':
        return MessageEnum.text;
      case 'gif':
        return MessageEnum.gif;
      case 'video':
        return MessageEnum.video;
      default:
        return MessageEnum.text;
    }
  }
}
