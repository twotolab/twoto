<?php
/*
Credits: Bit Repository
URL: http://www.bitrepository.com/a-simple-ajax-contact-form-with-php-validation.html
*/

include 'config.php';

error_reporting (E_ALL ^ E_NOTICE);

$post = (!empty($_POST)) ? true : false;

if($post)
{
include 'functions.php';

$name = stripslashes($_POST['name']);
$email = $_POST['email'];
$subject = stripslashes($_POST['subject']);
$message = stripslashes($_POST['message']);

$error = '';

// Check name

if(!$name)
{
$error .= 'Please enter your name.';
}

// Check email

if(!$email)
{
$error .= 'Please enter an e-mail address.';
}

if($email && !ValidateEmail($email))
{
$error .= 'Please enter a valid e-mail address.';
}

// Check message (length)

if(!$message || strlen($message) < 15)
{
$error .= "Please enter your message. It should have at least 15 characters.";
}

if(!$error)
{
$mail = mail(WEBMASTER_EMAIL, $subject, $message,
     "From: ".$name." <".$email.">rn"
    ."Reply-To: ".$email."rn"
    ."X-Mailer: PHP/" . phpversion());

if($mail)
{
echo 'OK';
}

}
else
{
echo '<div class="notification_error">'.$error.'</div>';
}

}
?>