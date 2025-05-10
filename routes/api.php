<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\BalanceController;
use App\Http\Controllers\IncrementController;


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/balances', [BalanceController::class, 'index']);
Route::get('/increments', [IncrementController::class, 'index']);
Route::post('/balances', [BalanceController::class, 'store']);            // ← new
Route::post('/balances/increment', [BalanceController::class, 'incrementAll']);
Route::delete('/balances', [BalanceController::class, 'destroyAll']);
Route::delete('/increments', [IncrementController::class, 'destroyAll']);