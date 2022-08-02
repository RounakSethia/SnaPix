import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentSnapix extends StatelessWidget {
  final output2;
  const CommentSnapix({Key? key, required this.output2}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              output2.data()['profilePic'],
            ),
            radius: 24,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: output2.data()['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold,)
                        ),
                        TextSpan(
                          text: ' ${output2.data()['text']}',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd().format(
                        output2.data()['datePublished'].toDate(),
                      ),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400,),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.all(8),
          //   child: const Icon(
          //     Icons.favorite,
          //     size: 16,
          //   ),
          // )
        ],
      ),
    );
  }
}