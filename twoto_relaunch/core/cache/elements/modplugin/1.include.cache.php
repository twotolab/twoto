<?php
function elements_modplugin_1($scriptProperties= array()) {
global $modx;
if (is_array($scriptProperties)) {
extract($scriptProperties, EXTR_SKIP);
}
$e= & $modx->Event;
switch ($e->name) {
    case "OnWebPagePrerender" :
        $modx->documentOutput= str_replace('href="#', 'href="' . $modx->makeUrl($modx->documentIdentifier) . '#', $modx->documentOutput);
        break;
}
}
