import 'dart:async'; // Import paket dart:async untuk mendukung operasi asinkron.
import 'package:flutter/material.dart'; // Import paket flutter/material untuk pengembangan antarmuka pengguna.

void main() {
  runApp(TimerApp()); // Mulai aplikasi dengan menjalankan widget TimerApp.
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Menyembunyikan banner debug di aplikasi.
      title: 'Timer App', // Judul aplikasi yang akan ditampilkan di bilah atas.
      theme: ThemeData(
        // Menetapkan tema aplikasi.
        primarySwatch:
            Colors.blue, // Memberikan warna biru sebagai warna utama.
        elevatedButtonTheme: ElevatedButtonThemeData(
          // Menetapkan tema untuk tombol yang ditinggikan.
          style: ButtonStyle(
            // Menetapkan gaya untuk tombol.
            backgroundColor: MaterialStateProperty.all<Color>(
                Colors.blue), // Warna latar belakang tombol.
            foregroundColor: MaterialStateProperty.all<Color>(
                Colors.white), // Warna teks tombol.
          ),
        ),
      ),
      home:
          TimerPageOne(), // Menetapkan TimerPageOne sebagai halaman utama aplikasi.
    );
  }
}

class TimerPageOne extends StatefulWidget {
  @override
  _TimerPageOneState createState() =>
      _TimerPageOneState(); // Membuat objek status untuk TimerPageOne.
}

class _TimerPageOneState extends State<TimerPageOne> {
  late TextEditingController
      _controller; // Objek _controller untuk mengendalikan input dari TextField.
  int _minutes = 0; // Variabel untuk menyimpan jumlah menit.

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(); // Menginisialisasi objek _controller.
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Membersihkan sumber daya ketika status TimerPageOne dihapus.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer App'), // Menetapkan AppBar dengan judul "Timer App".
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // Posisi widget secara vertikal ke tengah.
            crossAxisAlignment: CrossAxisAlignment
                .center, // Posisi widget secara horizontal ke tengah.
            children: [
              Text(
                'Masukkan menit', // Menampilkan teks "Masukkan menit" dengan ukuran 24.
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20), // Memberikan jarak antara widget.
              Container(
                width: 200, // Mengatur lebar widget TextField.
                child: TextField(
                  controller:
                      _controller, // Menghubungkan controller dengan TextField.
                  keyboardType: TextInputType
                      .number, // Menetapkan keyboard untuk input angka.
                  textAlign:
                      TextAlign.center, // Posisi teks di tengah TextField.
                  decoration: InputDecoration(
                    border:
                        OutlineInputBorder(), // Menampilkan garis pinggir TextField.
                  ),
                  onChanged: (value) {
                    setState(() {
                      _minutes = int.tryParse(value) ??
                          0; // Mengubah nilai string menjadi integer.
                    });
                  },
                ),
              ),
              SizedBox(height: 20), // Memberikan jarak antara widget.
              ElevatedButton(
                onPressed: () {
                  if (_minutes > 0) {
                    // Memastikan jumlah menit yang dimasukkan lebih dari 0.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TimerPageTwo(
                          minutes:
                              _minutes, // Membuat objek TimerPageTwo dengan menyediakan jumlah menit.
                        ),
                      ),
                    );
                  }
                },
                child: Text('MULAI'), // Teks pada tombol.
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerPageTwo extends StatefulWidget {
  final int minutes; // Variabel untuk menyimpan jumlah menit.

  TimerPageTwo(
      {required this.minutes}); // Konstruktor untuk menerima jumlah menit.

  @override
  _TimerPageTwoState createState() =>
      _TimerPageTwoState(); // Membuat objek status untuk TimerPageTwo.
}

class _TimerPageTwoState extends State<TimerPageTwo> {
  late Timer _timer; // Objek untuk mengatur timer.
  int _minutes = 0; // Variabel untuk menyimpan jumlah menit.
  int _seconds = 0; // Variabel untuk menyimpan jumlah detik.
  bool _isTimerRunning =
      true; // Variabel boolean untuk menunjukkan apakah waktu sedang berjalan atau tidak.

  @override
  void initState() {
    super.initState();
    _minutes =
        widget.minutes; // Mengambil jumlah menit dari parameter konstruktor.
    _startTimer(); // Memulai timer.
  }

  void _startTimer() {
    int totalSeconds =
        _minutes * 60; // Mengubah jumlah menit menjadi jumlah detik.
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_isTimerRunning) {
          // Memastikan timer sedang berjalan.
          if (totalSeconds > 0) {
            totalSeconds--;
            _minutes = totalSeconds ~/
                60; // Mendapatkan jumlah menit dari totalSeconds.
            _seconds =
                totalSeconds % 60; // Mendapatkan sisa detik dari totalSeconds.
            if (totalSeconds == 0) {
              // Jika totalSeconds sudah habis.
              timer.cancel(); // Menghentikan timer.
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TimerPageThree()), // Menavigasi ke halaman TimerPageThree.
              );
            }
          } else {
            timer.cancel(); // Menghentikan timer jika totalSeconds telah habis.
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer App'), // Menetapkan AppBar dengan judul "Timer App".
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // Posisi widget secara vertikal ke tengah.
            crossAxisAlignment: CrossAxisAlignment
                .center, // Posisi widget secara horizontal ke tengah.
            children: [
              Container(
                width: 200, // Mengatur lebar widget.
                height: 200, // Mengatur tinggi widget.
                decoration: BoxDecoration(
                  color: Colors
                      .grey[200], // Memberikan warna latar belakang abu-abu.
                  borderRadius: BorderRadius.circular(
                      10), // Memberikan sudut melengkung pada Container.
                ),
                child: Center(
                  child: Text(
                    '$_minutes:${_seconds.toString().padLeft(2, '0')}', // Menampilkan teks dengan format menit:detik.
                    style: TextStyle(fontSize: 48),
                  ),
                ),
              ),
              SizedBox(height: 20), // Memberikan jarak antara widget.
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isTimerRunning =
                        !_isTimerRunning; // Mengubah status waktu berjalan atau tidak.
                  });
                },
                child: Text(_isTimerRunning
                    ? 'BERHENTI'
                    : 'LANJUTKAN'), // Teks pada tombol bergantung pada status waktu.
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer
        .cancel(); // Membersihkan sumber daya ketika status TimerPageTwo dihapus.
    super.dispose();
  }
}

class TimerPageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer App'), // Menetapkan AppBar dengan judul "Timer App".
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // Posisi widget secara vertikal ke tengah.
            crossAxisAlignment: CrossAxisAlignment
                .center, // Posisi widget secara horizontal ke tengah.
            children: [
              Text(
                'Waktu Habis!', // Menampilkan teks "Waktu Habis!" dengan ukuran 24.
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20), // Memberikan jarak antara widget.
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TimerPageOne()), // Menavigasi ke halaman TimerPageOne.
                  );
                },
                child: Text('MULAI ULANG'), // Teks pada tombol.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
