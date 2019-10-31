<?php
// Lists loaded PHP extensions
//
// Based on
// https://github.com/composer/composer/blob/050707ed0cdb2d3f9a2c446a9689101a7ad6146f/src/Composer/Repository/PlatformRepository.php#L117
//
// Useful for populating version numbers within Composer's platform section:
// https://getcomposer.org/doc/06-config.md#platform

$loadedExtensions = get_loaded_extensions();

// Extensions scanning
foreach ($loadedExtensions as $name) {
    $reflExt = new \ReflectionExtension($name);
    $prettyVersion = $reflExt->getVersion();
    echo "$name - $prettyVersion\n";
}
