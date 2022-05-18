import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_app/providers/user/user_provider.dart';

import '../../models/user/user_model.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String _selectedImage = 'men.png';
  String name = 'User Name';
  User user = User();
  int id = 0;
  bool _disabled = true;

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(userProvider);

    if (data.isNotEmpty) {
      data.forEach((element) {
        //print(element.name);
        user.id = element.id;
        user.gender = element.gender;
        user.name = element.name;
        user.image = element.image;
      });
    } else {
      User u = User();
      u.name = 'User';
      u.gender = 'male';
      u.image = 'user.png';
      ref.watch(userProvider.notifier).createUser(user);
    }

    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text(
          "PROFILE",
          style: TextStyle(letterSpacing: 2.0),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(color: Colors.black45),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _userImage("handsome_boy.jpg", 'handsome', user.id),
                _userImage("special_boy.jpg", 'special', user.id),
                _userImage("school_boy.jpg", 'school boy', user.id),
                _userImage("cute_anime_boy.jpg", 'anime boy', user.id),
                _userImage("anime_girl_two.jpg", 'anime girl', user.id),
                _userImage("hair_cute_anime.jpg", 'hair cute', user.id),
                _userImage("anime_girl.jpg", 'cute girl', user.id),
                _userImage("cut_girl.jpg", 'cat girl', user.id)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: SizedBox(
                              width: 120,
                              height: 120,
                              child: ClipOval(
                                child: user.image != null
                                    ? Image.asset(
                                        'images/' + user.image!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'images/' + _selectedImage,
                                        fit: BoxFit.cover,
                                      ),
                              ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),

                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 0.0),
                              child: Text(
                                user.name != null
                                    ? user.name.toString()
                                    : 'User Name',
                                style: TextStyle(color: Colors.amber),
                              ),
                            ),
                          ),
                          user.gender == 'female'
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Icon(
                                    Icons.female,
                                    size: 20,
                                    color: Colors.pink,
                                  ),
                                )
                              : Icon(
                                  Icons.male,
                                  size: 20,
                                  color: Colors.indigo,
                                ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 15),
                          //   child: IconButton(
                          //       onPressed: () {
                          //         setState(() {
                          //           _disabled = !_disabled;
                          //         });
                          //       },
                          //       icon: Icon(Icons.edit)),
                          // )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.black45),
                      child: TextFormField(
                        onChanged: (String? val) {
                          if (user.id != null && user.id! > 0) {
                            user.name = val;
                            ref.watch(userProvider.notifier).updateUser(user);
                          }
                        },
                        // readOnly: _disabled,
                        style: TextStyle(color: Colors.white, letterSpacing: 1),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle_outlined),
                            //focusColor: Colors.amber,
                            border: InputBorder.none,
                            fillColor: Colors.amber),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            child: Radio<String>(
                              value: "male",
                              onChanged: (val) {
                                user.gender = val;
                                if (user.id != null && user.id! > 0) {
                                  ref
                                      .watch(userProvider.notifier)
                                      .updateUser(user);
                                }
                              },
                              groupValue: user.gender,
                            ),
                          ),
                          Text("Male"),
                          SizedBox(
                            child: Radio<String>(
                              value: "female",
                              onChanged: (val) {
                                user.gender = val;
                                if (user.id != null && user.id! > 0) {
                                  ref
                                      .watch(userProvider.notifier)
                                      .updateUser(user);
                                }
                              },
                              groupValue: user.gender,
                            ),
                          ),
                          Text("Female")
                        ],
                      ),
                    ),
                    !_disabled
                        ? Padding(
                            padding: EdgeInsets.zero,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {}, child: Text("Cancel")),
                                ElevatedButton(
                                    onPressed: () {
                                      if (user.id == null || user.id == 0) {
                                        ref
                                            .watch(userProvider.notifier)
                                            .createUser(user);
                                      } else {
                                        ref
                                            .watch(userProvider.notifier)
                                            .updateUser(user);
                                      }
                                    },
                                    child: Text("Save"))
                              ],
                            ),
                          )
                        : SizedBox()
                  ]),
            ),
          )
        ],
      ),
    );
  }

  Widget _userImage(String image, String name, int? id) {
    return InkWell(
      onTap: () {
        if (id != null) {
          user.image = image;
          ref.watch(userProvider.notifier).updateUser(user);
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 25, 0, 0),
        child: Column(
          children: [
            CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SizedBox(
                    width: 80,
                    height: 80,
                    child: ClipOval(
                      child: Image.asset(
                        "images/" + image,
                        fit: BoxFit.cover,
                      ),
                    ))),
            SizedBox(
              height: 7,
            ),
            Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                user.image == image
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 15,
                      )
                    : SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
