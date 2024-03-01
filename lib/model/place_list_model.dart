class PlaceListModel {
  final int id;
  final String placeName;
  final String placeLocation;
  final String placeDetail;
  final String imageUrl;
  final String rating;
  final String review;

  const PlaceListModel(
      {required this.id,
      required this.placeName,
      required this.placeLocation,
      required this.placeDetail,
      required this.imageUrl,
      required this.rating,
      required this.review});
}
