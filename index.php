<?php

require_once('functions.php');

$con = mysqli_connect("localhost", "root", "", "yeticave_1");

$is_auth = rand(0, 1);

$user_name = 'Константин';
$user_avatar = 'img/user.jpg';

$title = 'Главная';

$data = [
    'categories' => get_all_categories($con),
    'lots_with_categories' => get_all_lots_with_categories($con),
    'is_auth' => $is_auth,
    'user_avatar' => $user_avatar,
    'user_name' => $user_name,
    'title' => $title
];

$data['main'] = include_template('index.php', $data);

$layout = include_template('layout.php', $data);
echo $layout;