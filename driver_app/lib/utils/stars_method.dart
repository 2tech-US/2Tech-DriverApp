import 'package:driver_app/widgets/rating/stars.dart';

stars({required int votes, required double rating}) {
  if (votes == 0) {
    return const StarsWidget(
      numberOfStars: 0,
    );
  } else {
    double finalRate = rating / votes;
    return StarsWidget(
      numberOfStars: finalRate.floor(),
    );
  }
}
