import "dart:convert";
import "dart:math";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class ApiKeysScreen extends StatefulWidget {
  const ApiKeysScreen({super.key});

  @override
  State<ApiKeysScreen> createState() => ApiKeysScreenState();
}

class ApiKeysScreenState extends State<ApiKeysScreen> {
  List<ApiKey> _apiKeys = [];

  @override
  void initState() {
    super.initState();
    _loadApiKeys();
  }

  Future<void> _loadApiKeys() async {
    final keys = await ApiKeyService.getApiKeys();

    setState(() {
      _apiKeys = keys;
    });
  }

  Future<void> _deleteApiKey(String id) async {
    await ApiKeyService.deleteApiKey(id);

    setState(() {
      _apiKeys.removeWhere((k) => k.id == id);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: const Text("Key deleted")));
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasKeys = _apiKeys.isNotEmpty;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(title: const Text("API Keys"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: .end,
                    children: [
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CreateApiKeyScreen(),
                            ),
                          );
                        },
                        child: const Text("Create API Key"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Empty State
                  if (!hasKeys)
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const .all(16),
                          child: Column(
                            children: [
                              Text(
                                "No API Keys yet.",
                                style: TextTheme.of(context).titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Text("Create your first API key to get started."),
                            ],
                          ),
                        ),
                      ),
                    )
                  // Non Empty state
                  else
                    ..._apiKeys.map((key) {
                      return _buildApiKeyCard(key);
                    }),
                ],
              ),
            ),
          ),
          floatingActionButton: isLargeScreen
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateApiKeyScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
        );
      },
    );
  }

  Widget _buildApiKeyCard(ApiKey key) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: const Text("A")),
        title: Text(key.name),
        subtitle: Text(
          key.lastUsedAt == null ? "Never used" : "Last used ${key.lastUsedAt}",
        ),
        trailing: MenuAnchor(
          menuChildren: [
            MenuItemButton(
              onPressed: () async {
                await ApiKeyService.rotateKey(key.id);
                await _loadApiKeys();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text("API Key refreshed.")),
                );
              },
              leadingIcon: const Icon(Icons.refresh),
              child: const Text("Refresh Key"),
            ),
            MenuItemButton(
              onPressed: () async {
                await _deleteApiKey(key.id);
              },
              leadingIcon: const Icon(Icons.delete_outline),
              child: const Text("Delete Key"),
            ),
          ],
          builder: (context, controller, child) {
            return IconButton(
              onPressed: () {
                controller.isOpen ? controller.close() : controller.open();
              },
              icon: const Icon(Icons.more_vert),
            );
          },
        ),
      ),
    );
  }
}

class CreateApiKeyScreen extends StatefulWidget {
  const CreateApiKeyScreen({super.key});

  @override
  State<CreateApiKeyScreen> createState() => CreateApiKeyScreenState();
}

class CreateApiKeyScreenState extends State<CreateApiKeyScreen> {
  String? _newKey;
  bool apiKeyCreated = false;

  late final TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  Future<void> _generateApiKey(String name) async {
    final newKey = await ApiKeyService.createApiKey(name: name);

    setState(() {
      _newKey = newKey.key;
      nameController.text = newKey.key;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Create New API Key"),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 312,
                      child: Card(
                        child: Padding(
                          padding: const .all(16),
                          child: Column(
                            spacing: 16,
                            crossAxisAlignment: .end,
                            children: [
                              if (!apiKeyCreated) ...{
                                TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    floatingLabelBehavior: .always,
                                    label: const Text("Key Name"),
                                  ),
                                ),
                                FilledButton(
                                  onPressed: () async {
                                    await _generateApiKey(nameController.text);

                                    setState(() {
                                      apiKeyCreated = true;
                                    });
                                  },
                                  child: const Text("Create Key"),
                                ),
                              } else ...{
                                TextField(
                                  readOnly: true,
                                  controller: TextEditingController(
                                    text: _newKey,
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    floatingLabelBehavior: .always,
                                    label: const Text("Key Name"),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const .all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: .circular(12),
                                    color: Colors.yellow,
                                  ),
                                  child: Text(
                                    "Important: Copy this key now. You won’t be able to see it again.",
                                    style: TextStyle(
                                      fontWeight: .bold,
                                      color: Colors.yellow.shade900,
                                    ),
                                  ),
                                ),
                                FilledButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Done"),
                                ),
                              },
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: isLargeScreen
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.add),
                ),
        );
      },
    );
  }
}

// Api Key Model
class ApiKey {
  final String id;
  final String key;
  final String name;
  final DateTime createdAt;
  final DateTime? lastUsedAt;
  final bool isActive;

