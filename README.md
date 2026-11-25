# MyPortfolio Mobile

## Tautan Backend & API
- **Repositori Backend Django:** https://github.com/ghaisannabil-n/myportofolio
- **URL API Deployed:** http://localhost:8000

## Endpoint yang Diintegrasikan

`GET` `/api/v1/projects/` Publik Mengambil daftar proyek 
`POST` `/api/v1/projects/` `Authorization: Token <key>` Menambah proyek baru 
`GET` `/api/v1/experiences/` Publik Mengambil daftar pengalaman 
`POST` `/api/v1/experiences/` `Authorization: Token <key>` Menambah pengalaman baru 
`POST` `/api/v1/auth/token/` Publik Login dan mendapatkan token DRF 
`POST` `/api/v1/auth/logout/` `Authorization: Token <key>` Mencabut token sesi aktif 

## Instruksi Setup & Menjalankan Aplikasi

1. **Install dependensi Flutter:**
   flutter pub get

2. **Generate berkas serialisasi JSON (`*.g.dart`):**
   dart run build_runner build --delete-conflicting-outputs

3. **Pastikan backend Django berjalan** 
    python manage.py runserver

4. **Jalankan aplikasi Flutter sesuai platform target:**
   - **Chrome / Web:**
     flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8000

   - **Backend Deployed:**
     flutter run --dart-define=API_BASE_URL=https://<>
     
5. **Menjalankan pemeriksaan statis & unit test:**
   dart format --output=none --set-exit-if-changed .
   flutter analyze
   flutter test


## Tugas 7 ##

1. Widget tree adalah struktur hierarki berbentuk tree yang merepresentasikan susunan seluruh komponen UI di dalam aplikasi Flutter. Hubungan parent-child, pada parent (widget induk) di-definse melalui properti child (Padding, Container, Center) ataupun melalui child (GridView, Row, Column). parent memiliki peran dalam memberikan batasan ukuran dan tema childnya, kemudian widget child akan menentukan ukurannya autodidak pada rentang batasan tersebut dan me-return informasi ukurannya ke widget induk sehingga muncul pada layar user.

2. 
MaterialApp: Widget tingkat akar yang mengonfigurasi tema Material Design, judul aplikasi, dan halaman awal.

MyHomePage (StatelessWidget): Widget kustom yang merangkai tata letak utama halaman menu portofolio.

Scaffold: Kerangka visual dasar halaman Material Design yang memuat slot untuk AppBar, body, dan penampilan SnackBar.

AppBar: Navigasi di bagian paling atas layar yang menampilkan judul aplikasi.

SingleChildScrollView: Membungkus konten utama agar halaman dapat di scroll.

Padding: Memberikan jarak kosong di sekeliling widget child menggunakan EdgeInsets.

Column: Menyusun widget child secara vertikal dari atas ke bawah.

Row: Menyusun widget child secara horizontal dari kiri ke kanan.

Center: Memosisikan widget child tepat di tengah ruang.

SizedBox: Membuat kotak dengan dimensi tinggi atau lebar tetap untuk memberi jarak antar komponen.

Text: Menampilkan rangkaian karakter string ke layar dengan gaya tipografi tertentu.

GridView.count: Menyusun widget child dalam tata letak kedua dimensi dengan jumlah kolom tetap.

InfoCard (StatelessWidget): Widget kustom reusable untuk menampilkan kartu identitas pemilik (NPM, Nama, Kelas).

Card: Menampilkan kontainer Material dengan sudut membulat dan efek bayangan.

Container: Widget pembungkus serbaguna untuk mengatur ukuran, padding, dan tata letak child.

ItemCard (StatelessWidget): Widget kustom reusable untuk merender tiap objek ItemHomepage menjadi tombol kartu berwarna.

Material: Memberikan permukaan kanvas Material.

InkWell: Mendeteksi ketukan pengguna (onTap) dan menampilkan animasi efek visual saat ditekan.

Icon: Menampilkan ikon grafis berbasis vektor dari icons Material.

SnackBar: Menampilkan pesan umpan balik di bagian bawah layar saat tombol ditekan.

3. MaterialApp berfungsi sebagai pembungkus yang menyediakan infrastruktur esensial bagi komponen Material, seperti manajemen rute dan navigator, konfigurasi tema, pengaturan lokalisasi bahasa, serta ScaffoldMessenger. Widget MaterialApp pada umumnya dijadikan root widget karena sebagian besar widget UI membutuhkan konteks warisan InheritedWidget yang diinisialisasi oleh MaterialApp pada widget tree. Tanpa adanya MaterialApp sebagai root, widget di bawahnya akan failed to configurate text, tema warna, dan navigator.

