<?php

function include_template($name, $data) {
    $name = 'templates/' . $name;
    $result = '';

    if (!file_exists($name)) {
        return $result;
    }

    ob_start();
    extract($data);
    require_once $name;

    $result = ob_get_clean();

	return $result;
}

function format_money($number) {
	$num = ceil($number);
		if ($num > 1000) {
			$num = number_format($num, 0, '.', ' ');
		}
	$num .= ' ₽';
	return $num; 
}

date_default_timezone_set("Europe/Moscow");

function get_time($endtime) {
	$time_amount = $endtime - time();

	$hours = floor($time_amount / 3600);
	$minutes = floor(($time_amount - $hours * 3600) / 60);

	if ($hours < 10) {
		$hours = '0' . $hours;
	}
	if ($minutes < 10) {
		$minutes = '0' . $minutes;
	}

	return $hours . ':' . $minutes;
}