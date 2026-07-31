class AppVersionInfo {
  final String latestVersion;
  final String minSupportedVersion;
  final int buildNumber;
  final String downloadUrl;
  final String releaseNotes;
  final String updateType;
  final String? sha256;

  const AppVersionInfo({
    required this.latestVersion,
    required this.minSupportedVersion,
    required this.buildNumber,
    required this.downloadUrl,
    required this.releaseNotes,
    required this.updateType,
    this.sha256,
  });

  factory AppVersionInfo.fromMap(Map<String, dynamic> map) {
    return AppVersionInfo(
      latestVersion: map['latest_version'] as String? ?? '1.0.0', 
      minSupportedVersion: map['min_supported_version'] as String? ?? '1.0.0',    
      buildNumber: (map['build_number'] as num?)?.toInt() ?? 1,  
      downloadUrl: map['download_url'] as String? ?? '',  
      releaseNotes: map['release_notes'] as String? ?? 'New version available.',                                                                                                                                                                                                      
      updateType: map['update_type'] as String? ?? 'optional',
      sha256: map['sha256'] as String?,
      );
  }
}