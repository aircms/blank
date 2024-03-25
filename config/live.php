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
      'db' => 'dbName',
    ],
    'asset' => [
      'underscore' => true,
      'prefix' => '/assets',
    ],
    'storage' => [
      'route' => '_storage',
      'url' => 'https://{fsDomain}',
      'key' => '{fsKey}}'
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
      'auth' => [
        'route' => '_auth',
        'cookieName' => 'authIdentity',
        'source' => 'database',
        'root' => [
          'login' => 'root',
          'password' => 'very-secured-password',
        ]
      ],

      // Don't forget about Tiny key
      'tiny' => '',
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