import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'policies': 'Policies', // Pólizas
      'policy': 'Policy', // Póliza
      'policytype': 'Policy type', // Tipo de póliza
      'policyinfo': 'Policy info', // Datos de la póliza
      'insureds': 'Insureds', // Asegurados
      'insured': 'Insured', // Asegurado
      'insurance': 'Insurance', // Seguro
      'insurancetype': 'Insurance type', // Tipo de seguro
      'contractors': 'Contractors',  // Contratantes
      'contractor': 'Contractor',  // Contratante
      'contractorinfo': 'Contractor info',  // Datos del contratante
      'payments': 'Payments', // Pagos
      'payment': 'Payment', // Pago
      'wallets': 'Wallets', // Carteras
      'wallet': 'Wallet', // Cartera
      'paymentinfo': 'Payment info', // Datos del pago
      'walletinfo': 'Wallet info', // Datos de la cartera
      'companies': 'Companies', // Compañías
      'company': 'Company', // Compañía
      'companyinfo': 'Company info', // Datos de la compañía
      'affiliates': 'Affiliates', // Afiliados
      'affiliate': 'Affiliate', // Afiliado
      'affiliateinfo': 'Affiliate info', // Datos del ffiliado
      'vehicles': 'Vehicles', // Vehículos
      'vehicle': 'Vehicle', // Vehículo
      'vehicleinfo': 'Vehicle info', // Datos del vehículo
      'policytype': 'Policy type', // Tipo de póliza
      'validity': 'Validity', // Vigencia
      'branches': 'Branches', // Ramas
      'branch': 'Branch', // Rama
      'cousin': 'Cousin', // Prima
      'amount': 'Max policy amount', // Suma máxima póliza
      'commission': 'Commission', // Comisión
      'personalinformation': 'Personal information', // Información personal
      'gender': 'Gender', // Sexo
      'age': 'Age', // Edad
      'birthday': 'Birthday', // Fecha de nacimiento
      'insuranceinfo': 'Insurance info', // Datos del seguro
      'legaltype': 'Legal type', // Tipo legal
      'location': 'Location', // Ubicación
      'contry': 'Contry', // País
      'province': 'Province', // Provincia
      'city': 'City', // Ciudad
      'street': 'Street', // Dirección
      'brand': 'Brand', // Marca
      'model': 'Model', // Modelo
      'color': 'Color', // Color
      'year': 'Year', // Año
      'version': 'Version', // Versión
      'shortname': 'Short name', // Nombre corto
      'direction': 'Direction', // Dirección
      'contact': 'Contact', // Contacto
      'state': 'State', // Estado
      'paymentdate': 'Payment date', // Fecha de pago
      'payment-method': 'Payment method', // Metodo de pago
      'information': 'Information', // Información
      'description': 'Description', // Descripción
      'notifications': 'Notifications', // Notificaciones
      'notification': 'Notification', // Notificación
      'closesession': 'Close session', // Cerrar sesión
      'search': 'Search...', // Buscar
      'document': 'Document',
      'documents': 'Documents',
      'noitems': 'No items', // No hay elementos
      'message': 'Message',
      'warning': 'Warning',
      'error': 'Error',
      'ok': 'OK',
      'cancel': 'Cancel',
      'yes': 'Yes',
      'no': 'No',

      'closesessiontitle': 'You are logging out. We will ask for your data the next time you open the app.',

      'ERROR_MSG_FETCH_DATA_EXCEPTION ': 'Ocurrió un error de conexión, por favor vuelve a intentarlo',
      'ERROR_MSG_UNAUTHORIZED_EXCEPTION': 'An error occurred while logging in',
      'ERROR_LOGIN_MSG': 'The access data is incorrect',
      'POLICIES_ERROR_MSG': 'An error has occurred while listing the policies',
      'INSUREDS_ERROR_MSG': ' An error has occurred while listing affiliates',
      'VEHICLES_ERROR_MSG': 'An error has occurred while listing the vehicles',
      'CONTRACTORS_ERROR_MSG': 'An error has occurred when listing the contractors',
      'PROVIDERS_ERROR_MSG': 'An error has occurred while listing the companies',
      'PAYMENTS_ERROR_MSG': 'An error has occurred while listing wallets',
      'ERROR_URL_ONLOAD_DOC': 'An error occurred loading the document',
    },
    'es_ES': {
      'policies': 'Pólizas',
      'policy': 'Póliza',
      'policytype': 'Tipo de póliza',
      'policyinfo': 'Datos de la póliza',
      'insureds': 'Asegurados',
      'insured': 'Asegurado',
      'insurance': 'Seguro',
      'insurancetype': 'Tipo de seguro',
      'contractors': 'Contratantes',
      'contractor': 'Contratante',
      'contractorinfo': 'Datos del contratante',
      'payments': 'Pagos',
      'payment': 'Pago',
      'wallet': 'Cartera',
      'wallets': 'Carteras',
      'paymentinfo': 'Datos del pago',
      'walletinfo': 'Datos de cartera', // Datos de cartera
      'companies': 'Compañías',
      'company': 'Compañía',
      'companyinfo': 'Datos de la compañía',
      'affiliates': 'Afiliados',
      'affiliate': 'Afiliado',
      'affiliateinfo': 'Datos del ffiliado',
      'vehicles': 'Vehículos',
      'vehicle': 'Vehículo',
      'vehicleinfo': 'Datos del vehículo',
      'policytype': 'Tipo de póliza',
      'validity': 'Vigencia',
      'branches': 'Ramas',
      'branch': 'Rama',
      'cousin': 'Prima',
      'amount': 'Suma máxima póliza',
      'commission': 'Comisión',
      'personalinformation': 'Información personal',
      'gender': 'Sexo',
      'age': 'Edad',
      'birthday': 'Fecha de nacimiento',
      'insuranceinfo': 'Datos del seguro',
      'legaltype': 'Tipo legal',
      'location': 'Ubicación',
      'contry': 'País',
      'province': 'Provincia',
      'city': 'Ciudad',
      'street': 'Dirección',
      'brand': 'Marca',
      'model': 'Modelo',
      'color': 'Color',
      'year': 'Año',
      'version': 'Versión',
      'shortname': 'Nombre corto',
      'direction': 'Dirección',
      'contact': 'Contacto',
      'state': 'Estado',
      'paymentdate': 'Fecha de pago',
      'payment-method': 'Método de pago',
      'information': 'Información',
      'description': 'Descripción',
      'notifications': 'Notificaciones',
      'notification': 'Notificación',
      'closesession': 'Cerrar sesión',
      'search': 'Buscar...',
      'document': 'Documento',
      'documents': 'Documentos',
      'noitems': 'No hay elementos',
      'message': 'Mensaje',
      'warning': 'Aviso',
      'error': 'Error',
      'ok': 'Aceptar',
      'cancel': 'Cancelar',
      'yes': 'Sí',
      'no': 'No',

      'closesessiontitle': 'Estás cerrando sesión. Pediremos tus datos la próxima ocasión que abras la app.',

      'ERROR_MSG_FETCH_DATA_EXCEPTION ': 'Ocurrió un error de conexión, por favor vuelve a intentarlo',
      'ERROR_MSG_UNAUTHORIZED_EXCEPTION': 'Ha ocurrido un error al iniciar sesión',
      'ERROR_LOGIN_MSG': 'Los datos de acceso son incorrectos',
      'POLICIES_ERROR_MSG': 'Ha ocurrido un error al listar las pólizas',
      'INSUREDS_ERROR_MSG': 'Ha ocurrido un error al listar los afiliados',
      'VEHICLES_ERROR_MSG': 'Ha ocurrido un error al listar los vehículos',
      'CONTRACTORS_ERROR_MSG': 'Ha ocurrido un error al listar los contratantes',
      'PROVIDERS_ERROR_MSG': 'Ha ocurrido un error al listar las compañias',
      'PAYMENTS_ERROR_MSG': 'Ha ocurrido un error al listar las carteras',
      'ERROR_URL_ONLOAD_DOC': 'Ha ocurrido un error cargando el documento',

}
  };
}

