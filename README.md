# Flutter Build APK in Docker

```
ANDROID_COMPILE_SDK "28" 
ANDROID_BUILD_TOOLS "29.0.2" 
ANDROID_SDK_TOOLS   "4333796" 
FLUTTER_VERSION     "1.9.1+hotfix.2"
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