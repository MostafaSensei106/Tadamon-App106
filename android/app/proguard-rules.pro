# Keep all classes inside your app package
-keep class com.mhsensei.tadamon.** { *; }

# Keep Firebase services (إذا كنت تستخدم Firebase)
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**


# Reduce log-related classes
-assumenosideeffects class android.util.Log { *; }
