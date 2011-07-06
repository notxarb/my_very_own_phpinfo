<?php
header("Content-Type: image/png");

$x = 300;
$y = 3000;

$gd = imagecreatetruecolor($x, $y);
 
$corners[0] = array("x" => 150, "y" =>  10);
$corners[1] = array("x" =>   0, "y" => 290);
$corners[2] = array("x" => 300, "y" => 290);

$red = imagecolorallocate($gd, 255, 0, 0);

for ($i = 0; $i < 10000; $i++) {
  imagesetpixel($gd, round($x),round($y), $red);
  $a = rand(0, 2);
  $x = ($x + $corners[$a]["x"]) / 2;
  $y = ($y + $corners[$a]["y"]) / 2;
}
imagepng($gd); 
?>
