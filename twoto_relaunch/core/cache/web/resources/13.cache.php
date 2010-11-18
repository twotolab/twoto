<?php  return array (
  'resourceClass' => 'modDocument',
  'resource' => 
  array (
    'id' => 13,
    'type' => 'document',
    'contentType' => 'application/rss+xml',
    'pagetitle' => 'twoto - RSS feed',
    'longtitle' => 'twoto -RSS feed',
    'description' => 'RSS feed',
    'alias' => 'rss-feed',
    'link_attributes' => 'RSS feed',
    'published' => 1,
    'pub_date' => 0,
    'unpub_date' => 0,
    'parent' => 0,
    'isfolder' => 0,
    'introtext' => '',
    'content' => '<rss version="2.0">
<channel>
<title>[[*pagetitle]]</title>
<link>[[++site_url]]</link>
<description>[[*description]]</description>
<lastBuildDate>[[!getTime?format=`%a, %d %b %Y %H:%M:%S %z`]]</lastBuildDate>
<language>en-gb</language>

[[!getResources? 
   &parents=`3`
   &limit=`10`
   &sortby=`createdon`
   &sortdir=`DESC`
   &includeTVs=`1`
   &includeContent=`1`
   &tpl=`rssListing`
]]

</channel>
</rss>',
    'richtext' => 1,
    'template' => 0,
    'menuindex' => 1,
    'searchable' => 1,
    'cacheable' => 1,
    'createdby' => 1,
    'createdon' => 1289345676,
    'editedby' => 1,
    'editedon' => 1289347358,
    'deleted' => 0,
    'deletedon' => 0,
    'deletedby' => 0,
    'publishedon' => 1289346660,
    'publishedby' => 1,
    'menutitle' => '',
    'donthit' => 0,
    'haskeywords' => 0,
    'hasmetatags' => 0,
    'privateweb' => 0,
    'privatemgr' => 0,
    'content_dispo' => 0,
    'hidemenu' => 0,
    'class_key' => 'modDocument',
    'context_key' => 'web',
    'content_type' => 6,
    '_content' => '<rss version="2.0">
<channel>
<title>twoto - RSS feed</title>
<link>http://www.twoto.com/</link>
<description>RSS feed</description>
<lastBuildDate>[[!getTime?format=`%a, %d %b %Y %H:%M:%S %z`]]</lastBuildDate>
<language>en-gb</language>

[[!getResources? 
   &parents=`3`
   &limit=`10`
   &sortby=`createdon`
   &sortdir=`DESC`
   &includeTVs=`1`
   &includeContent=`1`
   &tpl=`rssListing`
]]

</channel>
</rss>',
    '_processed' => true,
  ),
  'contentType' => 
  array (
    'id' => 6,
    'name' => 'RSS',
    'description' => 'For RSS feeds',
    'mime_type' => 'application/rss+xml',
    'file_extensions' => '.rss',
    'headers' => NULL,
    'binary' => 0,
  ),
  'elementCache' => 
  array (
    '[[*pagetitle]]' => 'twoto - RSS feed',
    '[[*description]]' => 'RSS feed',
    '[[~30]]' => 'test-with-link.html',
    '[[~24]]' => 'minicabrioconfigurator.html',
    '[[~23]]' => 'freelancingagain.html',
    '[[~22]]' => 'modxrevolution.html',
    '[[~21]]' => 'heavyline.html',
    '[[~20]]' => 'miniconfiguratorapp.html',
    '[[~19]]' => 'under-constructions.html',
    '[[~18]]' => 'launching.html',
    '[[~17]]' => 'bornintents.html',
    '[[~16]]' => 'cabdrinkpitch.html',
  ),
);