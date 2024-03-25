<?php

declare(strict_types=1);

namespace App\Module\Front\Controller;

use Air\Core\Controller;
use Air\Core\Front;
use Exception;

class Index extends Controller
{
  /**
   * @return void
   * @throws Exception
   */
  public function index(): void
  {
    $title = Front::getInstance()->getConfig()['air']['admin']['title'];

    $this->getView()->assign('title', $title);
    $this->getView()->assign('variable', 'some value');
  }
}