4. StatelessWidget merupakan widget yang bersifat immutable (tidak mempunyai mutable state internal), dimana output tampilannya akan bergantung pada data konfigurasi yang diteruskan ke konstruktornya saat dibuat dan tidak akan berubah sendiri selama siklusnya. Menggunakan StatelessWidget pada saat merancang komponen yang bersifat statis menampilkan data yang diberikan oleh induknya

StatefulWidget akan memisahkan konfigurasi widget dengan objek yang bersifat mutable, sehingga UI dapat diupdate secara dinamis dengan memanggil method setState(). Menggunakan StatefulWidget pada saat UI perlu berubah secara masif terhadap user interact, ketika pada saat perubahan input, animasi ataupun pembaruan data dari API.

5. BuildContext adalah suatu handle yang menunjukkan lokasi speifik terhadap widget di dalam widget tree. Hal ini sangat penting karena sebuah widget dapat saling interaksi dengan ancestor untuk membaca data konfigurasi. Penggunaannya, dengan contoh dalam method build(BuildContext context), penggunaan parameter context digunakan pada pola statistic, entah itu digunakan untuk mengambil warna, menghitung lebar pada suatu card, dan menampilkan SnackBar.

6. Hot reload akan mengambil kode sumber Dart yang telah dimodifikasi ke dalam Dart Virutal Machine, lalu rebuild widget tree secara otomatis tanpa harus menghapus state aplikasi yang sedang dijalankan. Hot restart akan me-refresh ulang kode baru dan dengan waktu yang bersamaan, akan menghapus seluruh state yang telah tersimpan dan me-compile ulang aplikasi dari main()

Tidak bisa jikalau hanya mengandalkan hot reload, dan harus melakukan hot restart apabila hanya mengubah nilai inisialisasi variabel global, mengubah daftar atribut ataupun inisialisasi properti langsung, dan mengubah logika dalam main(). Full restart wajib untuk dilakukan karena akan menghentikan dan menjalankan ulang proses build dan apabila menambahkan dependensi pada berkas pubspec.yaml, dan memodifikasi konfigurasi kode native

`AI DISCLOSURE`
Tools yang digunakan adalah Gemini, strategi prompting adalah memberikan konteks terhadap apa yang ingin saya lakukan, lalu memberikan penjelasan tambahan mengenai apa yang telah saya inisiasi pada project ini, lalu memberi clue untuk fitur tambahan yang harus di-inisiasi sehingga dapat memberikan output yang terbaik (contoh: bagaimana menambah fitur scroll pada flutter dan)

Dengan bagian yang dibantu AI salah satu nya adalah menambah fitur scroll untuk UI, dan bagaimana syntax untuk mengubah warna tiap card. Sehingga memberikan saya pengetahuan yang baru bahwa, penggunaan Column di GridView.count akan menyebabkan RenderFlex overflow.33


## Tugas 8 ##

1. Jelaskan perbedaan antara Navigator.push(), Navigator pushReplacement(), dan Navigator.pop(). Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.

=> perbedaan anatara Navigator.push(), Navigator.pushReplacement, dan Navigator.pop() adalah,
a. Navigator.push() untuk menambahkan route baru ke posisi paling atas stack yang di-inisiate oleh Navigator tanpa menghapus halaman yang berada di bawahnya, user tetap daapt kembali ke halaman sebelumnya
b. Navigator.pushReplacement() akan menghapus route yang sedang aktif di posisi paling atas stack dan langsung menggantinya dengan route yang baru, sehingga halaman yang sebelumnya tidak tersimpan 
c. Navigator.pop() menghapus route yang sedang berada di puncak stack, layar akan kembali menampilkan route yang berada di bawahnya

Untuk membuka ExperienceFormPage, metode yang digunakan adalah Navigator.push() supaya halaman utama tetap berada di bawah stack dan user dapat kembali menggunakan fitur back bawaan aplikasi, dan alurnya pada saat user menekan tombol home pada leftdrawer, aplikasi akan memanggil Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage())) yang akan menggantikan route di atas stack dengan MyHomePage, sehingga user dapat kembali ke halaman utama

2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.

