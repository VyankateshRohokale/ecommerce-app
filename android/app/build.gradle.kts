// D:\Ecommerce-app\ecommerceapp\android\app\build.gradle.kts

plugins {
    id("org.jetbrains.kotlin.android")
    id("com.android.application")
    id("kotlin-android") // Often redundant if org.jetbrains.kotlin.android is present, but harmless
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // This is correct for Firebase setup
}

android {
    namespace = "com.example.ecommerce" // Keep your actual namespace
    compileSdk = flutter.compileSdkVersion

    // FIX 1: Explicitly set the NDK version as required by plugins
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        // FIX 2: Enable core library desugaring
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.ecommerce" // Keep your actual application ID
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // FIX 3: Enable multiDex for larger apps with many dependencies (like Firebase)
        multiDexEnabled = true
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Core library desugaring dependency
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    // Import the Firebase BoM (Bill of Materials) - correct
    implementation(platform("com.google.firebase:firebase-bom:33.16.0"))

    // Firebase Analytics - correct
    implementation("com.google.firebase:firebase-analytics")

    // Add other Firebase products you use, e.g., for messaging:
    implementation("com.google.firebase:firebase-messaging") // Add this for FCM

    // You might also need these if they are not brought in by other plugins
    // implementation("androidx.core:core-ktx:1.10.1") // Example for Kotlin extensions
    // implementation("androidx.appcompat:appcompat:1.6.1") // Example for AppCompat
}