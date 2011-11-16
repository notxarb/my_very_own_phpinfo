<?php
if (isset($_SERVER['CACHE1_HOST'])) {
    $memcache = new Memcache;
    $memcache->addServer($_SERVER['CACHE1_HOST'], $_SERVER['CACHE1_PORT'] );
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