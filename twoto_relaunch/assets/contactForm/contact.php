<?php
/*
Credits: Bit Repository
URL: http://www.bitrepository.com/
*/

include 'config.php';

error_reporting (E_ALL ^ E_NOTICE);

$post = (!empty($_POST)) ? true : false;

if($post)
{
include 'functions.php';

$name = stripslashes($_POST['name']);
$from = stripslashes($_POST['from']);
$email = trim($_POST['email']);
$comment1 = stripslashes($_POST['comment1']);
$message = "Hello Patrick Decaix,\n I'am " .$name." from ".$from." and my email is ".$email.".\n
I would like to get in touch with you for the following purpose ".stripslashes($_POST['comment1'])."\n".stripslashes($_POST['comment2']);
$subject = "Contact via twotoform";

$error = '';

// Check name

if(!$name)
{
$error .= '&rarr; Please enter your name.';
}

if(!$comment1)
{
$error .= '&rarr; Please enter your comment.';
}

// Check email

if(!$email)
{
$error .= '&rarr; Please enter an e-mail address.';
}

if($email && !ValidateEmail($email))
{
$error .= '&rarr; Please enter a valid e-mail address.';
}

if(!$error)
{
$mail = mail(WEBMASTER_EMAIL, $subject, $message,
     "From: ".$name." <".$email.">\r\n"
    ."Reply-To: ".$email."\r\n"
    ."X-Mailer: PHP/" . phpversion());


if($mail)
{
echo 'OK';
}

}
else
{
echo '<span class="notification_error">'.$error.'</span>';
}

}
?>