=> Peran Scaffold, AppBar dan Drawer adalah sebagai berikut,
a. Scaffold menyediakan kerangka tata letak visual standar material design pada tiap layar appbar, drawer, dan area utama pada posisi tertentu di seluruh aplikasi tersebut
b. AppBar akan menjaga identitas halaman tetap jelas dengan judul layar dan tombol ikon secara ototmatis
c. Drawer untuk memastikan pengguna selalu mendapat struktur menu navigator yang identik pada seluruh halaman.

Sebagaimana contoh penggunaan warna tema portofolio Theme.of(context).colorScheme.primary digunakan secara konsisten pada seluruh halaman, yakni sebagai backgroundColor pada AppBar di MyHomePage, tombol simpan di ExperienceFormPage, dan latar belakang pada left_drawer

3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.

=> Tata letak column dengan crossAxisAlignment dipilih karena alur pengisian formulir pada perangkat bergerak secara egronomis dan disusun secara vertikal dari atas hingga ke bawah, sementara komponen Mulai dan Selesai disusun bersebelahan menggunakan Row agar perbandingan periode waktu terlihat lebih ringkas pada satu baris

Peran widget pengatur jarak(padding) memberikan ruang kosong yang berukuran pixel pada sekeliling tiap TextFormField dan batas antar-kolam dapat terlihat secara jelas. Pesan error yang akan muncul tidak akan saling berhimpitan dan user akan terhindar dari salah klik

Peran widget penggulir(SingleChildScrollView) karena column secara default tidak dapat di-scroll, menaungi column dengan SingleChildScrollView dan di dalam AlertDialog dapat mencegah terjadinya RenderFlex overflow serta untuk memastikan keseluruhan column input dan tombol simpan dapat di-scroll dan dijangkau meskipun ruang layar terbatas.

4. Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.

=> Berikut adalah perang dari GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan,
a. GlobalKey<FormState> berfungsi sebagai pengenal dan juga memegang referensi terhadap state internal dari widget Form, sehingga logic luar di masing masing field dapat memicu validasi atau reset seluruh input
b. Validator berfungsi callback pada tiap FormField ataupun TextFormField yang memeriksa nilai input terhadap model, fungsi ini akan return String berisi pesan error jika diluar aturan ataupun return null jika dinyatakan valid
c. Validate() akan mengeksekusi fungsi validator pada seluruh field di Form secara berbarengan, selain itu juga akan menampilkan pesan error di bawah kolom dan return nilai true apabila field memberikan output null

Sebagai contoh nilai yang ditolak oleh validasi adalah String yang berisikan spasi kosong, atau pemilihan tanggal selesai yang lebih awal daripada tanggal mulai. memilih jenis input atau papan ketik belum cukup karena jenis apapun papan ketik tersebut hanya menyesuaikan tata letak tombol untuk memudahkan pengetikan tanpa harus blokir user yang mengetik teks random, 

`AI DISCLOSURE`
Tools yang digunakan adalah Gemini, dengan Strategi Prompting untuk menyelesaikan hal hal yang harus di-isi pada rancangan ExperienceFormPage, dengan memuat terlebih dahulu yang sesuai dengan Field project, dan bagaimana untuk mengintegrasikan LeftDrawer pada saat membuat form yang baru. Bagian yang dibantu AI adalah gimana cara validasi showDatePicker, bagaimana merapihkan pada berkas lib/screens/ dan rancangan kerangka FormField, lalu pengisian experience_form.dart. 

Keterbatasan AI adalah harus diberi konteks dengan apa yang ingin saya lakukan, daripada langsung menanyakan tanpa konteks. Melakukan perbaikan manual karena bentuk nya sama pada inisialisasi left_drawer.dart, project_card.dart yang sesuai implementasi dengan tutorial sebelumnya.


## TUGAS 9 ##

1. Penggunaan @JsonSerializable(fieldRename: FieldRename.snake) dan @JsonKey(includeToJson: false) memberikan *compile-time type safety* serta pemisahan yang jelas antara lapisan model data dan lapisan UI, dibandingkan menyusun Map<String, dynamic> mentah langsung di dalam UI yang rawan salah ketik key, dan duplikasi logika. FieldRename.snake secara otomatis memetakan konvensi penamaan camelCase di Dart ke konvensi snake_case pada Django REST Framework (`category_display`, `is_ongoing`, `star_count`, `starred_by_names`).

@JsonKey(includeToJson: false) memastikan field yang ditetapkan atau dihitung oleh server tidak ikut dikirim pada payload `POST`. Pendekatan ini mencegah bug pengiriman field *read-only* seperti id dan experience_img dalam request `POST` yang dapat memicu penolakan validasi `400 Bad Request` di DRF, sekaligus mencegah `TypeError` saat deserialisasi ketika field opsional seperti thumbnail atau experience_img bernilai `null` melalui @JsonKey(defaultValue: '').

