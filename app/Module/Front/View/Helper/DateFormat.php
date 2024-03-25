<?php

namespace App\Module\Front\View\Helper;

use Air\View\Helper\HelperAbstract;

class DateFormat extends HelperAbstract
{
  /**
   * @param int $timestamp
   * @param string $format
   * @return string
   */
  public function call(int $timestamp, string $format): string
  {
    return date($format, $timestamp);
  }
}