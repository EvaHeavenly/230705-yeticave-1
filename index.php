<?php

require_once('functions.php');
require_once('data.php');

$data['main'] = include_template('index.php', $data);

$layout = include_template('layout.php', $data);
echo $layout;