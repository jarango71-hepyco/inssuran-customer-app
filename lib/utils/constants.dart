import 'package:flutter/cupertino.dart';

class Consts {
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

  // Domain
  static const String appDomain = 'https://qa-back.inssuran.com';

    // Main
  static const String S_APP_TITLE = "INSSURAN";
  static const String S_HOME_TITLE = "Inicio";
  static const String S_PAGE_POLICIES_TITLE = "Pólizas";
  static const String S_PAGE_INSUREDS_TITLE = "Asegurados";
  static const String S_PAGE_CONTRACTORS_TITLE = "Contratantes";
  static const String S_PAGE_COLLECTION_TITLE = "Cobranzas";
  static const String S_PAGE_INSURED_TITLE = "Asegurados";
  static const String S_PAGE_PROVIDERS_TITLE = "Compañias";

  static const String S_PAGE_DETAIL_POLICY_TITLE = "Datos de la póliza";
  static const String S_PAGE_DETAIL_AFFILIATE_TITLE = "Datos del afiliado";
  static const String S_PAGE_DETAIL_VEHICLE_TITLE = "Datos del vehículo";
  static const String S_PAGE_DETAIL_CONTRACTOR_TITLE = "Datos del contratador";
  static const String S_PAGE_DETAIL_PROVIDER_TITLE = "Datos de la compañia";

  static const String S_AFFILIATES = "Afiliados";
  static const String S_VEHICLE = "Vehículos";
  static const String S_POLICIES_EMPTY = "No hay afiliados";
  static const String S_ITEMS_EMPTY = "No hay elementos";

  // Menú
  static const String S_SEARCH = "Buscar...";

  static const String S_PROFILE = "Perfil";
  static const String S_COMPANIES = "Compañías";
  static const String S_NOTIFICATIONS = "Notificaciones";
  static const String S_HELP = "Ayuda";
  static const String S_ABOUT = "Acerca de...";
  static const String S_SESSIONCLOSE = "Cerrar session";
  static const String S_EXIT = "Salir";

  // Login
  static const String S_WELCOME1 = "Bienvenido a";
  static const String S_WELCOME2 = "INSSURAN";
  static const String S_WELCOME3 = "LA RED DE OPERADORES Y CLIENTES";
  static const String S_WELCOME4 = "CLUB";

  static const String S_TITLE_LOGIN = "Iniciar sessión";
  static const String S_USERNAME = "Nombre de usuario";
  static const String S_USERNAME_HINT = "Nombre de usuario";
  static const String S_USERNAME_MINLENGTH = "El nombre de usuario debe tener al menos 4 characteres";
  static const String S_USERNAME_MAXLENGTH = "El nombre de usuario debe tener un máximo de 100 characteres";
  static const int I_USERNAME_MINLENGTH = 4;
  static const int I_USERNAME_MAXLENGTH = 100;
  static const String S_PASSWORD = "Contraseña";
  static const String S_PASSWORD_HINT = "Contraseña de usuario";
  static const String S_PASSWORD_MINLENGTH = "La contraseña debe tener al menos 8 characteres";
  static const String S_PASSWORD_MAXLENGTH = "La contraseña debe tener un máximo de 50 characteres";
  static const int I_PASSWORD_MINLENGTH = 8;
  static const int I_PASSWORD_MAXLENGTH = 50;
  static const String S_FORGOT_PASSWORD = "¿Olvidaste la contraseña?";
  static const String S_REQUIRED_USERNAME = "El nombre de usuario es requerido";
  static const String S_REQUIRED_PASSWORD = "La contraseña es requerida";
  static const String S_EMAIL = "Correo electrónico";
  static const String S_REQUIRED_EMAIL = "El correo electrónico es requerido";
  static const String INVALID_EMAIL = "El correo electrónico no es válido";

  static const String S_IDENTIFICACION = "Identificación";
  static const String S_IDENTIFICACION_MINLENGTH = "La identificación debe tener al menos 4 characteres";
  static const String S_IDENTIFICACION_MAXLENGTH = "La identificación debe tener un máximo de 20 characteres";
  static const int I_IDENTIFICACION_MINLENGTH = 4;
  static const int I_IDENTIFICACION_MAXLENGTH = 20;
  static const String S_REQUIRED_IDENTIFICACION = "La identificación es requerido";
  static const String S_PIN = "PIN";

