plugins {
    kotlin("js") version "1.4.31"
}

group = "me.kyoya"
version = "1.0-SNAPSHOT"

repositories {
    jcenter()
    mavenCentral()
}

dependencies {
    implementation("org.jetbrains.kotlinx:kotlinx-nodejs:0.0.7")
    implementation("io.ktor:ktor-server:1.5.2")
}

kotlin {
    js(IR) {
        nodejs {
            binaries.executable()
        }
    }
}