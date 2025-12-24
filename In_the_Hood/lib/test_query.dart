import 'package:amplify_flutter/amplify_flutter.dart';
import 'models/Neighborhood.dart';

Future<void> fetchNeighborhoods() async {
  try {
    final request = ModelQueries.list(Neighborhood.classType);
    final response = await Amplify.API.query(request: request).response;

    if (response.data != null) {
      for (final hood in response.data!.items) {
        safePrint('🏙️ Neighborhood: ${hood!.name} - ${hood.city}');
      }
    } else {
      safePrint('No data found');
    }
  } catch (e) {
    safePrint('Error fetching neighborhoods: $e');
  }
}
