# Recovery — StoreAMO-Install

## Scope

This procedure restores the StoreAMO-Install repository and its platform-routing entrypoint. It does not create, replace, sign, publish, or silently install StoreAMO artifacts.

## Canonical invariant

Android recovery must preserve the permanent bootstrap contract exactly:

- StoreAMO seed version: `0.0.1`
- release: `seed-v0.0.1`
- asset: `StoreAMO-0.0.1.apk`
- allowed seed permissions: `INTERNET` and `REQUEST_INSTALL_PACKAGES`
- SHA-256 verification before handing the APK to Android `PackageInstaller`
- visible Android confirmation remains required; Play Protect is not bypassed

Do not create another `0.0.x` bootstrap line as a recovery mechanism. The main StoreAMO versions independently and must be discovered from its current stable release.

## Recovery procedure

1. Identify the last known-good StoreAMO-Install commit from Git history and CI evidence.
2. Create a recovery branch from the current default branch; do not rewrite `main` history.
3. Restore only repository-owned files required for platform routing and canonical seed discovery.
4. Run `bash scripts/autocheck.sh` and the repository CI.
5. Compare the recovery diff against the last known-good behavior. Reject any change that expands permissions, weakens hash verification, changes the canonical seed, adds signing material, or enables silent installation.
6. Merge through a pull request only after the applicable gates pass.
7. After merge, verify CI again on the resulting `main` SHA before declaring recovery complete.

## Rollback

If a recovery change regresses the entrypoint, revert the recovery commit/PR through Git and rerun the same AutoCheck. Do not repair a failed recovery by modifying StoreAMO releases, signing keys, device security policy, or the permanent seed.

## Evidence and limits

A successful repository/CI recovery proves only that StoreAMO-Install satisfies its declared checks. It does not prove physical installation on a device, current StoreAMO release health, signing validity beyond checks actually executed, or user confirmation in Android. Those remain separate operational evidence.