import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   
      title: 'Number',
     home: const NumberPage(),
    );
  }
}

class NumberPage extends StatefulWidget {
  const NumberPage({super.key});

  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  final _controller = TextEditingController();
  List<int> _numbers = [];
  String? _errorText; // biến hiển thị lỗi

  /// Hàm xử lý khi bấm nút "Tạo"
  void _generate() {
    final raw = _controller.text.trim();

    // 1️⃣ Kiểm tra rỗng
    if (raw.isEmpty) {
      return _setError('Dữ liệu bạn nhập không hợp lệ');
    }

    // 2️⃣ Thử parse sang số nguyên
    final n = int.tryParse(raw);
    if (n == null) {
      return _setError('Dữ liệu bạn nhập không hợp lệ');
    }

    // 3️⃣ Kiểm tra phạm vi hợp lệ
    if (n <= 0 || n > 100) {
      return _setError('Vui lòng nhập số nguyên dương (1–100)');
    }

    // ✅ Nếu hợp lệ → xoá lỗi & tạo danh sách
    setState(() {
      _errorText = null;
      _numbers = List.generate(n, (i) => i + 1);
    });
  }

  /// Hàm hiển thị lỗi
  void _setError(String msg) {
    setState(() {
      _errorText = msg;
      _numbers = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // căn giữa dọc
            crossAxisAlignment: CrossAxisAlignment.center, // căn giữa ngang
            children: [
              const Text(
                'Thực hành 02',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Ô nhập + nút Tạo
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Nhập vào số lượng',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        isDense: true,
                      ),
                      onSubmitted: (_) => _generate(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _generate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                    ),
                    child: const Text(
                      'Tạo',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Hiển thị lỗi (nếu có)
              if (_errorText != null)
                Text(
                  _errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),

              const SizedBox(height: 12),

              // Hiển thị danh sách số
              Column(
                children: _numbers
                    .map(
                      (num) => Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {},
                          child: Text(
                            num.toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
