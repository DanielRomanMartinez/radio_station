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
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                border: Border(
                  top: BorderSide(
                    width: 2,
                    color: Color(0xFFF5897F),
                  ),
                ),
              ),
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
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
                    iconSize: 12,
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
