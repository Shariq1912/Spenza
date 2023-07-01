import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

double totalPerStore(
  List<ProductsRecord> pinList,
  List<BquantityRecord> bquantities,
  DocumentReference store,
  List<ProductsRecord> allproducts,
) {
  double total = 1;

  for (var p in pinList) {
    var quantity = 0;
    var price = p.bPrice;

    if (p.bstoreRef != store) {
      var matchingProducts = allproducts.where((product) =>
          product.bstoreRef == store &&
          product.measure == p.measure &&
          product.genericNameRef == p.genericNameRef &&
          product.departmentRef == p.departmentRef);

      if (matchingProducts.isNotEmpty) {
        var sameIdStoreProducts =
            matchingProducts.where((product) => product.idStore == p.idStore);

        if (sameIdStoreProducts.isNotEmpty) {
          price = sameIdStoreProducts.first.bPrice;
        } else {
          var lowestBPrice = matchingProducts
              .map((product) => product.bPrice)
              .reduce((a, b) => a! < b! ? a : b);
          price = lowestBPrice;
        }
      } else {
        price = 0;
      }
    }

    for (var b in bquantities) {
      if (b.productRef == p.reference) {
        quantity = b.quantity!;
        break;
      }
    }
    total += price! * quantity;
  }

  return total;
}

List<StoresRecord> listStoresPerTotal(
  List<StoresRecord>? stores,
  List<ProductsRecord> pinList,
  List<BquantityRecord> bquantities,
  List<ProductsRecord> allproducts,
) {
  if (stores == null) {
    return [];
  }

  stores.sort((store1, store2) {
    double total1 = 0;
    double total2 = 0;

    for (var p in pinList) {
      var quantity = 1;
      var price = p.bPrice;

      if (p.bstoreRef != store1.reference) {
        var matchingProducts = allproducts.where((product) =>
            product.bstoreRef == store1.reference &&
            product.genericNameRef == p.genericNameRef &&
            product.departmentRef == p.departmentRef);

        if (matchingProducts.isNotEmpty) {
          var sameIdStoreProducts =
              matchingProducts.where((product) => product.idStore == p.idStore);

          if (sameIdStoreProducts.isNotEmpty) {
            price = sameIdStoreProducts.first.bPrice;
          } else {
            var lowestBPrice = matchingProducts
                .map((product) => product.bPrice)
                .reduce((a, b) => a! < b! ? a : b);
            price = lowestBPrice;
          }
        } else {
          price = 0;
        }
      }

      for (var b in bquantities) {
        if (b.productRef == p.reference) {
          quantity = b.quantity!;
          break;
        }
      }

      total1 += price! * quantity;
    }

    for (var p in pinList) {
      var quantity = 1;
      var price = p.bPrice;

      if (p.bstoreRef != store2.reference) {
        var matchingProducts = allproducts.where((product) =>
            product.bstoreRef == store2.reference &&
            product.genericNameRef == p.genericNameRef &&
            product.departmentRef == p.departmentRef);

        if (matchingProducts.isNotEmpty) {
          var sameIdStoreProducts =
              matchingProducts.where((product) => product.idStore == p.idStore);

          if (sameIdStoreProducts.isNotEmpty) {
            price = sameIdStoreProducts.first.bPrice;
          } else {
            var lowestBPrice = matchingProducts
                .map((product) => product.bPrice)
                .reduce((a, b) => a! < b! ? a : b);
            price = lowestBPrice;
          }
        } else {
          price = 0;
        }
      }

      for (var b in bquantities) {
        if (b.productRef == p.reference) {
          quantity = b.quantity!;
          break;
        }
      }

      total2 += price! * quantity;
    }

    if (total1 == 0) return 1; // Send total 0 to the end of the list
    if (total2 == 0) return -1; // Send total 0 to the end of the list

    return total1.compareTo(total2);
  });

  return stores;
}

