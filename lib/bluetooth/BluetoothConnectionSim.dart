class BluetoothConnectionSim{
  bool connected;
  String name;
  static int numConnected = 0;

  BluetoothConnectionSim(name){
    this.name = name;
    this.connected = false;
  }

  void connect(){
    connected = true;
  }

  void disconnect(){
    connected = false;
  }
}