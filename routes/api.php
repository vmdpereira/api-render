<?php

use Illuminate\Support\Facades\Route;

Route::get('/status', function () {
    return response()->json(['ok' => true]);
});

Route::get('/empresa', function () {
    return response()->json([
        'nome' => 'Empresa Exemplo',
        'cidade' => 'Sao Paulo'
    ]);
});

Route::get('/servicos', function () {
    return response()->json([
        'servicos' => [
            'Desenvolvimento Web',
            'Manutencao de Sistemas',
            'Suporte Tecnico'
        ]
    ]);
});