2. `Future` yang diteruskan ke `FutureBuilder` harus diinisialisasi di dalam `initState()` dan bukan langsung di dalam `build()` karena metode `build()` dapat dipanggil berkali-kali oleh framework Flutter setiap terjadi perubahan state, animasi, rotasi layar, atau perubahan keyboard. Jika pemanggilan API ditempatkan di `build()`, setiap rebuild akan memicu permintaan HTTP baru secara berulang, membebani server, memboroskan jaringan, dan membuat tampilan terus berkedip kembali ke indikator loading. Dengan menyimpannya pada state di `initState()`, permintaan jaringan hanya terjadi ketika memang dibutuhkan.

`ApiClient` sebaiknya melempar `ApiException(statusCode, message)` daripada mengembalikan `null` pada respons agar informasi status HTTP tetap terjaga. Dengan melempar exception, `FutureBuilder` dapat menangkap kegagalan melalui `snapshot.hasError` untuk menampilkan UI error beserta tombol *Retry*, dan `ExperienceFormPage` dapat membedakan status `401 Unauthorized` dari error validasi `400` atau gangguan server `5xx`.

3. `SessionAuthentication` milik Django bersifat stateful karena menyimpan data sesi di sisi server dan mengandalkan *session cookie* beserta token CSRF yang dikirim otomatis oleh browser pada permintaan.  

`TokenAuthentication` milik DRF bersifat stateless per permintaan dengan mengirimkan header eksplisit `Authorization: Token <key>` yang langsung diverifikasi terhadap tabel `authtoken_token` tanpa bergantung pada manajemen cookie maupun CSRF browser. 

myportofolio_mobile menggunakan `TokenAuthentication` karena user mobile native tidak memiliki cookie jar browser bawaan dan mekanisme header token bekerja konsisten di Android maupun Flutter Web. `SessionAuthentication` tetap diaktifkan pada `REST_FRAMEWORK["DEFAULT_AUTHENTICATION_CLASSES"]` di backend Django agar aplikasi web Django, halaman Django Admin, dan DRF Browsable API tetap dapat digunakan secara normal melalui browser tanpa rusak.

4.job `build` memanggil reusable workflow `VeryGoodOpenSource/very_good_workflows` yang di balik layar menjalankan langkah `setup` (`dart run build_runner build --delete-conflicting-outputs`), pemeriksaan pemformatan kode (`dart format`), analisis statis (`flutter analyze`), serta eksekusi unit/widget test (`flutter test`) beserta pengumpulan *code coverage* (mengecualikan `**/*.g.dart` dengan batas `min_coverage: 0`). 

job `build_apk` menggunakan `needs: build` sehingga hanya berjalan setelah seluruh pemeriksaan pada job `build` lulus; job ini menginstall dependensi (`flutter pub get`), menghasilkan ulang kode (`build_runner`), mengompilasi APK Android release (`flutter build apk --release`), dan mengunggah `build/app/outputs/flutter-apk/app-release.apk` sebagai artefak `app-release-apk` menggunakan `actions/upload-artifact@v4`. 

Berkas `*.g.dart` dimasukkan ke `.gitignore` karena merupakan artefak hasil generasi yang selalu dapat dibentuk ulang dari definisi model, sehingga menyimpannya di Git hanya akan memicu *merge conflict*. Pipeline CI tetap dapat menganalisis dan membangun aplikasi karena baik job `build` (melalui input `setup`) maupun job `build_apk` menjalankan `dart run build_runner build --delete-conflicting-outputs` secara otomatis sebelum analisis, pengujian, dan build APK.

`AI DISCLOSURE`
Tools yang digunakan adalah Gemini, dengan Strategi Prompting untuk menyelesaikan hal hal yang harus di-isi pada rancangan Experience, dengan memuat terlebih dahulu yang sesuai dengan models di backend django, lalu bagaimana untuk menginisiasi penambahan test file, penambahan syntax apa yang harus digunakan pada experience_detail_screen, experience_list_screen, dan penambahan experience_dart agar sesuai dengan yang di-inginkan dan ter integrasi dengan left_drawer

Keterbatasan AI adalah harus diberi konteks dengan apa yang ingin saya lakukan, daripada langsung menanyakan tanpa konteks. Melakukan perbaikan manual pada Experience.dart karna kurang lebih mirip  dengan project.dart lalu perbaikan di main.dart
