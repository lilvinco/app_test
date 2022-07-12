class Device {
  final String? name;
  final String? id;
  final String? model;
  final String? systemVersion;
  final String? operatingSystem;
  final bool? isPhysicalDevice;

  Device(
      {this.name,
      this.id,
      this.model,
      this.systemVersion,
      this.operatingSystem,
      this.isPhysicalDevice});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'model': model,
      'system_version': systemVersion,
      'operating_system': operatingSystem,
      'is_physical_device': isPhysicalDevice,
    };
  }
}
