<?php  return array (
  'config' => 
  array (
    'allow_tags_in_post' => '1',
    'modRequest.class' => 'modManagerRequest',
  ),
  'resourceMap' => 
  array (
  ),
  'resourceListing' => 
  array (
  ),
  'aliasMap' => 
  array (
  ),
  'documentMap' => 
  array (
  ),
  'eventMap' => 
  array (
    'OnWebPagePrerender' => 
    array (
      1 => '1',
    ),
  ),
  'pluginCache' => 
  array (
    1 => 
    array (
      'id' => 1,
      'name' => 'AnchorsAway',
      'description' => '',
      'editor_type' => 0,
      'category' => 0,
      'cache_type' => 0,
      'plugincode' => '$e= & $modx->Event;
switch ($e->name) {
    case "OnWebPagePrerender" :
        $modx->documentOutput= str_replace(\'href="#\', \'href="\' . $modx->makeUrl($modx->documentIdentifier) . \'#\', $modx->documentOutput);
        break;
}',
      'locked' => 0,
      'properties' => 'a:0:{}',
      'disabled' => 0,
      'moduleguid' => '',
    ),
  ),
);