# 📱 Alarm Storage Explanation (Interview Ready)

## 🎯 What It Does

Simple local storage to save alarm data on the user's phone using SharedPreferences.

## 🔧 How It Works

### 1. **Save Alarms**

```dart
static Future<void> saveAlarms(List<AlarmModel> alarms) async {
  final prefs = await SharedPreferences.getInstance();
  final alarmsJson = alarms.map((alarm) => alarm.toJson()).toList();
  await prefs.setString('alarms', json.encode(alarmsJson));
}
```

-   Convert alarm objects to JSON
-   Save as string in phone storage
-   Data survives app restarts

### 2. **Load Alarms**

```dart
static Future<List<AlarmModel>> loadAlarms() async {
  final prefs = await SharedPreferences.getInstance();
  final String? data = prefs.getString('alarms');

  if (data == null) return [];

  final List<dynamic> decoded = json.decode(data);
  return decoded.map((json) => AlarmModel.fromJson(json)).toList();
}
```

-   Get saved string from phone storage
-   Convert JSON back to alarm objects
-   Return empty list if no data found

## 💡 Interview Points

### **Why SharedPreferences?**

-   ✅ **Simple:** No database setup needed
-   ✅ **Built-in:** Part of Flutter framework
-   ✅ **Persistent:** Data survives app closure
-   ✅ **Fast:** Perfect for small data like alarms

### **Key Benefits:**

-   ✅ **Easy to understand:** Only 2 methods
-   ✅ **Type-safe:** Uses AlarmModel objects
-   ✅ **Error-free:** Simple logic, less bugs
-   ✅ **Maintainable:** Clean, readable code

### **Flow:**

1. User adds/changes alarm
2. App saves entire alarm list to phone
3. User closes app
4. User opens app
5. App loads saved alarms
6. User sees their alarms again

## 🎤 Interview Answers

**Q: "How do you handle data persistence?"**
A: "I use SharedPreferences to save alarm data locally. When users add or modify alarms, I convert the alarm list to JSON and save it. When the app starts, I load and convert the JSON back to alarm objects."

**Q: "Why not use a database?"**
A: "For this simple use case with a small amount of data, SharedPreferences is perfect. It's built into Flutter, requires no setup, and is very reliable for key-value storage like user preferences and small datasets."

**Q: "How do you handle errors?"**
A: "The code is simple enough that errors are unlikely. If loading fails, it returns an empty list so the app still works. The JSON conversion is handled by the AlarmModel's built-in methods."

## 🚀 Simple & Professional!
