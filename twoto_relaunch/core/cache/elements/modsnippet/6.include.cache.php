<?php
function elements_modsnippet_6($scriptProperties= array()) {
global $modx;
if (is_array($scriptProperties)) {
extract($scriptProperties, EXTR_SKIP);
}
return "<![CDATA[{$input}]]>";
}