List<StoresRecord> listStoresPerTotalFavorite(
  List<StoresRecord>? stores,
  DocumentReference? user,
  List<ProductsRecord> pinList,
  List<BquantityRecord> bquantities,
  List<ProductsRecord> allproducts,
) {
  if (stores == null || user == null) {
    return [];
  }

  List<StoresRecord> filteredStores =
      stores.where((store) => store.userRef?.contains(user) ?? false).toList();

  filteredStores.sort((store1, store2) {
    double total1 = 0;
    double total2 = 0;

    for (var p in pinList) {
      var quantity = 1;
      var price = p.bPrice;

      if (p.bstoreRef != store1.reference) {
        var matchingProducts = allproducts.where((product) =>
            product.bstoreRef == store1.reference &&
            product.genericNameRef == p.genericNameRef &&
            product.departmentRef == p.departmentRef);

        if (matchingProducts.isNotEmpty) {
          var sameIdStoreProducts =
              matchingProducts.where((product) => product.idStore == p.idStore);

          if (sameIdStoreProducts.isNotEmpty) {
            price = sameIdStoreProducts.first.bPrice;
          } else {
            var lowestBPrice = matchingProducts
                .map((product) => product.bPrice)
                .reduce((a, b) => a! < b! ? a : b);
            price = lowestBPrice;
          }
        } else {
          price = 0;
        }
      }

      for (var b in bquantities) {
        if (b.productRef == p.reference) {
          quantity = b.quantity!;
          break;
        }
      }

      total1 += price! * quantity;
    }

    for (var p in pinList) {
      var quantity = 1;
      var price = p.bPrice;

      if (p.bstoreRef != store2.reference) {
        var matchingProducts = allproducts.where((product) =>
            product.bstoreRef == store2.reference &&
            product.genericNameRef == p.genericNameRef &&
            product.departmentRef == p.departmentRef);

        if (matchingProducts.isNotEmpty) {
          var sameIdStoreProducts =
              matchingProducts.where((product) => product.idStore == p.idStore);

          if (sameIdStoreProducts.isNotEmpty) {
            price = sameIdStoreProducts.first.bPrice;
          } else {
            var lowestBPrice = matchingProducts
                .map((product) => product.bPrice)
                .reduce((a, b) => a! < b! ? a : b);
            price = lowestBPrice;
          }
        } else {
          price = 0;
        }
      }

      for (var b in bquantities) {
        if (b.productRef == p.reference) {
          quantity = b.quantity!;
          break;
        }
      }

      total2 += price! * quantity;
    }

    if (total1 == 0) return 1; // Send total 0 to the end of the list
    if (total2 == 0) return -1; // Send total 0 to the end of the list

    return total1.compareTo(total2);
  });

  return filteredStores;
}

int quantityPerProduct(
  List<ProductsRecord> pinList,
  List<BquantityRecord> bquantities,
  ProductsRecord preference,
) {
  int quantity = 0;
  var product; // Make 'product' nullable by adding a question mark
  if (pinList.contains(preference)) {
    product = preference;
  } else {
    var matchingProducts = pinList.where((product) =>
        preference.measure == product.measure &&
        preference.genericNameRef == product.genericNameRef &&
        preference.departmentRef == product.departmentRef);

    if (matchingProducts.isNotEmpty) {
      var sameIdStoreProducts = matchingProducts
          .where((product) => product.idStore == preference.idStore);

      if (sameIdStoreProducts.isNotEmpty) {
        product = sameIdStoreProducts.first;
      } else {
        product = matchingProducts.first;
      }
    }
  }

  for (var b in bquantities) {
    if (product != null && b.productRef == product.reference) {
      // Add null check for 'product'
      quantity = b.quantity!;
      break;
    }
  }

  return quantity;
}

String getGenericName(
  DocumentReference genericName,
  List<GenericNameRecord> genericNames,
) {
  // if genericName in genericNames, return the value of name
  if (genericName == null) {
    return '';
  }
  final index =
      genericNames.indexWhere((element) => element.reference == genericName);
  if (index == -1) {
    return '';
  }
  return genericNames[index].genericName!;
}

String getStoreGroup(
  DocumentReference storeGroupRef,
  List<StoresGroupsRecord> storesGroups,
) {
  // if storeGroupRef in storesGroups, return the value of name
  for (StoresGroupsRecord record in storesGroups) {
    if (record.reference == storeGroupRef) {
      return record.name!;
    }
  }
  return '';
}

