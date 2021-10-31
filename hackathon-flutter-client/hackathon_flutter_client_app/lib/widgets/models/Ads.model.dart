class Ads {
  String imageUrl;
  double width;
  double height;
  String title;
  //
  Ads(this.imageUrl, this.width, this.height, this.title);
  // 
  static final List<Ads> FeaturedAdsDB = [
      Ads('assets/iphone.jpeg', 400, 200, 'IPhone'),
      Ads('assets/macbook-pro-m1.jpg', 400, 400, 'Macbook Pro M1'),
      Ads('assets/macbook-air-m1.jpeg', 400, 400, 'Macbook Air M1'),
      Ads('assets/gaming-pc.jpeg', 400, 400, 'Gaming PC'),
      Ads('assets/laptop.jpeg', 400, 400, 'Laptop'),
      Ads('assets/macbook.jpeg', 400, 400, 'Macbook Pro'),
  ];

  static final List<Ads> allAdsDB = [
      Ads('assets/iphone.jpeg', 400, 400, 'IPhone'),
      Ads('assets/macbook-pro-m1.jpg', 400, 400, 'Macbook Pro M1'),
      Ads('assets/macbook-air-m1.jpeg', 400, 400, 'Macbook Air M1'),
      Ads('assets/gaming-pc.jpeg', 400, 400, 'Gaming PC'),
      Ads('assets/laptop.jpeg', 400, 400, 'Laptop'),
      Ads('assets/macbook.jpeg', 400, 400, 'Macbook Pro'),
      Ads('assets/iphone.jpeg', 400, 400, 'Laptop'),
      Ads('assets/macbook.jpeg', 400, 400, 'Macbook Pro'),
  ];
}