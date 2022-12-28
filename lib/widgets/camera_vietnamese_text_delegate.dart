import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class CameraVietnamTextDelegate extends CameraPickerTextDelegate {
  @override
  String get confirm => 'Xác nhận';

  @override
  String get shootingTips => 'Nhấn để chụp ảnh';

  @override
  String get loadFailed => 'Tải lên thất bại';
}
