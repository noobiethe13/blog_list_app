import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BlogStatBar extends StatelessWidget {
  final int votes;
  final int comments;
  const BlogStatBar({super.key, required this.comments, required this.votes});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: Colors.black)),
          child: const Icon(
            CupertinoIcons.chevron_up,
            color: Colors.black,
            size: 6,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: Colors.black)),
          child: const Icon(
            CupertinoIcons.chevron_down,
            color: Colors.black,
            size: 6,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        //divider
        Container(
          width: 0.5,
          height: 14,
          color: Colors.grey[600],
        ),
        const SizedBox(
          width: 8,
        ),
        Row(
          children: [
            const Icon(
              CupertinoIcons.chevron_up,
              size: 8,
              color: Colors.black,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              votes.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        //divider
        Container(
          width: 0.5,
          height: 14,
          color: Colors.grey[600],
        ),
        const SizedBox(
          width: 8,
        ),
        Row(
          children: [
            const Icon(
              CupertinoIcons.chat_bubble_2,
              size: 12,
              color: Colors.black,
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              comments.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        //divider
        Container(
          width: 0.5,
          height: 14,
          color: Colors.grey[600],
        ),
        const SizedBox(
          width: 8,
        ),
        const Icon(
          CupertinoIcons.arrow_turn_up_right,
          color: Colors.black,
          size: 12,
        ),
      ],
    );
  }
}
