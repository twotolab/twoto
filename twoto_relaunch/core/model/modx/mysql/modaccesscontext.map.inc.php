<?php
/**
 * @package modx
 * @subpackage mysql
 */
$xpdo_meta_map['modAccessContext']= array (
  'package' => 'modx',
  'table' => 'access_context',
  'aggregates' => 
  array (
    'Target' => 
    array (
      'class' => 'modContext',
      'local' => 'target',
      'foreign' => 'key',
      'owner' => 'foreign',
      'cardinality' => 'one',
    ),
  ),
);