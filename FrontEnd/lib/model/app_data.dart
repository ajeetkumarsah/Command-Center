class DataModel {
  MtdRetailing? mtdRetailing;
  Coverage? coverage;
  CallCompliance? callCompliance;
  Productivity? productivity;
  Billing? billing;
  Shipment? shipment;
  Inventory? inventory;
  DgpCompliance? dgpCompliance;
  FocusBrand? focusBrand;

  DataModel(
      {this.mtdRetailing,
        this.coverage,
        this.callCompliance,
        this.productivity,
        this.billing,
        this.shipment,
        this.inventory,
        this.dgpCompliance,
        this.focusBrand});

  DataModel.fromJson(Map<String, dynamic> json) {
    mtdRetailing = json['mtdRetailing'] != null
        ? MtdRetailing.fromJson(json['mtdRetailing'])
        : null;
    coverage = json['coverage'] != null
        ? Coverage.fromJson(json['coverage'])
        : null;
    callCompliance = json['callCompliance'] != null
        ? CallCompliance.fromJson(json['callCompliance'])
        : null;
    productivity = json['productivity'] != null
        ? Productivity.fromJson(json['productivity'])
        : null;
    billing =
    json['billing'] != null ? Billing.fromJson(json['billing']) : null;
    shipment = json['shipment'] != null
        ? Shipment.fromJson(json['shipment'])
        : null;
    inventory = json['inventory'] != null
        ? Inventory.fromJson(json['inventory'])
        : null;
    dgpCompliance = json['dgpCompliance'] != null
        ? DgpCompliance.fromJson(json['dgpCompliance'])
        : null;
    focusBrand = json['focusBrand'] != null
        ? FocusBrand.fromJson(json['focusBrand'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mtdRetailing != null) {
      data['mtdRetailing'] = mtdRetailing!.toJson();
    }
    if (coverage != null) {
      data['coverage'] = coverage!.toJson();
    }
    if (callCompliance != null) {
      data['callCompliance'] = callCompliance!.toJson();
    }
    if (productivity != null) {
      data['productivity'] = productivity!.toJson();
    }
    if (billing != null) {
      data['billing'] = billing!.toJson();
    }
    if (shipment != null) {
      data['shipment'] = shipment!.toJson();
    }
    if (inventory != null) {
      data['inventory'] = inventory!.toJson();
    }
    if (dgpCompliance != null) {
      data['dgpCompliance'] = dgpCompliance!.toJson();
    }
    if (focusBrand != null) {
      data['focusBrand'] = focusBrand!.toJson();
    }
    return data;
  }
}

class MtdRetailing {
  String? cmIya;
  String? cmSaliance;
  String? cmSellout;
  int? tgtIya;
  int? tgtSaliance;
  int? tgtSellout;

  MtdRetailing(
      {this.cmIya,
        this.cmSaliance,
        this.cmSellout,
        this.tgtIya,
        this.tgtSaliance,
        this.tgtSellout});

  MtdRetailing.fromJson(Map<String, dynamic> json) {
    cmIya = json['cmIya'];
    cmSaliance = json['cmSaliance'];
    cmSellout = json['cmSellout'];
    tgtIya = json['tgtIya'];
    tgtSaliance = json['tgtSaliance'];
    tgtSellout = json['tgtSellout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmIya'] = cmIya;
    data['cmSaliance'] = cmSaliance;
    data['cmSellout'] = cmSellout;
    data['tgtIya'] = tgtIya;
    data['tgtSaliance'] = tgtSaliance;
    data['tgtSellout'] = tgtSellout;
    return data;
  }
}

class Coverage {
  String? cmCoverage;
  String? billing;

  Coverage({this.cmCoverage, this.billing});

  Coverage.fromJson(Map<String, dynamic> json) {
    cmCoverage = json['cmCoverage'];
    billing = json['billing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmCoverage'] = cmCoverage;
    data['billing'] = billing;
    return data;
  }
}

class CallCompliance {
  String? ccCurrentMonth;
  String? ccPreviousMonth;

  CallCompliance({this.ccCurrentMonth, this.ccPreviousMonth});

  CallCompliance.fromJson(Map<String, dynamic> json) {
    ccCurrentMonth = json['ccCurrentMonth'];
    ccPreviousMonth = json['ccPreviousMonth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ccCurrentMonth'] = ccCurrentMonth;
    data['ccPreviousMonth'] = ccPreviousMonth;
    return data;
  }
}

class Productivity {
  String? productivityCurrentMonth;
  String? productivityPreviousMonth;

  Productivity({this.productivityCurrentMonth, this.productivityPreviousMonth});

  Productivity.fromJson(Map<String, dynamic> json) {
    productivityCurrentMonth = json['productivityCurrentMonth'];
    productivityPreviousMonth = json['productivityPreviousMonth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productivityCurrentMonth'] = productivityCurrentMonth;
    data['productivityPreviousMonth'] = productivityPreviousMonth;
    return data;
  }
}

class Billing {
  String? billingActual;
  String? billingIYA;

  Billing({this.billingActual, this.billingIYA});

  Billing.fromJson(Map<String, dynamic> json) {
    billingActual = json['billingActual'];
    billingIYA = json['billingIYA'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['billingActual'] = billingActual;
    data['billingIYA'] = billingIYA;
    return data;
  }
}

class Shipment {
  int? shipmentActual;
  int? shipmentIYA;

  Shipment({this.shipmentActual, this.shipmentIYA});

  Shipment.fromJson(Map<String, dynamic> json) {
    shipmentActual = json['shipmentActual'];
    shipmentIYA = json['shipmentIYA'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shipmentActual'] = shipmentActual;
    data['shipmentIYA'] = shipmentIYA;
    return data;
  }
}

class Inventory {
  int? inventoryActual;
  int? inventoryIYA;

  Inventory({this.inventoryActual, this.inventoryIYA});

  Inventory.fromJson(Map<String, dynamic> json) {
    inventoryActual = json['inventoryActual'];
    inventoryIYA = json['inventoryIYA'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inventoryActual'] = inventoryActual;
    data['inventoryIYA'] = inventoryIYA;
    return data;
  }
}

class DgpCompliance {
  String? gpAchievememt;
  String? gpAbs;
  String? gpIYA;

  DgpCompliance({this.gpAchievememt, this.gpAbs, this.gpIYA});

  DgpCompliance.fromJson(Map<String, dynamic> json) {
    gpAchievememt = json['gpAchievememt'];
    gpAbs = json['gpAbs'];
    gpIYA = json['gpIYA'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gpAchievememt'] = gpAchievememt;
    data['gpAbs'] = gpAbs;
    data['gpIYA'] = gpIYA;
    return data;
  }
}

class FocusBrand {
  String? fbActual;
  int? fbOpportunity;
  String? fbAchievement;

  FocusBrand({this.fbActual, this.fbOpportunity, this.fbAchievement});

  FocusBrand.fromJson(Map<String, dynamic> json) {
    fbActual = json['fbActual'];
    fbOpportunity = json['fbOpportunity'];
    fbAchievement = json['fbAchievement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fbActual'] = fbActual;
    data['fbOpportunity'] = fbOpportunity;
    data['fbAchievement'] = fbAchievement;
    return data;
  }
}
