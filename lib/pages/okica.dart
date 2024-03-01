import 'package:flutter/material.dart';

class Okica extends StatefulWidget {
  const Okica({Key? key}) : super(key: key);

  @override
  State<Okica> createState() => _OkicaState();
}

class _OkicaState extends State<Okica> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 30.0, right: 40.0, left: 40.0),
              child: Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFE2A5A4), width: 3),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 30.0,
                          ),
                          child: Text(
                            "1000",
                            style: TextStyle(
                                fontSize: 80, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 150,
                            ),
                            const Text(
                              "円",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '利用履歴',
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 40, bottom: 10),
              child: LimitedBox(
                maxHeight: MediaQuery.of(context).size.height * 0.55,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFFE2A5A4), width: 3),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: ListView(
                      shrinkWrap: true,
                      children: const [
                        History("2024/04/01", "沖縄高専前", "名護十字路"),
                        History("2024/05/01", "沖縄高専前", "名護十字路"),
                        History("2024/06/01", "沖縄高専前", "名護十字路"),
                        History("2024/06/01", "沖縄高専前", "名護十字路"),
                        History("2024/06/01", "沖縄高専前", "名護十字路"),
                        History("2024/06/01", "沖縄高専前", "名護十字路"),
                        History("2024/06/01", "沖縄高専前", "名護十字路"),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  const History(this.date, this.startBusStop, this.endBusStop, {super.key});

  final String date;
  final String startBusStop;
  final String endBusStop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        right: 15.0,
        left: 15.0,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFFFFF4D9)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 16.0),
                  child: Text(
                    date,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 6.0,
                left: 6.0,
                bottom: 20.0,
                top: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            startBusStop,
                          )),
                    ),
                  ),
                  const Expanded(
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        endBusStop,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
