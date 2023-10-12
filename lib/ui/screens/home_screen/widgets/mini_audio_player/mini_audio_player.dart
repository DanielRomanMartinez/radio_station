part of '../../home_screen.dart';

class MiniAudioPlayer extends StatelessWidget {
  final AudioPlayerBloc _audioPlayerBloc =
      GetIt.instance.get<AudioPlayerBloc>();

  MiniAudioPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      bloc: _audioPlayerBloc,
      builder: (context, state) {
        if (state is AudioPlayerLoaded &&
            (state is AudioPlaying || state is AudioPaused)) {
          return Positioned(
            bottom: 10,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: <Color>[
                    Color(0xFFF5897F),
                    Color(0xFFFF98A2),
                    Color(0xFFFFA9C8),
                    Color(0xFFFFBEF0),
                  ],
                  tileMode: TileMode.mirror,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(
                left: 10,
                top: 10,
                right: 10,
                bottom: 5,
              ),
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      state.radioStation.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    state.radioStation.name.length > 15
                        ? '${state.radioStation.name.substring(0, 15)}...'
                        : state.radioStation.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  if (state is AudioLoading) const LoadingBtn(iconSize: 32),
                  if (state is AudioPaused || state is AudioPlaying)
                    PlayPauseBtn(
                      isPlaying: state is AudioPlaying,
                      bloc: _audioPlayerBloc,
                      iconSize: 32,
                      hasBackgroundColor: false,
                    ),
                  const SizedBox(width: 20),
                  StopBtn(
                    bloc: _audioPlayerBloc,
                    iconSize: 14,
                  )
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
