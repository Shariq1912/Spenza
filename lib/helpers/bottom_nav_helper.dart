enum ScreenName {
  home,
  myList,
  receipts,
  settings,
}

// Define a map that maps screen names to their corresponding indexes
final Map<ScreenName, int> screenNameToIndex = {
  ScreenName.home: 0,
  ScreenName.myList: 1,
  ScreenName.receipts: 2,
  ScreenName.settings: 3,
};
