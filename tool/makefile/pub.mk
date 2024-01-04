.PHONY: version doctor clean get codegen intl upgrade upgrade-major outdated dependencies format

# Check flutter version
version:
	@flutter --version

# Check flutter doctor
doctor:
	@flutter doctor

# Clean all generated files
clean:
	@rm -rf coverage .dart_tool .packages pubspec.lock

# Get dependencies
get:
	@flutter pub get

# Generate code
codegen: get
	@flutter pub run build_runner build --delete-conflicting-outputs
	# @dart pub global run intl_utils:generate
	# @dart format --fix -l 120 .

# Generate l10n strings
l10n:
	@flutter gen-l10n
	
# Generate intl messages
intl:
	@dart pub global run intl_utils:generate
	# @dart format --fix -l 120 .

# Generate all
gen: codegen

# Upgrade dependencies
upgrade:
	@flutter pub upgrade

# Upgrade to major versions
upgrade-major:
	@flutter pub upgrade --major-versions

# Check outdated dependencies
outdated: get
	@flutter pub outdated

# Check outdated dependencies
dependencies: upgrade
	@flutter pub outdated --dependency-overrides \
		--dev-dependencies --prereleases --show-all --transitive

# Format code
format:
	@dart format --fix -l 120 .