List<ProductsRecord> listPinListMissing(
  DocumentReference store,
  List<ProductsRecord> pinList,
  List<BquantityRecord> bquantities,
  List<ProductsRecord> productsinStore,
) {
  List<ProductsRecord> pinListTrue = [];
  List<ProductsRecord> pinListFalse = [];
  List<ProductsRecord> pinListMissing = [];

  for (var p in pinList) {
    bool productAdded = false; // Flag to track if a product has been added

    if (p.bstoreRef == store) {
      pinListTrue.add(p);
      productAdded = true;
    } else {
      var matchingProducts = productsinStore.where((product) =>
          product.measure == p.measure &&
          product.genericNameRef == p.genericNameRef &&
          product.departmentRef == p.departmentRef);

      if (matchingProducts.isNotEmpty) {
        var sameIdStoreProducts =
            matchingProducts.where((product) => product.idStore == p.idStore);

        if (sameIdStoreProducts.isNotEmpty) {
          pinListTrue.add(sameIdStoreProducts.first);
          productAdded = true;
        }
      }

      if (!productAdded && matchingProducts.isNotEmpty) {
        var lowestBPrice =
            matchingProducts.reduce((a, b) => a.bPrice! < b.bPrice! ? a : b);
        pinListFalse.add(lowestBPrice);
        productAdded = true;
      }
    }

    if (!productAdded) {
      pinListMissing.add(p);
    }
  }

  return pinListMissing;
}

List<ProductsRecord> listPinListFalse(
  DocumentReference store,
  List<ProductsRecord> pinList,
  List<BquantityRecord> bquantities,
  List<ProductsRecord> productsinStore,
) {
  List<ProductsRecord> pinListTrue = [];
  List<ProductsRecord> pinListFalse = [];
  List<ProductsRecord> pinListMissing = [];

  for (var p in pinList) {
    bool productAdded = false; // Flag to track if a product has been added

    if (p.bstoreRef == store) {
      pinListTrue.add(p);
      productAdded = true;
    } else {
      var matchingProducts = productsinStore.where((product) =>
          product.measure == p.measure &&
          product.genericNameRef == p.genericNameRef &&
          product.departmentRef == p.departmentRef);

      if (matchingProducts.isNotEmpty) {
        var sameIdStoreProducts =
            matchingProducts.where((product) => product.idStore == p.idStore);

        if (sameIdStoreProducts.isNotEmpty) {
          pinListTrue.add(sameIdStoreProducts.first);
          productAdded = true;
        }
      }

      if (!productAdded && matchingProducts.isNotEmpty) {
        var lowestBPrice =
            matchingProducts.reduce((a, b) => a.bPrice! < b.bPrice! ? a : b);
        pinListFalse.add(lowestBPrice);
        productAdded = true;
      }
    }

    if (!productAdded) {
      pinListMissing.add(p);
    }
  }

  return pinListFalse;
}

List<ProductsRecord> quantityProductFinalStep(
  DocumentReference store,
  List<ProductsRecord> pinList,
  List<BquantityRecord> bquantities,
  List<ProductsRecord> productsinStore,
) {
  List<ProductsRecord> pinListTrue = [];
  List<ProductsRecord> pinListFalse = [];
  List<ProductsRecord> pinListMissing = [];

  for (var p in pinList) {
    bool productAdded = false; // Flag to track if a product has been added

    if (p.bstoreRef == store) {
      pinListTrue.add(p);
      productAdded = true;
    } else {
      var matchingProducts = productsinStore.where((product) =>
          product.measure == p.measure &&
          product.genericNameRef == p.genericNameRef &&
          product.departmentRef == p.departmentRef);

      if (matchingProducts.isNotEmpty) {
        var sameIdStoreProducts =
            matchingProducts.where((product) => product.idStore == p.idStore);

        if (sameIdStoreProducts.isNotEmpty) {
          pinListTrue.add(sameIdStoreProducts.first);
          productAdded = true;
        }
      }

      if (!productAdded && matchingProducts.isNotEmpty) {
        var lowestBPrice =
            matchingProducts.reduce((a, b) => a.bPrice! < b.bPrice! ? a : b);
        pinListFalse.add(lowestBPrice);
        productAdded = true;
      }
    }

    if (!productAdded) {
      pinListMissing.add(p);
    }
  }

  return pinListTrue;
}

