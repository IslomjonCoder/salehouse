import 'package:faker/faker.dart';

final List<ClientModel> mockData = List.generate(
    100,
    (index) => ClientModel(
        name: faker.person.name(),
        homeName: faker.company.name(),
        homeNumber: faker.randomGenerator.integer(100)));

class MockData {
  static List<String> searchHistory = [];

  static List<ClientModel> filter(String query) {
    return mockData
        .where((element) => element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

class ClientModel {
  String name;
  String homeName;
  int homeNumber;

  ClientModel({
    required this.name,
    required this.homeName,
    required this.homeNumber,
  });
}
