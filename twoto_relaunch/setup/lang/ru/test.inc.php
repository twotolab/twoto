<?php
/** 
* Test-related Russian Lexicon Topic for Revolution setup.
*
* @package setup
* @subpackage lexicon
*/
$_lang['test_config_file'] = 'Проверка существования файла <span class="mono">[[+file]]</span> и возможности записи в него: ';
$_lang['test_config_file_nw'] = 'Для новой установки на Linux/Unix системах, создайте пустой файл с именем <span class="mono">[[+key]].inc.php</span> в каталоге <span class="mono">config/</span> с правами доступа, позволяющими веб-серверу его изменять.';
$_lang['test_db_check'] = 'Соединение с базой данных:';
$_lang['test_db_check_conn'] = 'Проверьте параметры соединения и повторите попытку.';
$_lang['test_db_failed'] = 'Соединение с базой данных не установлено!';
$_lang['test_db_setup_create'] = 'Программа установки попытается создать базу данных.';
$_lang['test_dependencies'] = 'Проверка PHP расширения zlib: ';
$_lang['test_dependencies_fail_zlib'] = 'Конфигурация PHP не имеет подключённого расширения zlib. Это расширение является необходимым для запуска MODx. Подключите это расширение для продолжения установки.';
$_lang['test_directory_exists'] = 'Проверка существования каталога <span class="mono">[[+dir]]</span> : ';
$_lang['test_directory_writable'] = 'Проверка возможности записи в каталог <span class="mono">[[+dir]]</span>: ';
$_lang['test_memory_limit'] = 'Проверка ограничения выделяемой памяти (должно быть не менее 24 MБ): ';
$_lang['test_memory_limit_fail'] = 'Параметр memory_limit меньше 24 МБ. MODx не смог самостоятельно его повысить. Для продолжения, установите в файле php.ini этот параметр равным или больше 24 MБ. Если это не решило проблему (пустой белый экран во время установки), повышайте memory_limit до 32 МБ, 64 МБ или выше.';
$_lang['test_memory_limit_success'] = 'OK! memory_limit равен [[+memory]]';
$_lang['test_mysql_version_5051'] = 'MODx будет испытывать проблемы с вашей версией MySQL  ([[+version]]), которые обусловлены многочисленными ошибками, связанных с работой её PDO драйвера. Обновите MySQL для устранения этих проблем. Даже если вы не будете использовать MODx, мы рекомендуем обновить эту версию  для повышения стабильности и безопасности.';
$_lang['test_mysql_version_client_nf'] = 'Не удаётся определить версию клиента MySQL!';
$_lang['test_mysql_version_client_nf_msg'] = 'MODx не смог определить версию клиента MySQL, используя функцию mysql_get_client_info(). Проверьте версию самостоятельно, она должна быть не ниже 4.1.20.';
$_lang['test_mysql_version_client_old'] = 'Могут возникнуть проблемы в работе MODx, потому что вы используете очень старую версию MySQL клиента ([[+version]])';
$_lang['test_mysql_version_client_old_msg'] = 'MODx позволяет установку с этой версией MySQL клиента, но мы не можем гарантировать что все функциональные возможности будут доступны и будут работать должным образом при использовании старых версий MySQL клиента.';
$_lang['test_mysql_version_client_start'] = 'Проверка версии клиента MySQL:';
$_lang['test_mysql_version_fail'] = 'Используется MySQL [[+version]], но MODx Revolution требует MySQL 4.1.20 или выше. Обновите MySQL до версии не ниже 4.1.20.';
$_lang['test_mysql_version_server_nf'] = 'Не удалось определить версию сервера MySQL!';
$_lang['test_mysql_version_server_nf_msg'] = 'MODx не смог определить версию сервера MySQL, используя функцию mysql_get_server_info(). Проверьте её самостоятельно, она должна быть не ниже 4.1.20.';
$_lang['test_mysql_version_server_start'] = 'Проверка версии сервера MySQL:';
$_lang['test_mysql_version_success'] = 'OK! Работает: [[+version]]';
$_lang['test_php_version_fail'] = 'Используется PHP [[+version]], а для работы MODx Revolution необходим PHP версии 5.1.1 или выше. Обновите PHP до версии не ниже 5.1.1. MODx рекомендует обновление до 5.3.0.';
$_lang['test_php_version_516'] = 'MODx будет работать с ошибками на используемой версии PHP ([[+version]]), это связано с большим количеством ошибок в её драйверах PDO. Обновите PHP до версии 5.3.0 или выше. MODx рекомендует обновиться до 5.3.2+. Даже если вы не будете использовать MODx, рекомендуется обновиться до этой версии для стабильности и безопасности.';
$_lang['test_php_version_520'] = 'MODx будет работать с ошибками на используемой версии PHP ([[+version]]), это связано с большим количеством ошибок в её драйверах PDO. Обновите PHP до версии 5.3.0 или выше, что исправит эти ошибки. MODx рекомендует обновиться до 5.3.2+. Даже если вы не будете использовать MODx, рекомендуется обновиться до этой версии для стабильности и безопасности.';
$_lang['test_php_version_start'] = 'Проверка версии PHP:';
$_lang['test_php_version_success'] = 'ОК! Работает: [[+version]]';
$_lang['test_sessions_start'] = 'Проверка настроек сессий:';
$_lang['test_simplexml'] = 'Проверка SimpleXML:';
$_lang['test_simplexml_nf'] = 'Не удалось найти SimpleXML!';
$_lang['test_simplexml_nf_msg'] = 'MODx не смог найти SimpleXML в вашем окружении PHP. Управление пакетами и другие возможности не будут работать. Вы можете продолжить установку, но рекомендуется включить SimpleXML для использования всех возможностей.';
$_lang['test_table_prefix'] = 'Проверка префикса таблиц `[[+prefix]]`: ';
$_lang['test_table_prefix_inuse'] = 'Такой префикс таблиц уже используется в указанной базе данных!';
$_lang['test_table_prefix_inuse_desc'] = 'Установка не может быть произведена в выбранной базе данных, поскольку она уже содержит таблицы с указанным префиксом. Выберите другой table_prefix и попробуйте ещё раз.';
$_lang['test_table_prefix_nf'] = 'В выбранной базе данных нет такого префикса таблиц!';
$_lang['test_table_prefix_nf_desc'] = 'Продолжение установки невозможно, так как нет таблиц с указанным префиксом. Измените table_prefix и попробуйте ещё раз.';
$_lang['test_zip_memory_limit'] = 'Проверка ограничения выделяемой памяти (должно быть не менее 24 MБ): ';
$_lang['test_zip_memory_limit_fail'] = 'Параметр memory_limit меньше 24 МБ. MODx не смог самостоятельно его повысить. Для корректной работы расширений zip, установите в файле php.ini этот параметр равным или больше 24 MБ.';