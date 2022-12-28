const ANDROID_VERSION_APP = '1.3.10';
const ANDROID_VERSION_NUMBER = 20;
const IOS_VERSION_APP = '1.3.10';
const IOS_VERSION_NUMBER = 20;
const SECRET_KEY = 'dev';
const IAP_SECRET_KEY = 'cJg4NJMCcJg4NJMC';
const SMART_LOOK_API_KEY = 'dc6600fbfdd2086be103b821071b297417d5b2e7';

const LIGHT_THEME = 'light_theme';
const DARK_THEME = 'dark_theme';
const BASE_WIDTH = 414.0;
const MAX_WIDTH = 400.0;
const PRE_MXV_ACCOUNT = '032C';
const DEFAULT_LANG = 'vi';
const ABOUT_US = 'https://oke_car_flutter.vn/gioi-thieu?t=mobile';
const PRICECAR = 'https://oke_car_flutter.vn/gia-xe-oto?t=mobile';
const FAG = 'https://oke_car_flutter.vn/tro-giup?t=mobile';
const TERM = 'https://oke_car_flutter.vn/quy-che-hoat-dong?t=mobile';
const CONTACT = 'https://oke_car_flutter.vn/contact?t=mobile';
const tragop = 'https://oke_car_flutter.vn/khoanvay?t=mobile';

const LANG_ENGLISH = 'en';
const LANG_GERMAN = 'gm';
const LANG_KOREAN = 'kr';
const LANG_JAPANESE = 'jp';
const LANG_CHINESE = 'cn';
const LANG_SPANISH = 'sp';
const LANG_FRENCH = 'fr';
const LANG_RUSSIAN = 'ru';
const LANG_VIETNAMESE = 'vi';
const LANG_TURKISH = 'tu';

const List<String> FILTER_BY_STATUS = [
  IS_BLOCKED,
  PENDING,
  CANCEL,
  APPROVED,
  CONFIRMING,
  DONE
];

const IS_BLOCKED = 'IS_BLOCKED';
const PENDING = 'PENDING';
const CANCEL = 'CANCEL';
const APPROVED = 'APPROVED';
const CONFIRMING = 'CONFIRMING';
const DONE = 'DONE';
const List<String> LIST_LANGUAGE = [
  LANG_ENGLISH,
//  LANG_GERMAN,
//  LANG_KOREAN,
//  LANG_JAPANESE,
//  LANG_CHINESE,
//  LANG_SPANISH,
//  LANG_FRENCH,
//  LANG_RUSSIAN,
  LANG_VIETNAMESE,
//  LANG_TURKISH
];

const List<String> LIST_ORIGIN = [
  'DOMESTIC',
  'IMPORT',
];

const List<String> LIST_CAR_STATUS = [
  'OLD',
  'NEW',
];

const List<String> LIST_GEAR = ['Số tay', 'Số tự động', 'Số hỗn hợp'];
const List<String> FULE = ['Xăng', 'Diesel', 'Hybrid'];

const List<String> COLORS = [
  'Màu xanh',
  'Màu đỏ',
  'Màu xanh lá',
  'Màu vàng',
  'Màu tím',
  'Màu hồng',
  'Màu nâu',
  'Màu đen',
];

const String BORDER_LEFT = 'left';
const String BORDER_RIGHT = 'right';

const String PERMISSION_GRANTED = 'granted';
const String PERMISSION_DENIED = 'denied';
const String PERMISSION_UNKNOWN = 'unknown';

const String TRUE = 'true';
const String FALSE = 'false';

const int RESEND_OTP = 90;

const String API_ANDROID_KEY = 'AIzaSyCfFtIsKFfRT4133-3oBUTLGA7Jfb5zmb4';
const String API_IOS_KEY = 'AIzaSyCfFtIsKFfRT4133-3oBUTLGA7Jfb5zmb4';

const String GENDER_MALE = 'male';
const String GENDER_FEMALE = 'female';

const int FRACTION_DIGIT_TOKEN = 6;

const String TYPE_ORDER_BUY = 'buy';
const String TYPE_ORDER_SELL = 'sell';

const String TRANSFER_TYPE_TO_TRADING = 'transfer_to_trading';
const String TRANSFER_TYPE_TO_CASH = 'transfer_to_cash';

const String ACCOUNT_MODE_REAL = 'real';
const String ACCOUNT_MODE_VIRTUAL = 'virtual';
const String BRANCH = 'branch';
const String SUB = 'sub';
const String RATE_APP_IOS =
    'https://apps.apple.com/app/id1560816565?action=write-review';
const String RATE_APP_ANDROID =
    'https://play.google.com/store/apps/details?id=vn.hitrade.trade';
const String APP_STORE_ID = '1560816565';
const List<String> LIST_CITY = [
  'An Giang',
  'Bà Rịa - Vũng Tàu',
  'Bắc Giang',
  'Bắc Kạn',
  'Bạc Liêu',
  'Bắc Ninh',
  'Bến Tre',
  'Bình Định',
  'Bình Dương',
  'Bình Phước',
  'Bình Thuận',
  'Cà Mau',
  'Cao Bằng',
  'Cần Thơ',
  'Đà Nẵng',
  'Đắk Lắk',
  'Đắk Nông',
  'Điện Biên',
  'Đồng Nai',
  'Đồng Tháp',
  'Gia Lai',
  'Hà Giang',
  'Hà Nam',
  'Hà Nội',
  'Hà Tĩnh',
  'Hải Dương',
  'Hải Phòng',
  'Hậu Giang',
  'Hòa Bình',
  'Hưng Yên',
  'Khánh Hòa',
  'Kiên Giang',
  'Kon Tum',
  'Lai Châu',
  'Lâm Đồng',
  'Lạng Sơn',
  'Lào Cai',
  'Long An',
  'Nam Định',
  'Nghệ An',
  'Ninh Bình',
  'Ninh Thuận',
  'Phú Thọ',
  'Quảng Bình',
  'Quảng Nam',
  'Quảng Ngãi',
  'Quảng Ninh',
  'Quảng Trị',
  'Sóc Trăng',
  'Sơn La',
  'Tây Ninh',
  'Thái Bình',
  'Thái Nguyên',
  'Thanh Hóa',
  'Hồ Chí Minh',
  'Thừa Thiên Huế',
  'Tiền Giang',
  'Trà Vinh',
  'Tuyên Quang',
  'Vĩnh Long',
  'Vĩnh Phúc',
  'Yên Bái',
  'Phú Yên',
];

List<int> LIST_CAR_CATEGORY = [0, 1];
List<int> listSimple = [0, 1, 2, 3, 4, 5, 6];

List<String> LIST_YEAR = [
  "2022",
  "2021",
  "2020",
  "2019",
  "2018",
  "2017",
  "2016",
  "2015",
  "2014",
  "2013",
  "2011",
  "2010",
  "2009",
  "2008",
  "2007",
  "2006",
  "2005",
  "2004",
  "2003",
  "2002",
  "2001",
  "2000",
  "1999",
  "1998",
  "1997",
  "1996",
  "1995",
  "1994",
  "1993",
  "1992",
  "1991",
  "1990",
  "1989",
  "1988",
  "1987",
  "1986",
  "1985",
  "1984",
  "1983",
  "1982",
  "1981",
  "1980",
];
