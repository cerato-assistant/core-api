<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::any('/', function (Request $request) {
    echo response()->json(['message' => 'Api Running']);
});
