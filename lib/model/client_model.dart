class ClientModel {
  String? clientName;
  int? clientNote;
  int? clientPhone;
  int? clientId;
  double? forHim;
  double? onHim;

  ClientModel({
    this.clientName,
    this.clientNote,
    this.clientPhone,
    this.clientId,
    this.forHim,
    this.onHim,
  });
  ClientModel.fromJson(Map<String, dynamic> json) {
    clientName = json['clientName'];
    clientNote = json['clientNote'];
    clientPhone = json['clientPhone'];
    clientId = json['clientId'];
    forHim = json['forHim'];
    onHim = json['onHim'];
  }

  Map<String, dynamic> toMap() {
    return {
      'clientName': 'clientName',
      'clientNote': 1,
      'clientPhone': 078,
      'clientId': 2,
      'forHim': 2,
      'onHim': 5,
    };
  }
}