String getStoreGroupLogo(
  DocumentReference storeGroupRef,
  List<StoresGroupsRecord> storesGroups,
) {
  for (var storesGroup in storesGroups) {
    if (storesGroup.reference == storeGroupRef) {
      return storesGroup.logo;
    }
  }

  return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/spenza-g7u6qt/assets/xr3xjtyltkki/Placeholder_33%25.png';
}

List<ProductsRecord> listPinListTrue(
  DocumentReference store,
  List<ProductsRecord> pinList,
  List<BquantityRecord> bquantities,
  List<ProductsRecord> productsinStore,
) {
  List<ProductsRecord> pinListTrue = [];
  List<ProductsRecord> pinListFalse = [];
  List<ProductsRecord> pinListMissing = [];

  for (var p in pinList) {
    bool productAdded = false; // Flag to track if a product has been added

    if (p.bstoreRef == store) {
      pinListTrue.add(p);
      productAdded = true;
    } else {
      var matchingProducts = productsinStore.where((product) =>
          product.measure == p.measure &&
          product.genericNameRef == p.genericNameRef &&
          product.departmentRef == p.departmentRef);

      if (matchingProducts.isNotEmpty) {
        var sameIdStoreProducts =
            matchingProducts.where((product) => product.idStore == p.idStore);

        if (sameIdStoreProducts.isNotEmpty) {
          pinListTrue.add(sameIdStoreProducts.first);
          productAdded = true;
        }
      }

      if (!productAdded && matchingProducts.isNotEmpty) {
        var lowestBPrice =
            matchingProducts.reduce((a, b) => a.bPrice! < b.bPrice! ? a : b);
        pinListFalse.add(lowestBPrice);
        productAdded = true;
      }
    }

    if (!productAdded) {
      pinListMissing.add(p);
    }
  }

  return pinListTrue;
}

String getDepartment(
  DocumentReference departmentRef,
  List<DepartmentsRecord> departments,
) {
  for (DepartmentsRecord record in departments) {
    if (record.reference == departmentRef) {
      return record.name!;
    }
  }
  return 'not found';
}

double maxPriceProduct(
  ProductsRecord product,
  List<ProductsRecord> products,
) {
  double maxPrice = double.negativeInfinity;

  for (int i = 0; i < products.length; i++) {
    if (products[i].genericNameRef == product.genericNameRef &&
        products[i].departmentRef == product.departmentRef &&
        products[i].measure == product.measure) {
      if (products[i].bPrice != null && products[i].bPrice! > maxPrice) {
        maxPrice = products[i].bPrice!;
      }
    }
  }

  return maxPrice;
}

double maxPrice(
  ProductsRecord product,
  List<ProductsRecord> products,
) {
  double maxPrice = double.negativeInfinity;

  for (int i = 0; i < products.length; i++) {
    if (products[i].name == product.name &&
        products[i].departmentRef == product.departmentRef) {
      if (products[i].bPrice != null && products[i].bPrice! > maxPrice) {
        maxPrice = products[i].bPrice!;
      }
    }
  }

  return maxPrice;
}

double minPriceProduct(
  ProductsRecord product,
  List<ProductsRecord> products,
) {
  double minPrice = double.infinity;

  for (int i = 0; i < products.length; i++) {
    if (products[i].genericNameRef == product.genericNameRef &&
        products[i].departmentRef == product.departmentRef &&
        products[i].measure == product.measure) {
      if (products[i].bPrice != null && products[i].bPrice! < minPrice) {
        minPrice = products[i].bPrice!;
      }
    }
  }

  return minPrice;
}

List<ProductsRecord> listFilterProductbyGenericNameAdd2(
    List<ProductsRecord> products) {
  // return a list of products that don't have the same product.name and same product.department
  List<ProductsRecord> filteredProducts = [];
  for (ProductsRecord product in products) {
    if (filteredProducts.isEmpty) {
      filteredProducts.add(product);
    } else {
      bool isInList = false;
      for (ProductsRecord filteredProduct in filteredProducts) {
        if (filteredProduct.name == product.name &&
            filteredProduct.departmentRef == product.departmentRef) {
          isInList = true;
          break;
        }
      }
      if (!isInList) {
        filteredProducts.add(product);
      }
    }
  }

  filteredProducts.sort((a, b) =>
      (a.departmentRef?.id ?? '').compareTo(b.departmentRef?.id ?? ''));

  return filteredProducts;
}

