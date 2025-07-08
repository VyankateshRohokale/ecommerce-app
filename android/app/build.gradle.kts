plugins {
    id("org.jetbrains.kotlin.android")
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // Removed: id("com.google.gms.google-services")
}

android {
    namespace = "com.example.ecommerce"
    compileSdk = flutter.compileSdkVersion

    // Removed: ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        // Removed: isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = '1.8'
    }

    defaultConfig {
        applicationId = "com.example.ecommerce"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // Removed: multiDexEnabled = true
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
    coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:2.0.4'
    // Removed: coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    // Removed Firebase BoM and specific Firebase product dependencies
    // implementation(platform("com.google.firebase:firebase-bom:33.16.0"))
    // implementation("com.google.firebase:firebase-analytics")
    // implementation("com.google.firebase:firebase-messaging")
}