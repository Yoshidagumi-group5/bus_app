import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<List<String>> searchResult = [
  ['77', '500', '30', '14:30', '15:30', '沖縄高専入口', '那覇バスターミナル'],
  ['111', '600', '30', '14:30', '15:30', '沖縄高専入口', '那覇バスターミナル'],
  ['120', '700', '30', '14:30', '15:30', '沖縄高専入口', '那覇バスターミナル'],
  ['45', '800', '30', '14:30', '15:30', '沖縄高専入口', '那覇バスターミナル'],
];

final List<StateProvider<bool>> colorProviders = <StateProvider<bool>>[
  for (int i = 0; i < searchResult.length; i++) StateProvider((ref) => false)
];

/*final colorProviders = StateProvider<List<bool>>((ref) {
  List<bool> result = [];
  for (int i = 0; i < searchResult.length; i++) {
    result.add(false);
    //debugPrint(result[i].toString());
  }
  return result;
});*/

class Prefs {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences?> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<bool> setBool(String key, bool value) async {
    if (_prefs == null) return false;
    return await _prefs!.setBool(key, value);
  }

  static Future<bool> setDouble(String key, double value) async {
    if (_prefs == null) return false;
    return await _prefs!.setDouble(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    if (_prefs == null) return false;
    return await _prefs!.setInt(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    if (_prefs == null) return false;
    return await _prefs!.setString(key, value);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    if (_prefs == null) return false;
    return await _prefs!.setStringList(key, value);
  }

  static bool? getBool(String key) => _prefs?.getBool(key);

  static double? getDouble(String key) => _prefs?.getDouble(key);

  static int? getInt(String key) => _prefs?.getInt(key);

  static String? getString(String key) => _prefs?.getString(key);

  static List<String>? getStringList(String key) => _prefs?.getStringList(key);

  static Set<String>? getKeys() => _prefs?.getKeys();

  static Future<bool> remove(String key) async {
    if (_prefs == null) return false;
    return await _prefs!.remove(key);
  }

  static Future<bool> clear() async {
    if (_prefs == null) return false;
    return await _prefs!.clear();
  }
}

class SearchResult extends StatefulWidget {
  SearchResult({Key? key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  int resultNumCounter = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      resultNumCounter += searchResult.length;
    });

    Prefs.setInt("currentResultNum", resultNumCounter);
  }

  void showSharedPreference() {
    final keys = Prefs.getKeys();
    print(keys);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE8AE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFBD2B2B),
        centerTitle: true,
        title: const Text(
          "検索結果の一覧",
          style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE2A5A4)),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "2024/02/19",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "出発：13:40",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ElevatedButton(
                                      onPressed: () => showSharedPreference(),
                                      child: Text("テスト"))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10.0, right: 10.0),
                        child: Container(
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE2A5A4)),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.subdirectory_arrow_right,
                                  size: 30,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 2.0, bottom: 2.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "国立沖縄工業高等専門学校",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "那覇空港第二バスターミナル",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Container(
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE2A5A4)),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 2.0, bottom: 2.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "検索条件",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "乗り換えなし",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 16.0),
              child: LimitedBox(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
                child: ListView(
                    shrinkWrap: true,
                    children: List.generate(
                      searchResult.length,
                      (index) => SearchResultClass(index, searchResult[index]),
                    )),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFFBD2B2B),
          shape: const CircleBorder(),
          onPressed: () {},
          child: const Icon(
            Icons.replay_outlined,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class SearchResultClass extends ConsumerWidget {
  const SearchResultClass(this.resultNum, this.routeInformation, {super.key});
  final int resultNum; //表示される結果一覧の内、何番目の結果か示す番号、バス登録ボタンなどに使用
  //final String busNum; //バスの番号：77番
  //final String cost; //バスの値段：500円
  //final String time; //バスの所要時間：30分
  //final String startTime; //バスの発車時刻,14:30
  //final String endTime; //バスの到着時刻,15:30
  //final String startBusStop; //乗るバス停の名前：沖縄高専入口
  //final String endBusStop; //降りるバス停の名前：那覇バスターミナル
  final List<String> routeInformation;
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE2A5A4)),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Color(0xFFFFF4D9),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  )),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE2A5A4)),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Text(
                          routeInformation[0],
                          //busNum.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
                    child: Text(
                      routeInformation[5],
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  BusRegisterationButton(
                    providers: colorProviders[resultNum],
                    num: resultNum,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          routeInformation[1] + "円" + routeInformation[2] + "分",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        routeInformation[3],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        routeInformation[5],
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        "(那覇行き)",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        routeInformation[4],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        routeInformation[6],
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        "(那覇行き)",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BusRegisterationButton extends ConsumerWidget {
  const BusRegisterationButton(
      {super.key, required this.providers, required this.num});

  final StateProvider<bool> providers;
  final int num;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(providers);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ? Colors.red : Colors.white,
        ),
        child: IconButton(
          onPressed: () async {
            ref.read(providers.notifier).state = !color;
            if (ref.read(providers.notifier).state) {
              await Prefs.setStringList(
                  ((num + Prefs.getInt("currentResultNum")!).toString()),
                  searchResult[num]);
            } else {
              await Prefs.remove(
                  (num + Prefs.getInt("currentResultNum")!).toString());
            }
          },
          icon: Icon(
            Icons.directions_bus_filled_sharp,
            size: 25,
            color: color ? Colors.white : Colors.red,
          ),
        ),
      ),
    );
  }
}
