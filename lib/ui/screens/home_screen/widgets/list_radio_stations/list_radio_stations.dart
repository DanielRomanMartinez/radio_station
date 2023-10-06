part of '../../home_screen.dart';

class ListRadioStations extends StatefulWidget {
  const ListRadioStations({
    super.key,
  });

  @override
  State<ListRadioStations> createState() => _ListRadioStationsState();
}

class _ListRadioStationsState extends State<ListRadioStations> {
  final HomeScreenBloc _homeScreenBloc = GetIt.instance.get<HomeScreenBloc>();
  final AudioPlayerBloc _audioPlayerBloc =
      GetIt.instance.get<AudioPlayerBloc>();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: BlocBuilder<HomeScreenBloc, RadioStationScreenState>(
          bloc: _homeScreenBloc,
          builder: (context, state) {
            if (state is RadioStationsLoaded) {
              return Column(
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.75,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    children: List.generate(
                      state.radioStations.length,
                      (index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () => Navigator.of(context).pushNamed(
                                RadioStationScreen.routeName,
                                arguments: RadioStationScreenParameters(
                                  radioStation: state.radioStations[index],
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        state.radioStations[index].image,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    state.radioStations[index].name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                    bloc: _audioPlayerBloc,
                    builder: (context, audioPlayerState) {
                      if (audioPlayerState is AudioPlayerLoaded &&
                          (audioPlayerState is AudioPlaying ||
                              state is AudioPaused)) {
                        return const SizedBox(height: 80);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              );
            } else if (state is RadioStationScreenInitial) {
              _homeScreenBloc.add(const LoadRadioStations());
            }
            return const Center(
              child: Text('Loading...'),
            );
          },
        ),
      ),
    );
  }
}
