import 'package:wechat_assets_picker/wechat_assets_picker.dart';

/// [AssetsPickerTextDelegate] implements with Vietnamese.
/// Vietnamese Localization
class VietnameseTextDelegate extends AssetPickerTextDelegate {
  @override
  String get confirm => 'Xác nhận';

  @override
  String get cancel => 'Huỷ';

  @override
  String get edit => 'Chỉnh sửa';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get loadFailed => 'Tải lên thất bại';

  @override
  String get original => 'Tệp gốc';

  @override
  String get preview => 'Xem trước';

  @override
  String get select => 'Chọn';

  @override
  String get emptyList => 'Danh sách rỗng';

  @override
  String get unSupportedAssetType => 'Định dạng chưa được hỗ trợ.';

  @override
  String get unableToAccessAll =>
      'Không thể truy cập tất cả nội dung trên thiết bị';

  @override
  String get viewingLimitedAssetsTip =>
      'Chỉ xem nội dung và album có thể truy cập vào ứng dụng.';

  @override
  String get changeAccessibleLimitedAssets =>
      'Cập nhật danh sách nội dung truy cập hạn chế ';

  @override
  String get accessAllTip =>
      'Ứng dụng chỉ có thể truy cập một số nội dung trên thiết bị. '
      'Đi tới cài đặt hệ thống và cho phép ứng dụng truy cập tất cả nội dung trên thiết bị.';

  @override
  String get goToSystemSettings => 'Đi tới cài đặt hệ thống';

  @override
  String get accessLimitedAssets => 'Tiếp tục với quyền truy cập hạn chế ';

  @override
  String get accessiblePathName => 'Nội dung có thể truy cập ';
}
