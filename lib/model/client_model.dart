class ClientModel {
  String? clientName;
  int? clientNote;
  int? clientPhone;
  int? clientId;


  ClientModel({
    this.clientName,
    this.clientNote,
    this.clientPhone,
    this.clientId,
   
  });
  ClientModel.fromJson(Map<String, dynamic> json) {
    clientName = json['clientName'];
    clientNote = json['clientNote'];
    clientPhone = json['clientPhone'];
    clientId = json['clientId'];

  }

  Map<String, dynamic> toMap() {
    return {
      'clientName': clientName,
      'clientNote': clientNote,
      'clientPhone': clientPhone,
      'clientId': clientId,
      
    };
  }
}