  static const String S_NOTIFICATIONCHANNEL_ID = "high_importance_channel";
  static const String S_NOTIFICATIONCHANNEL_NAME = "Notificaciones de alta importancia";
  static const String S_NOTIFICATIONCHANNEL_DESCRIPTION = "Canal usado para notificaciones importantes.";

  // Buttons
  static const String S_BTN_YES = "Sí";
  static const String S_BTN_NO = "No";
  static const String S_BTN_OK = "Aceptar";
  static const String S_BTN_SAVE = "Guardar";
  static const String S_BTN_CANCEL = "Cancelar";
  static const String S_BTN_CLEAN = "Quitar";
  static const String S_BTN_CONTINUE = "Continuar";
  static const String S_BTN_VERIFY = "Verificar";
  static const String S_BTN_NEXT = "Siguiente";
  static const String S_BTN_PREV = "Anterior";
  static const String S_BTN_END = "Finalizar";
  static const String S_BTN_RETRY = "Reintentar";
  static const String S_BTN_LOGIN = "Iniciar sessión";
  static const String S_BTN_REGISTER = "Registrase";
  static const String S_BTN_SCHEDULE = "Agendar";
  static const String S_BTN_GO = "Cómo llegar";
  static const String S_BTN_FIND = "Buscar";
  static const String S_BTN_START = "Empezar";
  static const String S_BTN_READY = "Listo";
  static const String S_BTN_BACK = "Volver";
  static const String S_BTN_SESSIONINIT = "Iniciar Sesión";
  static const String S_BTN_SESSIONCLOSE = "Cerrar sesión";
  static const String S_BTN_HELP = "Ayuda";
  static const String S_BTN_MAINMENU = "Menú Principal";
  static const String LINK_TRYAGAIN = "Volver a intentar";
  static const String LINK_OK = "Aceptar";
  static const String LINK_YES = "Sí";
  static const String LINK_NO = "No";

  // Alert Dialog
  static const String S_ALRDLG_HEADER_MSG = "Mensaje";
  static const String S_ALRDLG_HEADER_ERROR = "Error";
  static const String S_ALRDLG_HEADER_WARNING = "Aviso";
  static const String S_ALRDLG_BODY_ERROR_LOGIN = "inválido nombre de usuario o contraseña";
  static const String S_ALRDLG_BODY_ERROR_NOTCONNECTED = "No hay conexión a internet";
  static const String S_ALRDLG_BODY_REQUIRED = "Debe introducir la información requerida";
  static const String S_ALRDLG_BODY_WARNING_USERNAME_EMPTY = "Debe especificar el nombre de usuario";
  static const String S_ALRDLG_BODY_OK_CHANGEPASSWORD = "La contraseña ha sido cambiada con éxito";
  static const String S_ALRDLG_BODY_ERROR_CHANGEPASSWORD = "Ha ocurrido un error cambiando la contraseña";
  static const String S_ALRDLG_BODY_WARNING_USERNAME = "El nombre de usuario especificado no existe";
  static const String S_ALRDLG_HEADER_CHANGEPASSWORD = "Cambiar contraseña";

  static const String S_IMG_PATH = 'assets/images/';
  static const String ERROR_MSG_FETCH_DATA_EXCEPTION = "Ocurrió un error de conexión, por favor vuelve a intentarlo";
  static const String ERROR_MSG_UNAUTHORIZED_EXCEPTION = "Ha ocurrido un error al iniciar sesión";
  static const String ERROR_LOGIN_MSG = "Los datos de acceso son incorrectos";
  static const String ERROR_HASTNOPARTNER_MSG = "Debe completar el registro";

  // Sign off
  static const String SIGNOFF_TITLE = "Estás cerrando sesión. Pediremos tus datos la próxima ocasión que abras la app.";
  static const String SIGNOFF_CLOSE = "Cerrar sesión";
  static const String SIGNOFF_CLOSEALL = "Cerrar en todos los dispositivos";
  static const String SIGNOFF_CANCEL = "Cancelar";
  static const String SIGNOFF_CHECKBOX = "Entendido, no volver a avisarme";

