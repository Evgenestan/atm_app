  import 'package:flutter/services.dart';
  enum Asset {
      _stub,
    
}

final Map<Asset, String> _assetEnumMap = {

};

class Assets {
String get bottomBackground => bottomBackgroundS;
static const String bottomBackgroundS = 'assets/image/bottom_background.svg';
String get upBackground => upBackgroundS;
static const String upBackgroundS = 'assets/image/up_background.svg';
String get logoImage => logoImageS;
static const String logoImageS = 'assets/image/logo_image.svg';
    final Map<Asset, String> _preloadedAssets = Map();
    bool isPreloaded = false;
    Future<bool> preloadAssets() async {
      final List<Future> loaders = [];
      loadAsset(Asset asset) async {        
        final String assetContent = await rootBundle.loadString(_assetEnumMap[asset], cache: false);
        _preloadedAssets[asset] = assetContent;
      }
      for (Asset assetEnumField in Asset.values) {
        loaders.add(loadAsset(assetEnumField));
      }
      await Future.wait<void>(loaders);
      isPreloaded = true;
      return isPreloaded;
    }
    String getAssetData(Asset assetEnum) {
      if (!isPreloaded) {
        throw Exception('You should run method "preloadAssets" before accessing data with "getAssetData" method');
      }
      return _preloadedAssets[assetEnum];
    }
}