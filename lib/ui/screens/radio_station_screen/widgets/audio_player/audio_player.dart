part of '../../radio_station_screen.dart';

class AudioPlayer extends StatelessWidget {
  final bool? isLoading;
  final RadioStation radioStation;
  final AudioPlayerBloc bloc;

  const AudioPlayer({
    super.key,
    this.isLoading = false,
    required this.radioStation,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                bloc: bloc,
                builder: (context, state) {
                  return Waves(isPlaying: state is AudioPlaying);
                },
              ),
              ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(95), // Image radius
                  child: Image.network(radioStation.image, fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            radioStation.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Radio from: ${radioStation.country.name}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Genre: ${radioStation.genre}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is AudioLoading) {
                    return const LoadingBtn();
                  } else if (state is AudioPaused || state is AudioPlaying) {
                    return PlayPauseBtn(
                      isPlaying: state is AudioPlaying,
                      bloc: bloc,
                    );
                  } else if (state is AudioError) {
                    Fluttertoast.showToast(
                      msg: "Something wrong happened, try again.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: const Color(0xFFdc3545),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              Positioned(
                right: (MediaQuery.of(context).size.width - 40) / 5,
                child: FavButton(
                  radioStation: radioStation,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
