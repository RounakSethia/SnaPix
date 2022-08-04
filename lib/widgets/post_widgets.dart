import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixapp/models/user_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pixapp/models/user.dart' as model;
import 'package:pixapp/Pages/comments.dart';
import 'package:pixapp/Firebase/firestore_methods.dart';
import 'package:pixapp/widgets/theme_widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

//Basic formate of post and all other functionality
class PostSnapix extends StatefulWidget {
  final output;
  const PostSnapix({
    Key? key,
    required this.output,
  }) : super(key: key);

  @override
  State<PostSnapix> createState() => _PostSnapixState();
}

class _PostSnapixState extends State<PostSnapix> {
  showSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Something went wrong"),
      ),
    );
  }

  int commentcount = 0;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot res = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.output['postId'])
          .collection('comments')
          .get();
      commentcount = res.docs.length;
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final model.User user =
        Provider.of<UserProvider>(context).getUser as model.User;

    return Container(
      decoration: BoxDecoration(
        color: themeColors(),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 25,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.output['postUrl'].toString(),
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black.withOpacity(0.25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                widget.output['profImage'].toString(),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      widget.output['username'].toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                DateFormat.yMMMd().format(
                                    widget.output['datePublished'].toDate()),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 174, 168, 168),
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:350.0),
                          child: Text(
                            '${widget.output['description']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 80,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(27),
                                  color:
                                      const Color(0xffe5e5e5).withOpacity(0.5),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: widget.output['likes']
                                              .contains(user.uid)
                                          ? const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                              size: 22,
                                            )
                                          : const Icon(
                                              Icons.favorite_border,
                                              size: 22,
                                            ),
                                      onPressed: () =>
                                          FireStoreMethods().likePost(
                                        widget.output['postId'].toString(),
                                        user.uid,
                                        widget.output['likes'],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          DefaultTextStyle(
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w800),
                                            child: Text(
                                              '${widget.output['likes'].length}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 80,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(27),
                                  color:
                                      const Color(0xffe5e5e5).withOpacity(0.5),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CommentPage(
                                            userpostid: widget.output['postId']
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                      icon: const Icon(
                                        CupertinoIcons.chat_bubble_2_fill,
                                      ),
                                    ),
                                    InkWell(
                                      child: Container(
                                        child: Text(
                                          '$commentcount',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 80,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(27),
                                  color:
                                      const Color(0xffe5e5e5).withOpacity(0.5),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        final uri = Uri.parse(widget
                                            .output['postUrl']
                                            .toString());
                                        final res = await http.get(uri);
                                        final bytes = res.bodyBytes;
                                        final temp =
                                            await getTemporaryDirectory();
                                        final path = '${temp.path}/image.jpeg';
                                        File(path).writeAsBytesSync(bytes);

                                        await Share.shareFiles([path]);
                                      },
                                      icon: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, bottom: 20),
                                        child: Icon(
                                          CupertinoIcons.reply,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
