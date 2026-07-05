import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nexus/orders/myDrawr.dart';
import 'package:nexus/requests/send_Requests_User.dart';
import 'package:nexus/supabase_service.dart/supabase_Storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? selectedPlatform;
  String? prompt2;
  String? selectedOne;
  bool? selected;
  bool tappedicon = false;
  bool color = false;
  int? lastidSaved;
  final userId = Supabase.instance.client.auth.currentUser!.id;
  String? kind;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  String? platform1;

  String? dispalyResult;

  TextEditingController prompt = TextEditingController();

  @override
  void initState() {
    super.initState();

    prompt = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    prompt.dispose();
  }

  void isClicked() {
    setState(() {
      color = !color;
    });
  }

  double boxWidth = 100;
  double boxheight = 100;
  var borderColor = Colors.black;
  var boxColor = Colors.black;

  String _getEmoji(String tone) {
    switch (tone) {
      case 'Professional':
        return '🧠';
      case 'Funny':
        return '😂';
      case 'Exited':
        return '🔥';
      case 'Short':
        return '⚡';
      default:
        return '🌚';
    }
  }

  Widget _buildToneChip(String toneName) {
    bool isSelected = selectedOne == toneName;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOne = toneName;
          kind = selectedOne;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 236, 72, 7)
              : Color.fromARGB(255, 30, 30, 30),
          borderRadius: BorderRadius.circular(15),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Color.fromARGB(255, 236, 72, 7),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // هون بننادي الميثود اللي بتجيب الإيموجي اللي أنت كتبتها
            Text(_getEmoji(toneName), style: TextStyle(fontSize: 18)),
            SizedBox(width: 8),
            Text(
              toneName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildcreateIcon(FaIconData icon) {
    bool isTapped = tappedicon;

    return GestureDetector(
      onTap: () async {
        if (!tappedicon) {
          prompt2 = prompt.text;
          setState(() {
            tappedicon = true;
            boxWidth = 380;
            boxheight = 410;
            boxColor = Color.fromARGB(255, 44, 44, 44);
            borderColor = Color.fromARGB(255, 236, 72, 7);
          });

          String? result = await SendRequestsUser().sendRequests(
            prompt.text,
            platform1 ?? "General",
            kind!,
          );

          if (result != null) {
            setState(() {
              dispalyResult = result;
            });
          }

          prompt.clear();
        } else {
          setState(() {
            tappedicon = false;
            boxWidth = 100;
            boxheight = 100;
            boxColor = Colors.black;
            borderColor = Colors.black;
            dispalyResult = null;
            color = false;
            prompt2 = null;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: isTapped
                  ? Color.fromARGB(150, 255, 69, 0)
                  : Color.fromARGB(255, 0, 0, 0),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 25,
          backgroundColor: tappedicon
              ? Color.fromARGB(255, 236, 72, 7)
              : Color.fromARGB(255, 60, 60, 60),
          child: FaIcon(
            FontAwesomeIcons.paperPlane,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(FaIconData icon, String platformname) {
    bool isSelected = selectedPlatform == platformname;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlatform = platformname;
          platform1 = selectedPlatform;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(40, 255, 69, 0)
              : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? Color.fromARGB(255, 255, 69, 0)
                : Color.fromARGB(255, 60, 60, 60),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Color.fromARGB(100, 255, 69, 0),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: FaIcon(
          icon,
          color: isSelected
              ? Color.fromARGB(255, 255, 69, 0)
              : Color.fromARGB(255, 155, 155, 155),
          size: 25,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Mydrawr(),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(0, 0, 0, 20),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _key.currentState?.openDrawer();
                },
                icon: Icon(Icons.menu, size: 30),
              ),
              SizedBox(width: 20),
              Text(
                'What is your next viral post?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 180, 190, 210),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 29),
            child: TextField(
              controller: prompt,
              style: TextStyle(color: Colors.white, fontSize: 17),
              cursorColor: Color.fromARGB(255, 255, 69, 0),
              decoration: InputDecoration(
                hintText: 'Enter your spark',
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 100, 100, 100),
                  fontWeight: FontWeight.w400,
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 20, 20, 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 40, 40, 40),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 255, 72, 0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Choose the platform for the idea..',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 180, 190, 210),
            ),
          ),
          SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialIcon(FontAwesomeIcons.instagram, 'Instagram'),
              SizedBox(width: 15),
              _buildSocialIcon(FontAwesomeIcons.tiktok, 'Tiktok'),
              SizedBox(width: 15),
              _buildSocialIcon(FontAwesomeIcons.youtube, 'Youtube'),
            ],
          ),

          SizedBox(height: 10),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildToneChip('Professional'),
                  SizedBox(width: 10),
                  _buildToneChip('Funny'),
                  SizedBox(width: 10),
                  _buildToneChip('Exited'),
                  SizedBox(width: 10),
                  _buildToneChip('Short'),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          _buildcreateIcon(FontAwesomeIcons.paperPlane),
          SizedBox(height: 15),
          AnimatedContainer(
            duration: Duration(seconds: 2),
            width: boxWidth,
            height: boxheight,
            curve: Curves.fastOutSlowIn,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: boxColor,
              border: Border.all(color: borderColor, width: 3),
              boxShadow: tappedicon
                  ? [
                      BoxShadow(
                        color: Color.fromARGB(255, 236, 72, 7),
                        blurRadius: 30,
                        spreadRadius: 5,
                        offset: Offset(0, 0),
                      ),
                    ]
                  : [],
            ),

            child: tappedicon
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          AnimatedTextKit(
                            key: ValueKey(dispalyResult),
                            animatedTexts: [
                              TypewriterAnimatedText(
                                dispalyResult ?? 'Creating...',
                                speed: Duration(milliseconds: 30),
                                textStyle: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  ),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                            totalRepeatCount: 1,
                          ),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    if (dispalyResult != null) {
                                      Clipboard.setData(
                                        ClipboardData(text: dispalyResult!),
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Copied text done...!'),
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.copy,
                                    color: Color.fromARGB(255, 236, 72, 7),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () async {
                                    isClicked();
                                    if (color) {
                                      lastidSaved = await SupabaseStorage()
                                          .svaeMyPost(
                                            dispalyResult ?? '',
                                            userId,
                                            prompt2 ?? '',
                                          );
                                    } else {
                                      if (lastidSaved != null) {
                                        await SupabaseStorage().deletePost(
                                          lastidSaved!,
                                        );
                                        lastidSaved = null;
                                      }
                                    }
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: color
                                        ? const Color.fromARGB(255, 250, 17, 0)
                                        : const Color.fromARGB(
                                            100,
                                            150,
                                            150,
                                            150,
                                          ),
                                  ),
                                  iconSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
