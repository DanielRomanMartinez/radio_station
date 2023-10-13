part of '../../../../radio_station_screen.dart';

class FavButton extends StatefulWidget {
  final RadioStation radioStation;

  const FavButton({
    super.key,
    required this.radioStation,
  });

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  final FavoriteRadioStationService _service =
      GetIt.instance.get<FavoriteRadioStationService>();

  final FavoriteScreenBloc _favoriteScreenBloc =
      GetIt.instance.get<FavoriteScreenBloc>();

  late bool isFavorite = false;

  double ratio = 1.0;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reset();
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RadioStation?>(
      future: _service.read(widget.radioStation.id),
      builder: (context, snapshot) {
        isFavorite = snapshot.data != null;
        return Stack(
          children: [
            FadeTransition(
              opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
                  CurvedAnimation(
                      parent: animationController,
                      curve: Curves.fastLinearToSlowEaseIn)),
              child: SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(0.0, 0.0),
                        end: const Offset(0.0, -1.0))
                    .animate(CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  parent: animationController,
                )),
                child: Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: const Color(0xFFF5897F),
                    size: 30 * ratio,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  ratio = 1.0;
                  isFavorite = !isFavorite;
                });

                animationController.forward();

                Fluttertoast.showToast(
                  msg: isFavorite
                      ? "Added to favourites"
                      : "Removed from favourites",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: const Color(0xFFF5897F),
                );

                isFavorite
                    ? _favoriteScreenBloc
                        .add(AddFavorite(radioStation: widget.radioStation))
                    : _favoriteScreenBloc
                        .add(RemoveFavorite(id: widget.radioStation.id));
              },
              child: Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: const Color(0xFFF5897F),
                  size: 30 * ratio,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
