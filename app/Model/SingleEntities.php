<?php

namespace App\Model;

use Air\Model\ModelAbstract;
use Air\Type\File;
use Air\Type\Meta;
use Air\Type\Quote;
use Air\Type\RichContent;

/**
 * @collection SingleEntities
 *
 * @property string $id
 * @property boolean $enabled
 * @property string $url
 *
 * @property string $title
 * @property string $subTitle
 * @property string $description
 *
 * @property integer $date
 * @property integer $dateTime
 *
 * @property File $image
 * @property File[] $images
 *
 * @property Quote $quote
 *
 * @property string $embed
 * @property string $content
 *
 * @property RichContent[] $richContent
 *
 * @property Meta $meta
 *
 * @property integer $position
 *
 * @property string $status
 *
 * @property integer $createdAt
 * @property integer $updatedAt
 *
 * @property SingleEntities $singleModelRef
 * @property SingleEntities[] $multipleModelRef
 */
class SingleEntities extends ModelAbstract
{
  const STATUS_1 = 'status-1';
  const STATUS_2 = 'status-2';
}
