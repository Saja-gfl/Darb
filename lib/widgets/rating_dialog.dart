import 'package:flutter/material.dart';

class RatingDialog extends StatefulWidget {
  final Function(int, String) onRatingSubmitted;

  const RatingDialog({Key? key, required this.onRatingSubmitted})
      : super(key: key);

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 5;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('قيم العميل', textAlign: TextAlign.right),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('كم نجمة تعطي لهذا العميل؟', textAlign: TextAlign.right),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 30,
                ),
                onPressed: () => setState(() => _rating = index + 1),
              );
            }),
          ),
          const SizedBox(height: 20),
          const Text('اكتب تعليقاً (اختياري)', textAlign: TextAlign.right),
          TextField(
            controller: _commentController,
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onRatingSubmitted(_rating, _commentController.text);
            Navigator.pop(context);
          },
          child: const Text('إرسال التقييم'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
