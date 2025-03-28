import { type Build } from 'cmake-ts-gen';

const build: Build = {
    common: {
        project: 'zstd',
        archs: ['x64'],
        variables: [],
        copy: {},
        defines: [],
        options: [
            ['ZSTD_BUILD_SHARED', false],
        ],
        subdirectories: ['zstd/build/cmake'],
        libraries: {
            libzstd_static: {
                name: 'zstd'
            }
        },
        buildDir: 'build',
        buildOutDir: '../../libs',
        buildFlags: []
    },
    platforms: {
        win32: {
            windows: {},
            android: {
                archs: ['x86', 'x86_64', 'armeabi-v7a', 'arm64-v8a'],
            }
        },
        linux: {
            linux: {}
        },
        darwin: {
            macos: {}
        }
    }
}

export default build;