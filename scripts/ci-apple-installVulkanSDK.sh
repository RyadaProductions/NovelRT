echo "NovelRT Vulkan SDK + MoltenVK installer for macOS"
echo "This utility is only meant for CI purposes only!"
echo ""

if [[ ! -n $1 ]];
then 
    echo "No version parameter passed."
else
    if [[ ! -n $2 ]];
    then
        echo "No destination directory passed."
    else
        local version=$1
        local sdk_path=$2
        local url=https://sdk.lunarg.com/sdk/download/$version/mac/vulkansdk-macos-$version.dmg?Human=true
        echo "Downloading Vulkan SDK v. $version"

        #Download the SDK
        curl -s -L -o vulkan_sdk.dmg $url

        #Mount the dmg
        test -f vulkan_sdk.dmg
        local mountpoint=$(hdiutil attach vulkan_sdk.dmg | grep vulkansdk | awk 'END {print $NF}')
        if [[ -d $mountpoint ]] ; then
            echo "Mounted dmg image: 'vulkan_sdk.dmg' (mountpoint=$mountpoint)" >&2
        else
            echo "Could not mount dmg image: vulkan_sdk.dmg (mountpoint=$mountpoint)" >&2
            exit 7
        fi

        sudo $mountpoint/InstallVulkan.app/Contents/MacOS/InstallVulkan --root "$sdk_path" --accept-licenses --default-answer --confirm-command install
        hdiutil detach $mountpoint
        rm vulkan_sdk.dmg

        #Write the VULKAN_SDK env var to the Github Environment variables
        echo "VULKAN_SDK=$sdk_path/$version/macOS" >> $GITHUB_ENV
    fi
fi