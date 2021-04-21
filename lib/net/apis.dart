class Apis {

  static const String ERRNO = 'err_code';
  static const String MESSAGE = 'msg';
  static const String ERRNO_OK = "0";
  static const String ERRNO_DIO_ERROR = "DIOERROR";
  static const String ERRNO_UNKNOWN = "UNKNOWN";
  static const String ERRNO_UNKNOWN_MESSAGE = "UNKNOWN MESSAGE";
  static const String ERRNO_FORBIDDEN = "20000";

  static const String KEY_VER = "lh-Ver";
  static const String KEY_DEV = "lh-Dev";
  static const String KEY_DEVICE_ID = "lh-DeviceId";
  static const String KEY_LANGUAGE = "lh-Language";
  static const String KEY_CHANNEL = "lh-Channel";
  static const String KEY_USER_TOKEN = "lh-Token";
  static const String KEY_USER_TS = "lh-Ts";
  static const String KEY_USER_U_ID = "lh-Uid";
  static const String KEY_USER_SIGN = "lh-Sign";

  static const String PRIVATE_KEY = "5ffF03b858D5Fd16";       //测试环境
  static const String BASE_URL_YAPI = 'http://81.70.145.64/backstage';  //测试环境

  static bool get isTestEnvironment => (BASE_URL_YAPI == 'http://81.70.145.64/backstage');

  static const String URL_LOGIN = '/login';
  static const String URL_TOKEN_DELAY = '/token_delay';
  static const String URL_ACCOUNT_PAGE = '/account/page';

  static const String URL_CHAIN_LIST = '/chain_info/list';
  static const String URL_CHAIN_CHANGE_STATUS = '/chain_info/change_status';
  static const String URL_CHAIN_ADD = '/chain_info/add';
  static const String URL_CHAIN_EDIT = '/chain_info/edit';

  static const String URL_EXCHANGE_LIST = '/exchange/list';
  static const String URL_EXCHANGE_CHANGE_STATUS = '/exchange/change_status';
  static const String URL_EXCHANGE_ADD = '/exchange/add';
  static const String URL_EXCHANGE_EDIT = '/exchange/edit';

  static const String URL_FRIEND_LIST = '/friend_link/list';
  static const String URL_FRIEND_CHANGE_STATUS = '/friend_link/change_status';
  static const String URL_FRIEND_ADD = '/friend_link/add';
  static const String URL_FRIEND_EDIT = '/friend_link/edit';

  static const String URL_TAG_LIST = '/tag/list';
  static const String URL_TAG_CHANGE_STATUS = '/tag/change_status';
  static const String URL_TAG_ADD = '/tag/add';
  static const String URL_TAG_EDIT = '/tag/edit';

  static const String URL_MILESTONE_LIST = '/milestone/list';
  static const String URL_MILESTONE_CHANGE_STATUS = '/milestone/change_status';
  static const String URL_MILESTONE_ADD = '/milestone/add';
  static const String URL_MILESTONE_EDIT = '/milestone/edit';

  static const String URL_QUOTE_GLOBAL = '/quote/global_quote';
  static const String URL_QUOTE = '/quote/quote';
  static const String URL_QUOTE_TREEMAP = '/quote/thermodynamic_diagram';

  static const String URL_SMS_PAGE = '/sms_record/page';
  static const String URL_SMS_TYPE = '/sms_record/sms_type';

  static const String URL_OFFICIAL_WEBSITE = 'https://www.blockdt.com';
}