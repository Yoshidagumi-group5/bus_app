import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Okica extends StatelessWidget {
  const Okica({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 178, 177, 178),
        title: Text(
          '現在の残高',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // 上側に配置

        children: [
          SizedBox(
            width: 400,
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 200,
              ),
              Container(
                width: 375,
                height: 200,
                child: Container(
                  alignment: Alignment.center,
                  color: Color.fromARGB(255, 174, 174, 174),
                  child: Text(
                    '100円',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 100,
              ),
              SizedBox(
                width: 375,
                height: 50,
                child: Container(
                  alignment: Alignment.center,
                  color: Color.fromARGB(255, 174, 174, 174),
                  child: Text(
                    '利用履歴',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
          Text('2021/1/1'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('沖縄高専前'),
              Icon(
                Icons.arrow_forward_sharp,
              ),
              Text('名護十字路'),
            ],
          ),
          SizedBox(
            width: 400,
            height: 20,
          ),
          Text('2021/1/1'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('沖縄高専前'),
              Icon(
                Icons.arrow_forward_sharp,
              ),
              Text('名護十字路'),
            ],
          ),
          SizedBox(
            width: 400,
            height: 20,
          ),
          Text('2021/1/1'),
          Row(
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
