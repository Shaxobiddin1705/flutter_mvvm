abstract class BaseApiServices{
  Future<dynamic> getApiResponse(String url, dynamic param);

  Future<dynamic> postApiResponse(String url, dynamic param);

  Future<dynamic> putApiResponse(String url, dynamic param);

  Future<dynamic> deleteApiResponse(String url, dynamic param);
}