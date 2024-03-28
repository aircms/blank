<?php

return [
  'env' => 'live',
  'air' => [
    'modules' => '\\App\\Module',
    'exception' => false,
    'phpIni' => [
      'display_errors' => '0',
    ],
    'startup' => [
      'error_reporting' => 0,
    ],
    'loader' => [
      'path' => realpath(dirname(__FILE__)) . '/../app',
      'namespace' => 'App',
    ],
    'db' => [
      'driver' => 'mongodb',
      'servers' => [[
        'host' => 'localhost',
        'port' => 27017,
      ]],
      'db' => getenv('AIR_DB_NAME'),
    ],
    'asset' => [
      'underscore' => false,
      'prefix' => '/assets',
    ],
    'storage' => [
      'route' => '_storage',
      'url' => getenv('AIR_FS_URL'),
      'key' => getenv('AIR_FS_KEY'),
    ],
    'logs' => [
      'enabled' => true,
      'route' => '_logs',
    ],
    'admin' => [
      'title' => 'Your great project',
      'logo' => '/assets/logo.png',
      'manage' => '_admin',
      'history' => '_adminHistory',
      'system' => '_system',
      'fonts' => '_fonts',
      'codes' => '_codes',
      'auth' => [
        'route' => '_auth',
        'cookieName' => 'authIdentity',
        'source' => 'database',
        'root' => [
          'login' => getenv('AIR_ADMIN_ROOT_LOGIN'),
          'password' => getenv('AIR_ADMIN_ROOT_PASSWORD'),
        ]
      ],
      'tiny' => getenv('AIR_ADMIN_TINY'),
      'menu' => require_once 'nav.php',
    ]
  ],
  'router' => [
    'admin.*' => [
      'module' => 'admin',
    ],
    '*' => [
      'strict' => true,
      'module' => 'front',
      'routes' => require_once 'routes.php',
      'air' => [
        'view' => [
          'minify' => true
        ],
      ],
    ],
  ],
];