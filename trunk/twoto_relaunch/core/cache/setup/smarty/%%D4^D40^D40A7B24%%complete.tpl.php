<?php /* Smarty version 2.6.19, created on 2010-11-08 19:55:21
         compiled from complete.tpl */ ?>
<form id="install" action="?action=complete" method="post">
<div>
	<h2><?php echo $this->_tpl_vars['_lang']['thank_installing']; ?>
<?php echo $this->_tpl_vars['app_name']; ?>
.</h2>

    <?php if ($this->_tpl_vars['errors']): ?>
    <div class="note">
    <h3><?php echo $this->_tpl_vars['_lang']['cleanup_errors_title']; ?>
</h3>
        <?php $_from = $this->_tpl_vars['errors']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['error']):
?>
            <p><?php echo $this->_tpl_vars['error']; ?>
</p><hr />
        <?php endforeach; endif; unset($_from); ?>
    </div>
    <br />
    <?php endif; ?>
	<p><?php echo $this->_tpl_vars['_lang']['please_select_login']; ?>
</p>
</div>
<br />

<div class="setup_navbar">
    <label><input type="submit" id="modx-next" name="proceed" value="<?php echo $this->_tpl_vars['_lang']['login']; ?>
" /></label>
    <br /><br />
    <span class="cleanup">
        <label><input type="checkbox" value="1" id="cleanup" name="cleanup" /> <?php echo $this->_tpl_vars['_lang']['delete_setup_dir']; ?>
</label>
    </span>
</div>
</form>