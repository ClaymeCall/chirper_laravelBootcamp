<?php

use App\Http\Controllers\ChirpController;

Route::get('/', [ChirpController::class, 'index']);


Route::middleware('auth')->group(function () {
    Route::post('/chirps', [ChirpController::class, 'store']);
    Route::get('/chirps/{chirp}/edit', [ChirpController::class, 'edit']);
    Route::put('/chirps/{chirp}', [ChirpController::class, 'update']);
    Route::delete('/chirps/{chirp}', [ChirpController::class, 'destroy']);
});


use App\Http\Controllers\Auth\Register;

// Registration routes
Route::view('/register', 'auth.register')
    ->middleware('guest')
    ->name('register');

Route::post('/register', Register::class)
    ->middleware('guest');

use App\Http\Controllers\Auth\Login;
use App\Http\Controllers\Auth\Logout;

// Login routes
Route::view('/login', 'auth.login')
    ->middleware('guest')
    ->name('login');

Route::post('/login', Login::class)
    ->middleware('guest');

// Logout routes
Route::post('/logout', Logout::class)
    ->middleware('auth')
    ->name('logout');
