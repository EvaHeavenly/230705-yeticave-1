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

function get_all_categories($con) {
    $query = mysqli_query($con, "SELECT id, name FROM categories");
    return mysqli_fetch_all($query, MYSQLI_ASSOC);
}
function get_all_lots($con) {
    $query = mysqli_query($con, "SELECT id, name, image FROM lots");
    return mysqli_fetch_all($query, MYSQLI_ASSOC);
}
function get_all_lots_with_categories($con) {
    $query = mysqli_query($con, "SELECT l.id, l.name, l.image, l.start_price, c.name category_name FROM lots l INNER JOIN categories c ON l.category_id = c.id");
    return mysqli_fetch_all($query, MYSQLI_ASSOC);
}
function get_lot_with_bets($con, int $id) {
    $query = mysqli_query($con, "SELECT * FROM lots as l INNER JOIN categories as c ON l.category_id = c.id INNER JOIN bets as b ON l.id = b.lot_id INNER JOIN users as u ON u.id = b.user_id WHERE l.id = $id");
    return mysqli_fetch_all($query, MYSQLI_ASSOC);
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