  //
  static const String POLICIES_ERROR_MSG = "Ha ocurrido un error al listar las pólizas";
  static const String INSUREDS_ERROR_MSG = "Ha ocurrido un error al listar los afiliados";
  static const String VEHICLES_ERROR_MSG = "Ha ocurrido un error al listar los vehículos";
  static const String CONTRACTORS_ERROR_MSG = "Ha ocurrido un error al listar los contratantes";
  static const String PROVIDERS_ERROR_MSG = "Ha ocurrido un error al listar las compañias";
  static const String PAYMENTS_ERROR_MSG = "Ha ocurrido un error al listar los pagos";

  //

  // Colors
  static const int C_PRIMARYCOLOR = 0xFF4D56A3;
  static const int C_SECUNDARYCOLOR = 0xFFCDD1EE;
  static const int C_TEXTCOLOR = 0xFF999999;
  static const int C_GRAYCOLOR = 0xFFF6F6F6;
  static const int C_REDCOLOR = 0xFF9C0000;
  static const int C_GREENCOLOR = 0xFF5DB075;
  static const int C_ORANGECOLOR = 0xFFDF6C02;
  static const int C_WHITECOLOR = 0xFFFFFFFF;
  static const int C_BLACKCOLOR = 0xFF000000;
  static const int C_LOGOCOLOR = 0xFF0099F7;
  static const int C_ICONCOLOR = 0xFF4491CE;
  static const int C_BADGECOLOR = 0xFFFF3B30;
  static const int C_BORDERCOLOR2 = 0xFFE8E8E8;
  static const int C_LIGHTGREY = 0xFFD1D1D6;

  static const int C_LABELCOLOR = 0xFFBDBDBD;
  static const int C_SHADOWCOLOR = 0xFFD6D6D6;
  static const int C_SHADOWCOLOR2 = 0x42000000;

  static const int C_EXITCOLOR = 0xFF9C0000;
  static const int C_ERRORTEXTCOLOR = 0xFF9C0000;
  static const int C_DIVIDERCOLOR = 0xFFE5E5E5;
  static const int C_GRADIENTBLUE = 0xFFd7f0ff;
  static const int C_MAPROUTECOLOR = 0xFF007AFF;
  static const int C_POLYLINE = 0xFF007AFF;
  static const int C_PORCENTBAR = 0xFFBEB0E4;
  static const int C_LIGHTCOLOR = 0xFF1CA4C9;

  //
  static const int C_ONBOARDINGCARDCOLOR = 0xFFFCFCFC;
  static const int C_BOTTOMSHEETBGCOLOR = 0xFFF8F8F8;
  static const int C_ACCENTCOLOR2 = 0xFFFDBB51;
  static const int C_ACCENTCOLOR = 0xFFFE3C3C;
  static const int C_ACCENTCOLOR3 = 0xFFD32F2F;

  static const int C_BUTTON = 0xFF4CAF50;
  static const int C_ICON = 0xFF848181;
  static const int C_FILLCOLOR = 0xFFF5F5F9;
  static const int C_BORDERCOLOR = 0xFFD9DBEC;

  static const int C_STATUS1 = 0xFF737AB9;
  static const int C_STATUS2 = 0xFFF99790;
  static const int C_STATUS3 = 0xFFC0C3DD;

  static const int C_AVATAR = 0xFF9CA3DC;

  static const predefinedColors = [
    Color(0xFF7CB342),
    Color(0xFF42A5F5),
    Color(0xFFEC407A),
    Color(0xFFAB47BC),
    Color(0xFF7E57C2),
    Color(0xFF78909C),
    Color(0xFF99B6F6),
    Color(0xFF8D6E63),
    Color(0xFF757575),
    Color(0xFF5C6BC0),
    Color(0xFF8D6E63),
    Color(0xFF26C6DA),
    Color(0xFF26A69A),
    Color(0xFFC0CA33),
    Color(0xFFFFE158),
    Color(0xFFFFA726),
    Color(0xFFFF7043),
    Color(0xFF49E440),
    Color(0xFFFFCA00),
    Color(0xFFFFEAAA),
    Color(0xFFB2FF59),
    Color(0xFF00BFA5),
    Color(0xFF00B8D4),
    Color(0xFF0091EA),
    Color(0xFFF78101),
    Color(0xFFF07298),
    Color(0xFF274B62),
  ];

}