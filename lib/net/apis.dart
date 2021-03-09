class Apis {

  static const String ERRNO = 'errno';
  static const String MESSAGE = 'msg';
  static const String ERRNO_OK = "10000";
  static const String ERRNO_DIO_ERROR = "DIOERROR";
  static const String ERRNO_UNKNOWN = "UNKNOWN";
  static const String ERRNO_UNKNOWN_MESSAGE = "UNKNOWN MESSAGE";
  static const String ERRNO_FORBIDDEN = "FORBIDDEN";

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

  static const String URL_OFFICIAL_WEBSITE = 'https://www.blockdt.com';
}