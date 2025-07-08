// D:\Ecommerce-app\ecommerceapp\android\build.gradle.kts

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // These are typically defined here for Kotlin DSL
        classpath("com.android.tools.build:gradle:8.1.0") // Use your current Android Gradle Plugin version
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.0") // Use your current Kotlin version
        
        // This is the line for Firebase Google Services plugin
        classpath("com.google.gms:google-services:4.4.1") // Use the version Firebase recommends
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = file("../build")
subprojects {
    project.buildDir = file("${rootProject.buildDir}/${project.name}")
}
tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}