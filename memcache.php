<?php
if (isset($_SERVER['CACHE2_HOST'])) {
    $memcache = new Memcache;
    $memcache->addServer($_SERVER['CACHE2_HOST'], $_SERVER['CACHE2_PORT'] );
    $memcache->set("test_key", "test_value");
    $value = $memcache->get("test_key");
    if ($value == "test_value") {
        echo "matches!";
    }
    else {
        echo "doesn't match";
    }
}
else {
    echo 'no memcache server';
}
?>
