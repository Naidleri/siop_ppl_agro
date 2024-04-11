import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:siop_ppl_agro/feat/sensor/model/repository.dart';
import 'package:siop_ppl_agro/feat/sensor/model/sensorData.dart';

part 'sensor_event.dart';
part 'sensor_state.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  final SensorRepository _sensorRepository;
  SensorBloc(this._sensorRepository) : super(SensorInitial()) {
    on<SensorEvent>((event, emit) async {
      if (event is getSensorData) {
        emit(SensorLoading());
        try {
          final data = await _sensorRepository.getSensorData(event.id);
          if (data != null) {
            emit(SensorLoaded(data));
          } else {
            emit(SensorDataError("error fetch sensor"));
          }
        } catch (error) {
          emit(SensorDataError(error.toString()));
        }
      }
    });
  }
}
