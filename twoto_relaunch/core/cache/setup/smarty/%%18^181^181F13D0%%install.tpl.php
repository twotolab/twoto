<?php /* Smarty version 2.6.19, created on 2010-11-08 19:55:13
         compiled from install.tpl */ ?>
<script type="text/javascript" src="assets/js/sections/install.js"></script>
<form id="install" action="?action=install" method="post">
<h2><?php echo $this->_tpl_vars['_lang']['install_summary']; ?>
</h2>
<?php if ($this->_tpl_vars['failed']): ?>
<p><?php echo $this->_tpl_vars['_lang']['errors_occurred']; ?>
</p>
<?php else: ?>
<p>
    <?php echo $this->_tpl_vars['_lang']['install_success']; ?>

    <br />(<a style="font-size: .9em" href="#continuebtn"><?php echo $this->_tpl_vars['_lang']['skip_to_bottom']; ?>
</a>)
    <br /><br />
    <a href="javascript:void(0);" class="modx-toggle-success"><?php echo $this->_tpl_vars['_lang']['toggle_success']; ?>
</a> | 
    <a href="javascript:void(0);" class="modx-toggle-warning"><?php echo $this->_tpl_vars['_lang']['toggle_warnings']; ?>
</a>
    
</p>
<?php endif; ?>
<ul class="checklist">
<?php $_from = $this->_tpl_vars['results']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['result']):
?>
<li class="<?php echo $this->_tpl_vars['result']['class']; ?>
 finalsuccess" <?php if (! $this->_tpl_vars['failed']): ?>style="display: none;"<?php endif; ?>><?php echo $this->_tpl_vars['result']['msg']; ?>
</li>
<?php endforeach; endif; unset($_from); ?>
</ul>

<br />

<a id="continuebtn"></a>

<div class="setup_navbar">
<?php if ($this->_tpl_vars['failed']): ?>
    <button type="button" id="modx-next" onclick="MODx.go('install');"><?php echo $this->_tpl_vars['_lang']['retry']; ?>
</button>
    <button type="button" id="modx-back" onclick="MODx.go('summary');"><?php echo $this->_tpl_vars['_lang']['back']; ?>
</button>
<?php else: ?>
    <input type="submit" id="modx-next" name="proceed" value="<?php echo $this->_tpl_vars['_lang']['next']; ?>
" />
<?php endif; ?>
</div>
</form>