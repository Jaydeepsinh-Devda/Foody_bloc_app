class PlaceListModel {
  final int id;
  final String placeName;
  final String aboutPlace;
  final String placeLocation;
  final String placeDetail;
  final double reservationPrice;
  final String imageUrl;
  final String rating;
  final String review;
  final List<int> menuItems;

  const PlaceListModel(
      {required this.id,
      required this.placeName,
      required this.aboutPlace,
      required this.placeLocation,
      required this.placeDetail,
      required this.reservationPrice,
      required this.imageUrl,
      required this.rating,
      required this.review,
      required this.menuItems});
}
