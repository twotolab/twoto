<?php
/**
 * Import Thai lexicon entries
 *
 * @language th
 * @package modx
 * @subpackage lexicon
  
 * @author Mr.Kittipong Intaboot COE#18,KKU
 * @updated 2010-07-21
 */
$_lang['import_allowed_extensions'] = 'ระบุรายการคั่นด้วยจุลภาคของนามสกุลไฟล์ที่จะนำเข้า <br /><small><em>ปล่อยว่างเพื่อนำเข้าไฟล์ทั้งหมดตามประเภทเนื้อหาที่ใช้ได้บนเว็บไซต์ของคุณ หากไม่รู้จักประเภทจะถูกจัดให้เป็นข้อความธรรม.</em></small>';
$_lang['import_base_path'] = 'ป้อนเส้นทางที่อยู่ของไฟล์ที่จะนำเข้า<br /><small><em>ปล่อยว่างไว้เพื่อใช้เป้าหมายที่ตั้งไว้ในเส้นทางสเตติกไฟล์ของบริบทที่ตั้งค่าไว้</em></small>';
$_lang['import_duplicate_alias_found'] = 'รีซอร์ส [[+id]] ใช้ alias [[+alias]] เรีบยร้อยแล้ว กรุณาป้อน alias ที่เป็นเอกลักษณ์เฉพาะตัว';
$_lang['import_element'] = 'ป้อนรูทอิเลเมนต์ของ HTML ที่จะนำเข้า:';
$_lang['import_enter_root_element'] = 'ป้อนรูทอิเลเมนต์ที่จะนำเข้า:';
$_lang['import_files_found'] = '<strong>พบ %s เอกสารสำหรับการนำเข้า...</strong><p/>';
$_lang['import_parent_document'] = 'แพเรนต์ของเอกสาร:';
$_lang['import_parent_document_message'] = 'ใช้แผนผังเอกสารข้างล่าง เพื่อเลือกที่ตั้งหลักที่จะนำไฟล์ที่นำเข้าไปเก็บเอาไว้';
$_lang['import_resource_class'] = 'เลือกคลาส modResource สำหรับนำเข้า:<br /><small><em>ใช้ modStaticResource เพื่อเชื่อมโยงกับสเตติกไฟล์หรือ modDocument เพื่อคัดลอกเนื้อหาลงฐานข้อมูล</em></small>';
$_lang['import_site_failed'] = '<span style="color:#990000">ล้มเหลว!</span>';
$_lang['import_site_html'] = 'นำเข้าเว็บไซต์จาก HTML';
$_lang['import_site_importing_document'] = 'กำลังนำเข้าไฟล์ <strong>%s</strong> ';
$_lang['import_site_maxtime'] = 'เวลาสูงสุดในการนำเข้า:';
$_lang['import_site_maxtime_message'] = 'คุณสามารถระบุจำนวนวินาทีที่ตัวจัดการเนื้อหาจะสามารถใช้ในการนำเข้าข้อมูล (แทนที่การตั้งค่า PHP) ป้อน 0 หากไม่มีการจำกัดเวลา  โปรด อย่าลืมว่าค่าเป็น 0  หรือจำนวนมากๆ จะนำไป สู่ข้อผิดพลาดร้ายแรงของเซิร์ฟเวอร์ของคุณ ซึ่งเราไม่แนะนำ';
$_lang['import_site_message'] = '<p>ในการใช้งานเครื่องมือนี้ คุณสามารถนำเข้าเนื้อหาจากชุดของไฟล์ HTML ลงในฐานข้อมูล <em>โปรดอย่าลืมว่าคุณจะต้องคัดลอกไฟล์ของคุณและ/หรือโฟลเดอร์ไปไว้ที่โฟลเดอร์ core/import</em></p><p>กรุณากรอกแบบฟอร์มตัวเลือกข้างล่าง ตัวเลือกเพิ่มเติม  เลือกแพเรนต์รีซอร์สสำหรับนำเข้าไฟล์จากแผนผังเอกสาร แล้วกด \'นำเข้า HTML\' เพื่อเริ่มกระบวนการนำเข้า ไฟล์ที่นำเข้าจะถูกบันทึกไว้ที่ที่ตั้งที่เลือก  โดยจะใช้ชื่อของไฟล์จะเป็น alias ของเอกสาร และถ้าเป็น HTML หัวเรื่องของหน้าจะเป็นหัวเรื่องของเอกสาร</p>';
$_lang['import_site_resource'] = 'นำเข้ารีซอร์สจากสเตติกไฟล์';
$_lang['import_site_resource_message'] = '<p>ในการใช้งานเครื่องมือนี้ คุณสามารถนำเข้ารีซอร์สจากชุดของสเตติกไฟล์ลงฐานข้อมูล <em>โปรดอย่าลืมว่าคุณจะต้องคัดลอกไฟล์ของคุณและ/หรือโฟลเดอร์ไปไว้ที่โฟลเดอร์ core/import</em></p><p>กรุณากรอกแบบฟอร์มตัวเลือกข้างล่าง ตัวเลือกเพิ่มเติม เลือกแพเรนต์รีซอร์สสำหรับนำเข้าไฟล์จากแผนผังเอกสาร แล้วกด \'นำเข้ารีซอร์ส\' เพื่อเริ่มกระบวนการนำเข้า ไฟล์ที่นำเข้าจะถูกบันทึกไว้ที่ที่ตั้งที่เลือก โดยจะใช้ชื่อของไฟล์จะเป็น alias ของเอกสาร และถ้าเป็น HTML หัวเรื่องของหน้าจะเป็นหัวเรื่องของเอกสาร</p>';
$_lang['import_site_skip'] = '<span style="color:#990000">ข้าม!</span>';
$_lang['import_site_start'] = 'เริ่มการนำเข้า';
$_lang['import_site_success'] = '<span style="color:#009900">สำเร็จ!</span>';
$_lang['import_site_time'] = 'การนำเข้าเสร็จสิ้น โดยใช้เวลา %s วินาทีจนเสร็จสมบูรณ์';
$_lang['import_use_doc_tree'] = 'ใช้แผนผังเอกสารข้างล่าง เพื่อเลือกที่ตั้งในการนำเข้าข้อมูลไปใส่ไว้';