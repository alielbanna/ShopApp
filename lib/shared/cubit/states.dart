import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/profile_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavouritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingFavoritesState extends ShopStates {}

class ShopSuccessFavoritesState extends ShopStates {}

class ShopErrorFavoritesState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  final ProfileModel profileModel;

  ShopSuccessUserDataState(this.profileModel);
}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {
  final ProfileModel profileModel;

  ShopSuccessUpdateUserDataState(this.profileModel);
}

class ShopErrorUpdateUserDataState extends ShopStates {}
