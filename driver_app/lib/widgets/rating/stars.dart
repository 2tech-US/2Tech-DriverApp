import 'package:flutter/material.dart';

class StarsWidget extends StatelessWidget {
  const StarsWidget({Key? key, required this.numberOfStars}) : super(key: key);
  final int numberOfStars;

  @override
  Widget build(BuildContext context) {
    if (numberOfStars == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          )
        ],
      );
    } else if (numberOfStars == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          )
        ],
      );
    } else if (numberOfStars == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, color: Colors.amber),
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          )
        ],
      );
    } else if (numberOfStars == 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, color: Colors.amber),
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          const Icon(Icons.star, color: Colors.amber),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          )
        ],
      );
    } else if (numberOfStars == 4) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, color: Colors.amber),
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          const Icon(Icons.star, color: Colors.amber),
          const Icon(Icons.star, color: Colors.amber),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.star, color: Colors.amber),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(Icons.star, color: Colors.amber),
          Icon(Icons.star, color: Colors.amber),
          Icon(Icons.star, color: Colors.amber)
        ],
      );
    }
  }
}
