<?php

// Automatically autoload Composer dependencies
if (is_file(getcwd() . '/vendor/autoload.php')) {
    require_once getcwd() . '/vendor/autoload.php';
}

return [
    # Workaround for https://github.com/bobthecow/psysh/issues/540
    'usePcntl' => false,
];
