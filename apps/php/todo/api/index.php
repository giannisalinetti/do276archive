<?php
require 'vendor/autoload.php';

require_once 'service/ItemsService.php';
require_once 'dao/ItemDAO.php';

$dsn = 'mysql:host=127.0.0.1;dbname=todo';
$user = 'root';
$pass = '';

$app = new \Slim\Slim();
$dao = new \dao\ItemDAO($dsn, $user, $pass);
$service = new \service\ItemsService($app, $dao);

// TODO move this initialization to the Service class, but how?
$app->get('/items', function() use($service, $app) {
    $pageSize = 10;
    $page = $app->request()->params('page');
    if ($page == null){
        $page = 1;
    }
    $start = ((int)$page - 1) * $pageSize;
    $sortFields = $app->request()->params('sortFields');
    $sortDirections = $app->request()->params('sortDirections');
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
