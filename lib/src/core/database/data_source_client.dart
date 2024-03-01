abstract class DataSourceClient {
  Future<void> update(String docPath, Map<String, dynamic> data);

  Future<void> add(String colPath, Map<String, dynamic> data);

  Future<Map<String, dynamic>?> get(String path);

  Future<Map<String, Map<String, dynamic>>?> getList(String path);
}
