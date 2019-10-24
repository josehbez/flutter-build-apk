# Flutter Build APK in Docker

```
# android/app/build/build.gradle -> It should match compileSdkVersion=28
# is the API version of Android that you compile against.
ANDROID_COMPILE_SDK "28" 

# -> It should match buildToolsVersion
# is the version of the compilers (aapt, dx, renderscript compiler, etc...) that you want to use.
ANDROID_BUILD_TOOLS "29.0.2" 

# It's what version of the command line tools we're going to download from the official site.
# So, that number really just comes from the latest version available there.
ANDROID_SDK_TOOLS   "4333796" 


FLUTTER_VERSION     "1.9.1+hotfix.5"
```


### [Docker Hub](https://hub.docker.com/r/jhbez/flutter-build-apk/)
```
docker pull jhbez/flutter-build-apk
```

### [GitLab CI/CD](https://gitlab.com) `.gitlab-ci.yml`
```
image: jhbez/flutter-build-apk

stages:
  - build

build:apk:
  stage: build
  script:
    - flutter build apk
  artifacts:
    paths:
     - build/app/outputs/apk
build:bundle:
  stage: build
  script:
    - flutter build appbundle
  artifacts:
    paths:
      - build/app/outputs/bundle
```