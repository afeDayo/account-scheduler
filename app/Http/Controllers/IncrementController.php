<?php

namespace App\Http\Controllers;

use App\Models\BalanceIncrement;

class IncrementController extends Controller
{
    public function index()
    {
        return BalanceIncrement::with('balance')
                    ->orderBy('created_at', 'desc')
                    ->get();
    }

    public function destroyAll()
    {
        BalanceIncrement::query()->delete();
        return response()->json(null, 204);
    }
}
