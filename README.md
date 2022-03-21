# wasteagram

Portfolio project for mobile development class at Oregon State University. Mobile app designed for Andriod written with Flutter SDK in dart.  Designed to track leftover products from a bakery at the end of each day in order to provide insight to owner allowing for inventory adjustments. 
The app has the following functionality:
  -a tile list of scrollable previous records
    *ordered with most recent at the top
    *shows avatar photo of previous wasted product along with date of record and number of wasted products.
  -a firestore database and firebase storage to keep previous record info and pictures.
  -ability to add new records including count of wasted items and photo of wasted items from device photos by user.  Date of created record along with 
    latitutude/longitude are automatically added to each submission.
  -data in submission form is validated to confirm is fits requirments such as blank submissions not allowed and user data for count must be numerical.
  -tiles in submission lists can be pressed for addtional information regarding each record.
  -app navigation applied to direct users through app experience in a logical way. 
