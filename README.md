# Localize
Keep iOS Localization files sane


## Why
Because **Localization** files tend to **rot over time** and become a hassle to work with. **Stressful** when you have to test your app against many different Localizations.

## How
By using a **script** running automatically, you have a **safety net** keeping them **sane**, checking for **translation issues** and preventing then to **rot over time.**

## What

Automatically (On build)
  - **Cleans** you localization files (removes comments and spaces)
  - **Sorts** keys Alphabetically
  - Checks for **Unused Keys**
  - Checks for **Missing Keys**
  - Checks for **Untranslated** (which you can ignore with a flag)

## Usage

- Add the following `Run Script` in XCode, this will run the script at every build.

```shell
# 1 Folder containing your xx.lproj folders
LOCALIZATIONS_FOLDER="$PROJECT_DIR/{ REPLACE ME 1}"
## Ex : LOCALIZATIONS_FOLDER="$PROJECT_DIR/Resources/Languages"

find $LOCALIZATIONS_FOLDER -name "*.strings" -exec sed -i '' '/^\/\// d' {} \;
find $LOCALIZATIONS_FOLDER -name "*.strings" -exec sed -i '' '/^\/\*/ d' {} \;
find $LOCALIZATIONS_FOLDER -name "*.strings" -exec sed -i '' '/^$/d' {} \;
find $LOCALIZATIONS_FOLDER -name "*.strings" -exec sort -f {} -o {} \;

# 2 Path to where you copied Localize.swift script
${SRCROOT}/{REPLACE ME}}
# Ex: ${SRCROOT}/Libs/Localize

```

- Add the path of your localization files `1`
- Add The path of Localize.swift script `2`


Run and Enjoy \o/
