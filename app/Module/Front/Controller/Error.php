<?php

declare(strict_types=1);

namespace App\Module\Front\Controller;

use Air\Core\ErrorController;
use Air\Core\Exception\ClassWasNotFound;
use Air\Core\Front;
use Air\Log;
use Exception;

class Error extends ErrorController
{
  /**
   * @return void
   * @throws ClassWasNotFound
   * @throws Exception
   */
  public function index(): void
  {
    $exception = $this->getException();
    $this->getResponse()->setStatusCode($exception->getCode());
    $trace = array_values(array_filter(explode('#', $exception->getTraceAsString())));

    Log::error($exception->getMessage(), [
      'ip' => $this->getRequest()->getIp(),
      'user-agent' => $this->getRequest()->getUserAgent(),
      'trace' => $trace,
      'params' => [
        'get' => $this->getRequest()->getGetAll(),
        'post' => $this->getRequest()->getPostAll(),
      ],
    ]);

    $exceptionEnabled = Front::getInstance()->getConfig()['air']['exception'] ?? false;

    $this->getView()->assign('title', 'Error page');
    $this->getView()->assign('exceptionEnabled', $exceptionEnabled);

    $this->getView()->assign('message', $exception->getMessage());
    $this->getView()->assign('trace', $exception->getTraceAsString());
  }
}