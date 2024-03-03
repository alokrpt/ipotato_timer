import 'data_source_client.dart';

class DataSourceClientImpl implements DataSourceClient {
  @override
  Future<void> add(String colPath, Map<String, dynamic> data) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> get(String path) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Map<String, Map<String, dynamic>>?> getList(String path) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future<void> update(String docPath, Map<String, dynamic> data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
