import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'es'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? esText = '',
  }) =>
      [enText, esText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Onboarding
  {
    'zqehckx0': {
      'en': 'Welcome to',
      'es': 'Te damos la bienvenida a',
    },
    '6q972m5c': {
      'en': 'Find stores',
      'es': 'Descubre más tiendas',
    },
    'b7r364qj': {
      'en':
          'Find your favorite stores and supermarkets, and discover new ones near you',
      'es': '',
    },
    '5ytd01wr': {
      'en': 'Make your shopping list',
      'es': 'Crea tus listas de compras',
    },
    '08w3osi8': {
      'en':
          'Make your own shopping list or select a \n pre-charged list that Spenza has for you',
      'es':
          'Usa una de las listas rápidas de Spenza o crea una que se ajuste perfecto a tus necesidades',
    },
    'm7eiyiso': {
      'en': 'Compare prices',
      'es': 'Compara precios',
    },
    '2lda3deq': {
      'en':
          'Compare the price of yur entire shopping list and find the best bargain',
      'es':
          'Obtén el precio total por tu lista de compras y compara en todas las tiendas cercanas a ti.',
    },
    '7qkyt7x4': {
      'en': 'Shop in store or online',
      'es': 'Elige la mejor opción',
    },
    'm8npgbuf': {
      'en':
          'Select the best option for you and cut your grocery bill up to 30% every week.',
      'es':
          'Selecciona la tienda que te ofrezca el mejor precio y ahorra hasta un 30% semanalmente.',
    },
    'yhkogmzy': {
      'en': 'Sign up',
      'es': 'Registrarse',
    },
    'lotcqvh3': {
      'en': 'Login',
      'es': 'Iniciar sesión',
    },
    'rvhhe099': {
      'en': 'Home',
      'es': '',
    },
  },
  // Signup
  {
    'avxe795e': {
      'en': 'Sign up',
      'es': 'Registrarse',
    },
    'ke4pyztp': {
      'en': '',
      'es': '',
    },
    'l7dv5qr0': {
      'en': 'Enter your email...',
      'es': 'Correo electrónico',
    },
    'wsatgzqi': {
      'en': '',
      'es': '',
    },
    '5ct7gr7u': {
      'en': 'Please enter your password...',
      'es': 'Contraseña',
    },
    '4sgqj8i2': {
      'en': '',
      'es': '',
    },
    '88b9ys9h': {
      'en': 'Please Confirm Password...',
      'es': 'Confirma tu contraseña',
    },
    'b8z57nj1': {
      'en':
          'By using this application, you agree to our Terms of Service and Privacy Policy',
      'es':
          'Al usar esta aplicación aceptas a nuestros Términos de uso y Política de Privacidad',
    },
    '410piwat': {
      'en': 'Create Account',
      'es': 'Crear cuenta',
    },
    'yt4a9176': {
      'en': 'Home',
      'es': '',
    },
  },
  // Forgot_password
  {
    'fghelm69': {
      'en': 'Forgot password',
      'es': 'Reestablecer contraseña',
    },
    '6a6pckbb': {
      'en':
          'We will send you an email with a link to reset your password, please enter the email associated with your account below.',
      'es':
          'Enviaremos un enlace a tu correo electrónico para restablecer tu contraseña',
    },
    'tin2093k': {
      'en': '',
      'es': '',
    },
    'jw4rdm1e': {
      'en': 'Enter your email...',
      'es': 'Correo electrónico',
    },
    '8rem9vaf': {
      'en': 'Send Link',
      'es': 'Enviar enlace',
    },
    'fxq0dcmv': {
      'en': 'Home',
      'es': '',
    },
  },
  // Login
  {
    'jbjd9u4r': {
      'en': 'Login',
      'es': 'Iniciar sesión',
    },
    'lprp4hwh': {
      'en': 'Access your account by logging in below.',
      'es': 'Ingresa a tu cuenta con tu correo electrónico',
    },
    'aogbsywy': {
      'en': '',
      'es': '',
    },
    'zhkip3to': {
      'en': 'Enter your email...',
      'es': 'Correo electrónico',
    },
    'xexop2l9': {
      'en': '',
      'es': '',
    },
    'jn211ehy': {
      'en': 'Please enter your password...',
      'es': 'Contraseña',
    },
    'tphxhxle': {
      'en': 'Login',
      'es': 'Iniciar sesión',
    },
    'ypc7zraj': {
      'en': 'Forgot Password?',
      'es': '¿Olvidaste tu contraseña?',
    },
    'wxcy1duu': {
      'en': 'Home',
      'es': '',
    },
  },
  // allMyList
  {
    '9ob74c2t': {
      'en': 'Search...',
      'es': 'Buscar',
    },
    '4aublpwx': {
      'en': 'Option 1',
      'es': '',
    },
    'ni5j5ep8': {
      'en': 'My Lists',
      'es': 'Mis listas',
    },
    'le07gztw': {
      'en': 'Mis Listas',
      'es': '',
    },
  },
  // Home
  {
    'l0p2i9fs': {
      'en': 'My Lists',
      'es': 'Mis listas',
    },
    'euqep40r': {
      'en': 'Preloaded lists',
      'es': 'Mis listas rápidas',
    },
    'xeq1q12e': {
      'en': 'Preloaded list name',
      'es': '',
    },
    '44cga5lu': {
      'en': 'Description',
      'es': '',
    },
    'jztojw3o': {
      'en': 'My Stores',
      'es': 'Mis Tiendas',
    },
    'dyh9quf5': {
      'en': 'Change password',
      'es': 'Cambiar contraseña',
    },
    'xt6d6kxh': {
      'en': 'Log out',
      'es': 'Cerrar sesión',
    },
    'tlduhojh': {
      'en': 'Profile',
      'es': 'Perfil',
    },
    '4ywtgiwv': {
      'en': 'Name',
      'es': 'Nommbre',
    },
    'um07mfik': {
      'en': 'Lastname',
      'es': 'Apellido',
    },
    'krp5qay2': {
      'en': 'Phone number',
      'es': 'Número de teléfono',
    },
    'uv6xdye0': {
      'en': 'Gender',
      'es': 'Género',
    },
    'zy05xe9q': {
      'en': 'Birthdate',
      'es': 'Fecha de nacimiento',
    },
    '95c8gar0': {
      'en': 'Address',
      'es': 'Dirección',
    },
    '5clc2and': {
      'en': 'ZIP code',
      'es': 'Código Postal',
    },
    'zxsgbdjl': {
      'en': 'City',
      'es': 'Ciudad',
    },
    'rj7eaob6': {
      'en': 'State',
      'es': 'Estado',
    },
    'o6qxf6j8': {
      'en': 'Language',
      'es': 'Idioma',
    },
    'ctzzo1fq': {
      'en': 'Home',
      'es': 'Inicio',
    },
  },
  // Addproducts
  {
    'eajinyie': {
      'en': 'Search...',
      'es': 'Buscar',
    },
    'blzalmn5': {
      'en': 'Option 1',
      'es': '',
    },
    '1o4d8j0l': {
      'en': 'Add products',
      'es': 'Agregar productos',
    },
    '3n6h7t53': {
      'en': 'Home',
      'es': '',
    },
  },
  // bAddProducts2
  {
    'la6gb3nq': {
      'en': 'Search...',
      'es': 'Buscar',
    },
    'qnegdykp': {
      'en': 'Option 1',
      'es': '',
    },
    're902uve': {
      'en': '-',
      'es': '-',
    },
    'oer73884': {
      'en': '-',
      'es': '-',
    },
    'hh961qd0': {
      'en': 'Select product',
      'es': 'Selecciona producto',
    },
    'mb7xltkj': {
      'en': 'Home',
      'es': '',
    },
  },
  // allStores
  {
    'xifey5g3': {
      'en': 'Search...',
      'es': 'Buscar',
    },
    'epmynsbq': {
      'en': 'Option 1',
      'es': '',
    },
    'brloven7': {
      'en': 'My Stores',
      'es': 'Mis Tiendas',
    },
    'z0u50mcm': {
      'en': 'Home',
      'es': '',
    },
  },
  // Finalstep
  {
    '5xdcad94': {
      'en': 'Products in your list',
      'es': 'Productos en tu lista',
    },
    '7iutoajn': {
      'en': 'PinListTrue',
      'es': '',
    },
    'rddaesh8': {
      'en': 'Replace items in  your list',
      'es': 'Productos  reemplazados',
    },
    '29wr86h7': {
      'en': 'PinListFalse',
      'es': '',
    },
    '6tlic4la': {
      'en': 'Missing items',
      'es': 'Productos no encontrados',
    },
    'chgoij7p': {
      'en': 'PinListFalse',
      'es': '',
    },
    'unnrrpv4': {
      'en': 'Home',
      'es': '',
    },
  },
  // bProductsInML
  {
    'me4qjsgx': {
      'en': 'Add products',
      'es': 'Agregar productos',
    },
    'jl11gkgo': {
      'en': 'Spenza',
      'es': 'Spenza tu compra',
    },
    '95pgnmtj': {
      'en': 'Home',
      'es': '',
    },
  },
  // bStoreComparison
  {
    'lyptoibz': {
      'en': 'Store comparison',
      'es': 'Comparar precios',
    },
    'xjoacu0x': {
      'en': 'My Stores',
      'es': 'Mis Tiendas',
    },
    'jlfkyvlk': {
      'en': ' items unavailable',
      'es': ' artìculos no disponibles',
    },
    '5p23pvcx': {
      'en': 'All availale Stores',
      'es': 'Todas las tiendas',
    },
    '20oqdtbq': {
      'en': ' items unavailable',
      'es': ' artìculos no disponibles',
    },
    '2keo5nq4': {
      'en': 'My stores',
      'es': '',
    },
  },
  // Location
  {
    'vngvbw24': {
      'en': 'Share your location with Spenza\nto find stores near you',
      'es':
          'Comparte tu ubicación con Spenza\npara localizar las tiendas cercanas a ti',
    },
    '2b9ks887': {
      'en': '',
      'es': '',
    },
    'ifxucr9n': {
      'en': 'Enter your ZipCode...',
      'es': 'Còdigo Potal',
    },
    '5qiffb1k': {
      'en': 'Continue',
      'es': 'Continuar',
    },
    'm4mcii13': {
      'en': 'Home',
      'es': '',
    },
  },
  // SelectStores
  {
    'kwm4ceh6': {
      'en': 'Select your favorite stores',
      'es': '',
    },
    'bi056sp6': {
      'en': 'Continue',
      'es': 'Continuar',
    },
    'd0zsjz4a': {
      'en': 'My Stores',
      'es': 'Mis Tiendas',
    },
    'lkrslysl': {
      'en': 'Tiendas',
      'es': '',
    },
  },
  // allMyReceipts
  {
    'fqm3vczx': {
      'en': 'My List Name',
      'es': '',
    },
    'dbbfcvct': {
      'en': 'Uploaded date',
      'es': '',
    },
    'v1cw1pge': {
      'en': 'My Receipts',
      'es': 'Mis listas',
    },
    'd71lohbj': {
      'en': 'Home',
      'es': '',
    },
  },
  // ListProducts2
  {
    '5hjtfhfd': {
      'en': 'Search...',
      'es': 'Buscar',
    },
    'rh34lrzl': {
      'en': 'Option 1',
      'es': '',
    },
    'yg6506ve': {
      'en': 'All',
      'es': 'Todos',
    },
    '83ziojkq': {
      'en': '-',
      'es': '-',
    },
    'r7al788d': {
      'en': ' Dairy & Eggs',
      'es': 'Lácteos y huevo',
    },
    'rnbsqtjw': {
      'en': 'Title',
      'es': '',
    },
    '8hg2gl12': {
      'en': 'Hello World',
      'es': '',
    },
    'dw2pk7at': {
      'en': 'Hello World',
      'es': '',
    },
    'i50di62n': {
      'en': '-',
      'es': '-',
    },
    'trwb0n3t': {
      'en': 'Hello World',
      'es': '',
    },
    'x3hs2wxb': {
      'en': 'Title',
      'es': '',
    },
    '32nddov9': {
      'en': 'Hello World',
      'es': '',
    },
    'wzqh474y': {
      'en': 'Hello World',
      'es': '',
    },
    'mzh5b3ou': {
      'en': '-',
      'es': '-',
    },
    '73sxgxro': {
      'en': 'Hello World',
      'es': '',
    },
    'cjpbux43': {
      'en': 'Hello World',
      'es': '',
    },
    'nfrhlpi6': {
      'en': '-',
      'es': '-',
    },
    'epjaov5e': {
      'en': 'Hello World',
      'es': '',
    },
    '39jtevr8': {
      'en': 'Household essentials',
      'es': 'Limpieza del hogar',
    },
    're1ftni7': {
      'en': 'Limpieza del hogar',
      'es': '',
    },
    '04888v51': {
      'en': 'Pets',
      'es': 'Mascotas',
    },
    '83xkbvx8': {
      'en': 'Mascotas',
      'es': '',
    },
    '2ditwtv8': {
      'en': 'Panadería y tortillería',
      'es': '',
    },
    'ved4t5oi': {
      'en': 'Panadería y tortilleria',
      'es': '',
    },
    'op9bmji5': {
      'en': 'Paper products',
      'es': 'Productos de papel',
    },
    'jf5365xg': {
      'en': 'Productos de papel',
      'es': '',
    },
    'xk530lmm': {
      'en': 'Salchichonería',
      'es': 'Salchichonería',
    },
    'iqn26auj': {
      'en': 'Salchichoneria',
      'es': '',
    },
    'hpd9po1g': {
      'en': 'Vinos, licores y cerveza',
      'es': '',
    },
    '5i8rjkte': {
      'en': 'Vinos y licores',
      'es': '',
    },
    'qtwlkz7e': {
      'en': 'Add Products',
      'es': 'Agregar Productos',
    },
    '2gq21icl': {
      'en': 'Shop',
      'es': '',
    },
  },
  // modalCreateML
  {
    'od2u83ci': {
      'en': 'Enter name for your list...',
      'es': '',
    },
    'xqedlkdq': {
      'en': 'Enter description for your list...',
      'es': 'Descripciòn de tu lista',
    },
    'cnng15ia': {
      'en': 'Create new list',
      'es': 'Crear nueva lista',
    },
  },
  // changePhoto
  {
    '6g4a9pdo': {
      'en': 'Delete photo',
      'es': 'Borrar foto',
    },
    'xzj1ts3j': {
      'en': 'Change photo',
      'es': 'Cambiar foto',
    },
  },
  // Logout
  {
    'qqzd458t': {
      'en': 'Are you sure you want to logout?',
      'es': 'Seguro de cerrar sesión?',
    },
    '5km4v9y2': {
      'en': 'Log out',
      'es': 'Cerrar Sesión',
    },
    'do5b56y6': {
      'en': 'Cancel',
      'es': 'Cancelar',
    },
  },
  // changeProfile
  {
    'o3fdd85r': {
      'en': 'Account Settings',
      'es': 'Perfil',
    },
    'sgwfipl5': {
      'en': 'Enter name',
      'es': 'Nombre',
    },
    'is8enc58': {
      'en': 'Enter lastname',
      'es': 'Apellido',
    },
    '1ag0afrm': {
      'en': 'Enter phone number',
      'es': 'Número de teléfono',
    },
    'scn9a1er': {
      'en': 'Gender',
      'es': 'Género',
    },
    'p1o16m3v': {
      'en': 'Female',
      'es': 'Femenino',
    },
    'pz6y43bw': {
      'en': 'Male',
      'es': 'Masculino',
    },
    'b4z5mrz5': {
      'en': 'Birthdate',
      'es': 'Fecha de nacimiento',
    },
    '7aygrara': {
      'en': 'Change',
      'es': 'Cambiar fecha',
    },
    '79qamyns': {
      'en': 'Save changes',
      'es': 'Guardar cambios',
    },
  },
  // changePassword
  {
    'k8iwpwwm': {
      'en': 'Reset password',
      'es': 'Cambiar contraseña',
    },
    '2y5zbu6d': {
      'en': 'New password',
      'es': 'Nueva contraseña',
    },
    'm1lrasxy': {
      'en': 'Confirm password',
      'es': 'Confirmar contraseña',
    },
    '8zr9h6iv': {
      'en': 'Save changes',
      'es': 'Guardar cambios',
    },
    'w6v1b5z7': {
      'en': 'Passwords do NOT match',
      'es': 'Las contraseñas no coinciden',
    },
  },
  // emptyMyList
  {
    '1u67vgv4': {
      'en': 'You don\'t \nhave any \nlist yet,\ncreate one',
      'es': 'Aún no\ntienes listas,\ncrea una',
    },
  },
  // productCard
  {
    'vbz0c4k5': {
      'en': '-',
      'es': '-',
    },
  },
  // Miscellaneous
  {
    'tnitj6pk': {
      'en': '',
      'es': '',
    },
    '3zkrkpdd': {
      'en': '',
      'es': '',
    },
    '3rb8d12f': {
      'en': '',
      'es': '',
    },
    'o9k4136i': {
      'en': '',
      'es': '',
    },
    '04wwiac4': {
      'en': '',
      'es': '',
    },
    '1t1kdxs1': {
      'en': '',
      'es': '',
    },
    'ehhk0tn6': {
      'en': '',
      'es': '',
    },
    'yj5vhy0b': {
      'en': '',
      'es': '',
    },
    '8zuas5gm': {
      'en': '',
      'es': '',
    },
    '8orchva9': {
      'en': '',
      'es': '',
    },
    'pcfjyone': {
      'en': '',
      'es': '',
    },
    '3vmbc1es': {
      'en': '',
      'es': '',
    },
    '94nafc1t': {
      'en': '',
      'es': '',
    },
    '5n0gyswo': {
      'en': '',
      'es': '',
    },
    'yf069pbf': {
      'en': '',
      'es': '',
    },
    'i6j5vik4': {
      'en': '',
      'es': '',
    },
    'mhasz9g4': {
      'en': '',
      'es': '',
    },
    'uvdlm90x': {
      'en': '',
      'es': '',
    },
    '4hha6w3a': {
      'en': '',
      'es': '',
    },
    'b9h9rozc': {
      'en': '',
      'es': '',
    },
    'fo963etu': {
      'en': '',
      'es': '',
    },
    '5ad4hvet': {
      'en': '',
      'es': '',
    },
    'grs1cw4f': {
      'en': '',
      'es': '',
    },
  },
].reduce((a, b) => a..addAll(b));
