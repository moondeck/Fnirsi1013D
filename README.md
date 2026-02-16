*** Fnirsi1013D alternative firmwware

Based on work done by Atlan4, pecostm32 and others. Thank you!

This serves as a base for my own modifications and improvements to the firmware done by Atlan4. It is based on the 1.00o5 from his repository.

I will try to keep it up to date with the latest improvements and bugfixes from the original repository, when it is possible for me.
Mostly however, it is a base for my own use - use it if you'd like, or don't :D

I have attempted to take the original code and create more structure in the organisation of the source, I will eventually try to also document relevant parts and how things fit together.

PLEASE refer to the original repo for instructions on how to use, for now.

## Building

To build the firmware locally:
```bash
make all
```

This will create `build/fnirsi_1013d_scope.bin` which can be flashed to the device.

## Releases

Firmware binaries are automatically built and published as GitHub Releases. To create a new release:

1. Create and push a version tag:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

2. The GitHub Actions workflow will automatically:
   - Build the firmware binary
   - Create a new release with the tag name
   - Attach the `fnirsi_1013d_scope.bin` file to the release

Download the latest firmware from the [Releases page](https://github.com/moondeck/Fnirsi1013D/releases).