double minPrice(
  ProductsRecord product,
  List<ProductsRecord> products,
) {
  double minPrice = double.infinity;

  for (int i = 0; i < products.length; i++) {
    if (products[i].name == product.name &&
        products[i].departmentRef == product.departmentRef) {
      if (products[i].bPrice != null && products[i].bPrice! < minPrice) {
        minPrice = products[i].bPrice!;
      }
    }
  }

  return minPrice;
}

List<StoresRecord> storesFav(
  List<StoresRecord> stores,
  DocumentReference user,
) {
  // Filter the stores where userRef contains user
  final favoriteStores = stores.where((store) {
    return store.userRef?.contains(user) ?? false;
    // Use null-aware ?. operator to call contains method only if userRef is not null
    // Use null coalescing operator ?? to return false if userRef is null
  }).toList();

  // Filter the stores where userRef does not contain user
  final otherStores = stores.where((store) {
    return !(store.userRef?.contains(user) ?? false);
    // Use null-aware ?. operator to call contains method only if userRef is not null
    // Use null coalescing operator ?? to return false if userRef is null
  }).toList();

  // Combine the two lists, with favorite stores coming first
  return [...favoriteStores, ...otherStores];
}

double totalPerProduct(
  List<ProductsRecord> pinList,
  List<BquantityRecord> bquantities,
  ProductsRecord preference,
) {
  int quantity = 0;
  ProductsRecord? product; // Make 'product' nullable by adding a question mark
  double price = preference.bPrice;
  double total = 0;

  if (pinList.contains(preference)) {
    product = preference;
  } else {
    var matchingProducts = pinList.where((product) =>
        preference.measure == product.measure &&
        preference.genericNameRef == product.genericNameRef &&
        preference.departmentRef == product.departmentRef);

    if (matchingProducts.isNotEmpty) {
      var sameIdStoreProducts = matchingProducts
          .where((product) => product.idStore == preference.idStore);

      if (sameIdStoreProducts.isNotEmpty) {
        product = sameIdStoreProducts.first;
      } else {
        product = matchingProducts.first;
      }
    }
  }

  for (var b in bquantities) {
    if (product != null && b.productRef == product.reference) {
      // Add null check for 'product'
      quantity = b.quantity; // HABIA UN ! AL FINAL DE LA VARIABLE
      break;
    }
  }

  total += price * quantity;

  return total;
}

int totalPerStoreCountItems(
  List<ProductsRecord> pinList,
  List<BquantityRecord> bquantities,
  DocumentReference store,
  List<ProductsRecord> allproducts,
) {
  List<ProductsRecord> pinListTrue = [];
  List<ProductsRecord> pinListFalse = [];

  for (var p in pinList) {
    if (p.bstoreRef != store) {
      var matchingProducts = allproducts.where((product) =>
          product.bstoreRef == store &&
          product.measure == p.measure &&
          product.genericNameRef == p.genericNameRef &&
          product.departmentRef == p.departmentRef);

      if (matchingProducts.isNotEmpty) {
        var sameIdStoreProducts =
            matchingProducts.where((product) => product.idStore == p.idStore);

        if (sameIdStoreProducts.isNotEmpty) {
          pinListTrue.add(sameIdStoreProducts.first);
        } else {
          var lowestBPrice =
              matchingProducts.reduce((a, b) => a.bPrice! < b.bPrice! ? a : b);
          pinListFalse.add(lowestBPrice);
        }
      } else {
        pinListTrue.add(p);
      }
    }
  }

  return pinListFalse.length; // Return the number of records in pinListFalse
}

List<String> getProdOrDept(
  String prodOrDeptName,
  List<DepartmentsRecord> departaments,
  List<ProductsRecord> products,
) {
  List<String> resultados = [];

  // Buscar coincidencias en el esquema 'Departamento'
  for (var departamento in departaments) {
    if (departamento.name
        .toLowerCase()
        .contains(prodOrDeptName.toLowerCase())) {
      resultados.add(departamento.name);
    }
  }

  // Buscar coincidencias en el esquema 'Producto'
  for (var producto in products) {
    if (producto.name.toLowerCase().contains(prodOrDeptName.toLowerCase())) {
      resultados.add(producto.name);
    }
  }
  print(
      'hola, entramos aqui a la funcion personalizada que nosotros mismos creamos');
  return resultados;
}