  ApiKey({
    required this.id,
    required this.key,
    required this.name,
    required this.createdAt,
    this.lastUsedAt,
    this.isActive = true,
  });

  // Convert to/from JSON for storage
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "key": key,
      "name": name,
      "createdAt": createdAt.toIso8601String(),
      "lastUsedAt": lastUsedAt?.toIso8601String(),
      "isActive": isActive,
    };
  }

  factory ApiKey.fromJson(Map<String, dynamic> json) {
    return ApiKey(
      id: json["id"],
      key: json["key"],
      name: json["name"],
      createdAt: DateTime.parse(json["createdAt"]),
      lastUsedAt: json["lastUsedAt"] != null
          ? DateTime.parse(json["lastUsedAt"])
          : null,
      isActive: json["isActive"] ?? true,
    );
  }

  // Copy with method for updates
  ApiKey copyWith({
    String? id,
    String? key,
    String? name,
    DateTime? createdAt,
    DateTime? lastUsedAt,
    bool? isActive,
  }) {
    return ApiKey(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}

// Api Key Service
class ApiKeyService {
  static const String _storageKey = "api_keys";

  // Generate a secure API key
  static String generateApiKey() {
    final random = Random.secure();
    final values = List<int>.generate(64, (i) => random.nextInt(256));
    return "sk${base64Url.encode(values)}".replaceAll(
      RegExp(r"[^a-zA-Z0-9]"),
      "",
    );
  }

  // Get key prefix for display
  static String getKeyPrefix(String key) {
    return key.length > 8 ? key.substring(0, 8) : key;
  }

  // Mask API key for security
  static String maskApiKey(String prefix, {int totalLength = 32}) {
    final maskedLength = totalLength - prefix.length;
    return prefix + "*" * (maskedLength > 0 ? maskedLength : 0);
  }

  // Get all API Keys from storage
  static Future<List<ApiKey>> getApiKeys() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getString(_storageKey);
      if (stored == null) return [];

      final List<dynamic> jsonList = json.decode(stored);
      return jsonList.map((json) => ApiKey.fromJson(json)).toList();
    } catch (e) {
      if (kDebugMode) {
        print("Error reading API keys: $e");
      }
      return [];
    }
  }

  // Save API keys to storage
  static Future<void> _setApiKeys(List<ApiKey> apiKeys) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = apiKeys.map((key) => key.toJson()).toList();
      await prefs.setString(_storageKey, json.encode(jsonList));
    } catch (e) {
      if (kDebugMode) {
        print("Error saving API keys: $e");
      }
      throw Exception("Failed to save API keys");
    }
  }

  // Create a new API key
  static Future<ApiKey> createApiKey({
    required String name,
    String? customKey,
  }) async {
    final apiKeys = await getApiKeys();
    final newKey = ApiKey(
      id: "${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}",
      key: customKey ?? generateApiKey(),
      name: name,
      createdAt: DateTime.now(),
      isActive: true,
    );

    final List<ApiKey> updatedKeys = [newKey, ...apiKeys];
    await _setApiKeys(updatedKeys);
    return newKey;
  }

  // Delete an API key by ID
  static Future<void> deleteApiKey(String id) async {
    final apiKeys = await getApiKeys();
    final filteredKeys = apiKeys.where((k) => k.id != id).toList();
    await _setApiKeys(filteredKeys);
  }

  // Update an API key
  static Future<void> updateApiKey(String id, ApiKey updates) async {
    final apiKeys = await getApiKeys();
    final updatedKeys = apiKeys.map((k) {
      if (k.id == id) {
        return k.copyWith(
          name: updates.name,
          lastUsedAt: updates.lastUsedAt,
          isActive: updates.isActive,
        );
      }
      return k;
    }).toList();

    await _setApiKeys(updatedKeys);
  }

  // Update last used timestamp
  static Future<void> updateLastUsed(String id) async {
    final apiKeys = await getApiKeys();
    final updatedKeys = apiKeys.map((k) {
      if (k.id == id) {
        return k.copyWith(lastUsedAt: DateTime.now());
      }
      return k;
    }).toList();

    await _setApiKeys(updatedKeys);
  }

  // Refresh key
  static Future<void> rotateKey(String id) async {
    final apiKeys = await getApiKeys();
    final updated = apiKeys.map((k) {
      if (k.id == id) {
        return k.copyWith(key: generateApiKey(), lastUsedAt: null);
      }
      return k;
    }).toList();

    await _setApiKeys(updated);
  }
}
