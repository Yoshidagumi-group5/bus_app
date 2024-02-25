import 'package:flutter/material.dart';

class Okica extends StatelessWidget {
  const Okica({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE8AE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFBD2B2B),
        centerTitle: true,
        title: const Text(
          "現在の残高",
          style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE2A5A4)),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 50.0, top: 50.0, bottom: 50.0),
                    child: Text(
                      "1000",
                      style:
                          TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "円",
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
                height: 100,
              ),
              SizedBox(
                width: 375,
                height: 50,
                child: Container(
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 174, 174, 174),
                  child: const Text(
                    '利用履歴',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
          const Text('2021/1/1'),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('沖縄高専前'),
              Icon(
                Icons.arrow_forward_sharp,
              ),
              Text('名護十字路'),
            ],
          ),
          const SizedBox(
            width: 400,
            height: 20,
          ),
          const Text('2021/1/1'),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('沖縄高専前'),
              Icon(
                Icons.arrow_forward_sharp,
              ),
              Text('名護十字路'),
            ],
          ),
          const SizedBox(
            width: 400,
            height: 20,
          ),
          const Text('2021/1/1'),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('沖縄高専前'),
              Icon(
                Icons.arrow_forward_sharp,
              ),
              Text('名護十字路'),
            ],
          ),
        ],
      ),
    );
  }
}
