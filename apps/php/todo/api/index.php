<?php
require 'vendor/autoload.php';

require_once 'service/ItemsService.php';
require_once 'dao/ItemDAO.php';

$dsn = 'mysql:host='.$_ENV["MYSQL_PORT_3306_TCP_ADDR"] . ':' . $_ENV["MYSQL_PORT_3306_TCP_PORT"] .';dbname='.$_ENV["MYSQL_ENV_MYSQL_DATABASE"];
$user = $_ENV["MYSQL_ENV_MYSQL_USER"];
$pass = $_ENV["MYSQL_ENV_MYSQL_PASSWORD"];

$app = new \Slim\Slim();
$dao = new \dao\ItemDAO($dsn, $user, $pass);
$service = new \service\ItemsService($app, $dao);

// respond to preflights
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    // return only the headers and not the content
    // only allow CORS if we're doing a GET - i.e. no saving for now.
    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']) &&
        $_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD'] == 'GET' &&
        isset($_SERVER['HTTP_ORIGIN']) &&
        is_approved($_SERVER['HTTP_ORIGIN'])) {
        $allowedOrigin = $_SERVER['HTTP_ORIGIN'];
        $allowedHeaders = get_allowed_headers($allowedOrigin);
        header('Access-Control-Allow-Methods: GET, POST, OPTIONS, DELETE'); //...
        header('Access-Control-Allow-Origin: ' . $allowedOrigin);
        header('Access-Control-Allow-Headers: ' . $allowedHeaders);
        header('Access-Control-Max-Age: 3600');
    }
    exit;
}


// TODO move this initialization to the Service class, but how?
$app->get('/items', function() use($service, $app) {
    $pageSize = 10;
    $page = $app->request()->params('page');
    if ($page == null){
        $page = 1;
    }
    $start = ((int)$page - 1) * $pageSize;
    $sortFields = $app->request()->params('sortFields');
    if ($sortFields == null) {
        $sortFields = 'id';
    }
    $sortDirections = $app->request()->params('sortDirections');
    if ($sortDirections == null){
        $sortDirections = 'asc';
    }
    $service->findItems($page, $pageSize, $start, $pageSize, $sortFields, $sortDirections);
});
$app->get('/items/:id', function($id) use($service) {
    $service->read($id);
});
$app->post('/items', function() use($service) {
    $service->save();
});
$app->delete('/items/:id', function($id) use($service) {
    $service->delete($id);
});


$app->run();

?>
