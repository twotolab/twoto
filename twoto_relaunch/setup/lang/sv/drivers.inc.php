<?php
/**
 * English Drivers Lexicon Topic for Revolution setup
 *
 * @package setup
 * @subpackage lexicon
 */
$_lang['mysql_err_ext'] = 'MODx kr�ver till�gget mysql f�r PHP och det verkar inte vara laddat.';
$_lang['mysql_err_pdo'] = 'MODx kr�ver drivrutinen pdo_mysql n�r PDO anv�nds och den verkar inte vara laddad.';
$_lang['mysql_version_5051'] = 'MODx kommer att f� problem med din MySQL-version ([[+version]]), p� grund av de m�nga buggar i PDO-drivrutinerna i den versionen. Uppgradera MySQL f�r att r�tta till dessa problem. �ven om du v�ljer att inte anv�nda MODx s� rekommenderas du att uppgradera s� att din webbplats forts�tter vara s�ker och stabil.';
$_lang['mysql_version_client_nf'] = 'MODx kunde inte avg�ra versionen p� MySQL-klienten via mysql_get_client_info(). Kontrollera manuellt att versionen p� din MySQL-klient �r �tminstone 4.1.20 innan du forts�tter.';
$_lang['mysql_version_client_start'] = 'Kontrollerar versionen p� MySQL-klienten:';
$_lang['mysql_version_client_old'] = 'MODx kan f� problem p� grund av att du anv�nder en v�ldigt gammal version av MySQL-klienten ([[+version]]). MODx till�ter installation med denna version av MySQL-klienten, men vi kan inte garantera att all funktionalitet kommer att vara tillg�nglig eller fungera som den ska n�r �ldre versioner av MySQLs klientbibliotek anv�nds.';
$_lang['mysql_version_fail'] = 'Du k�r p� MySQL [[+version]], och MODx Revolution kr�ver MySQL 4.1.20 eller senare. Uppgradera MySQL till minst 4.1.20.';
$_lang['mysql_version_server_nf'] = 'MODx kunde inte avg�ra versionen p� din MySQL-server via mysql_get_server_info(). Kontrollera manuellt att versionen p� MySQL-servern �r minst 4.1.20 innan du forts�tter.';
$_lang['mysql_version_server_start'] = 'Kontrollerar versionen p� MySQL-servern:';
$_lang['mysql_version_success'] = 'OK! K�r: [[+version]]';
