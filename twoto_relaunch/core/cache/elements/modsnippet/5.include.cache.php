<?php
function elements_modsnippet_5($scriptProperties= array()) {
global $modx;
if (is_array($scriptProperties)) {
extract($scriptProperties, EXTR_SKIP);
}
return strftime($scriptProperties['format']);
}
