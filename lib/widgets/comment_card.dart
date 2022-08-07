import 'package:flutter/material.dart';
import 'package:learningdart/models/user.dart';
import 'package:learningdart/providers/user_provider.dart';
import 'package:learningdart/resources/firestore_methods.dart';
import 'package:learningdart/widgets/like_animation.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profilePic']),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: widget.snap['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' ${widget.snap['text']}',
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      timeago.format(DateTime.parse(
                          widget.snap['datePublished'].toDate().toString())),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: LikeAnimation(
                isAnimating: widget.snap['likes'].contains(widget.snap['uid']),
                smallLike: true,
                child: IconButton(
                  onPressed: () async {
                    await FirestoreMethods().likeCommend(
                      widget.snap['postId'].toString(),
                      widget.snap['uid'],
                      widget.snap['likes'],
                      widget.snap['commentId'],
                    );
                  },
                  icon: widget.snap['likes'].contains(widget.snap['uid'])
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(Icons.favorite_border),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
