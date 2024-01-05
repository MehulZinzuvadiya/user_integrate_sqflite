import 'package:flutter/material.dart';

String userforTextField = '';
String emailforTextField = '';
String dobforTextField = '';
String passwordforTextField = '';
int idForUpdate = 0;
bool isForUpdate = false;
int counter = 0;
DateTime dobforUpdate = DateTime.now();

class MainListView extends StatefulWidget {
  TabController tabController;

  MainListView({required this.tabController});

  @override
  State<MainListView> createState() => _MainListViewState();
}

class _MainListViewState extends State<MainListView> {
  List<Map<String, dynamic>>? data;

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    setState(() {});
    super.initState();
  }

  Future fetchData() async {
    data = await DataBaseHelper.instance.getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF81D7FF),
        body: data == null || data!.isEmpty
            ? Container(
                color: const Color(0xFF81D7FF),
              )
            : ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                      future: fetchData(),
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            //textDirection: TextDirection.ltr,

                            mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 3,
                                  color: const Color(0xFF81D7FF),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "User:",
                                                  style: TextStyle(
                                                      fontSize: 20, fontFamily: 'HedvigLetters'),
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                '${data![index]['name']}',
                                                style: const TextStyle(
                                                    fontSize: 20, fontFamily: 'HedvigLetters'),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Email:",
                                                  style: TextStyle(
                                                      fontSize: 20, fontFamily: 'HedvigLetters'),
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                '${data![index]['email']}',
                                                style: const TextStyle(
                                                    fontSize: 20, fontFamily: 'HedvigLetters'),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "DOB:",
                                                  style: TextStyle(
                                                      fontSize: 20, fontFamily: 'HedvigLetters'),
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                '${data![index]['dob']}',
                                                style: const TextStyle(
                                                    fontSize: 20, fontFamily: 'HedvigLetters'),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Password:",
                                                  style: TextStyle(
                                                      fontSize: 20, fontFamily: 'HedvigLetters'),
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                '${data![index]['password']}',
                                                style: const TextStyle(
                                                    fontSize: 20, fontFamily: 'HedvigLetters'),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: TextButton(
                                                  child: const Text(
                                                    "count:",
                                                    style: TextStyle(
                                                        fontSize: 20, fontFamily: 'HedvigLetters'),
                                                  ),
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) {
                                                          int subTableName = data![index]['id'];
                                                          return AlertDialog(
                                                              content: SubListView(
                                                            uId: subTableName,
                                                            tabController: widget.tabController,
                                                          ));
                                                        });
                                                  },
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                '${data![index]['count']}',
                                                style: const TextStyle(
                                                    fontSize: 20, fontFamily: 'HedvigLetters'),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        int subTableName = data![index]['id'];
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => SubSignUp(
                                                      userId: subTableName,
                                                    )));
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          userforTextField = data![index]['name'];
                                          emailforTextField = data![index]['email'];
                                          dobforTextField = data![index]['dob'];
                                          passwordforTextField = data![index]['password'];
                                          idForUpdate = data![index]['id'];
                                          counter = data![index]['count'];

                                          // print(userforTextField);
                                          //print(emailforTextField);
                                        });
                                        setState(() {
                                          isForUpdate = true;
                                        });
                                        print(isForUpdate);
                                        widget.tabController
                                            .animateTo(widget.tabController.index - 1);
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content:
                                                      const Text("Are you sure want to delete?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("Cancel"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        int delete = data![index]['id'];
                                                        await DataBaseHelper.instance
                                                            .delete(delete);
                                                        List<Map<String, dynamic>>? data1 =
                                                            await DataBaseHelper.instance.getData();
                                                        if (data1 != null) {
                                                          setState(() {
                                                            data = data1;
                                                          });
                                                        }
                                                        Navigator.pop(context);

                                                        // Navigator.push(context,MaterialPageRoute(builder: (_)=>HomePage()));
                                                      },
                                                      child: const Text("Yes"),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: const Icon(Icons.delete))
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }));
  }
}
